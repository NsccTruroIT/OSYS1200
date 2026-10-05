<#
.SYNOPSIS
    A PowerShell script to validate the configuration changes made in OSYS1200 Lab 4 (Parts 1 & 2).
.DESCRIPTION
    This script checks storage devices, virtual disks, BCD settings, mount points, file/folder attributes,
    NTFS access control lists (ACLs), and network share permissions as specified in Lab 4-1 and Lab 4-2.
    It provides a simple Pass/Fail report and a summary score.
.NOTES
    Run this script with administrative privileges in PowerShell.
#>

#Requires -RunAsAdministrator

$Global:PassCount = 0
$Global:FailCount = 0

function Write-CheckResult {
    param(
        [string]$CheckName,
        [bool]$Success,
        [string]$Message = ""
    )
    if ($Success) {
        $Global:PassCount++
        Write-Host ("[PASS] - " + $CheckName) -ForegroundColor Green
    } else {
        $Global:FailCount++
        $failMsg = "[FAIL] - " + $CheckName
        if ($Message) {
            $failMsg += " | Reason: " + $Message
        }
        Write-Host $failMsg -ForegroundColor Red
    }
}

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   OSYS1200 Lab 4 Validation (Grade-A-Tron)  " -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Checking system state against Unit 4 lab requirements...`n"

#------------------------------------------------------------------------------------
## Lab 4 - Part 1: Disks and Storage Checks
#------------------------------------------------------------------------------------
Write-Host "## Lab 4 - Part 1 Checks" -ForegroundColor Yellow

# 1. Storage Directory
$storageDir = "C:\Storage"
$storageExists = Test-Path -Path $storageDir -PathType Container
Write-CheckResult "Directory 'C:\Storage' exists" $storageExists "Directory '$storageDir' was not found."

# 2. Virtual Disks in C:\Storage
$vhd2Exists = Test-Path -Path "C:\Storage\Disk2.vhdx" -PathType Leaf
Write-CheckResult "Virtual disk 'Disk2.vhdx' exists in C:\Storage" $vhd2Exists "C:\Storage\Disk2.vhdx not found."

$vhd3Exists = Test-Path -Path "C:\Storage\Disk3.vhdx" -PathType Leaf
Write-CheckResult "Virtual disk 'Disk3.vhdx' exists in C:\Storage" $vhd3Exists "C:\Storage\Disk3.vhdx not found."

$vhd4Exists = (Test-Path -Path "C:\Storage\Disk4.vhd" -PathType Leaf) -or (Test-Path -Path "C:\Storage\Disk4.vhdx" -PathType Leaf)
Write-CheckResult "Virtual disk 'Disk4' (.vhd or .vhdx) exists in C:\Storage" $vhd4Exists "Disk4 virtual disk not found in C:\Storage."

# 3. BCD Export / Backup
$bcdBackupExists = Test-Path -Path "C:\bcdbackup" -PathType Leaf
Write-CheckResult "BCD backup file 'C:\bcdbackup' exists" $bcdBackupExists "Backup file 'C:\bcdbackup' was not found."

# 4. BCD Current Boot Entry Description
try {
    $bcdOutput = bcdedit /enum "{current}" 2>&1
    $hasBcdDescription = [bool]($bcdOutput | Select-String -Pattern "My Windows Boot Entry")
    Write-CheckResult "BCD boot entry description set to 'My Windows Boot Entry'" $hasBcdDescription "Current boot loader description is not set to 'My Windows Boot Entry'."
} catch {
    Write-CheckResult "BCD boot entry description check" $false "Failed to query bcdedit: $($_.Exception.Message)"
}

#------------------------------------------------------------------------------------
## Lab 4 - Part 2: File Systems and Permissions Checks
#------------------------------------------------------------------------------------
Write-Host "`n## Lab 4 - Part 2 Checks" -ForegroundColor Yellow

# 5. Mount Point Folder C:\MyAppData
$myAppDataExists = Test-Path -Path "C:\MyAppData" -PathType Container
Write-CheckResult "Mount point folder 'C:\MyAppData' exists" $myAppDataExists "Directory 'C:\MyAppData' was not found."

# 6. File & Folder Attributes (TopSecret)
$topSecretPath = "C:\TopSecret"
if (Test-Path -Path $topSecretPath) {
    Write-CheckResult "Folder 'C:\TopSecret' exists" $true
    $item = Get-Item -LiteralPath $topSecretPath -Force
    $isHidden = [bool]($item.Attributes -band [System.IO.FileAttributes]::Hidden)
    Write-CheckResult "'C:\TopSecret' has Hidden attribute set (+h)" $isHidden "Folder attributes: $($item.Attributes)"
} else {
    Write-CheckResult "Folder 'C:\TopSecret' exists" $false "Folder '$topSecretPath' was not found."
    Write-CheckResult "'C:\TopSecret' has Hidden attribute set (+h)" $false "Folder does not exist."
}

# 7. NTFS Permissions: Marketing Documents
$marketingPath = "C:\Marketing Documents"
if (Test-Path -Path $marketingPath) {
    Write-CheckResult "Folder 'C:\Marketing Documents' exists" $true
    
    try {
        $acl = Get-Acl -LiteralPath $marketingPath
        
        # Check inheritance is disabled (AreAccessRulesProtected = $true)
        $inheritanceDisabled = $acl.AreAccessRulesProtected
        Write-CheckResult "'C:\Marketing Documents' inheritance is disabled" $inheritanceDisabled "Inherited permissions appear to still be enabled."
        
        # Check Owner is Administrators
        $owner = $acl.Owner
        $isOwnerAdmin = ($owner -like "*Administrators*")
        Write-CheckResult "'C:\Marketing Documents' owner is Administrators" $isOwnerAdmin "Current owner is '$owner'."
        
        # Check Student has FullControl explicit permission
        $studentRule = $acl.Access | Where-Object { 
            ($_.IdentityReference -like "*\Student" -or $_.IdentityReference -eq "Student") -and 
            -not $_.IsInherited -and 
            $_.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::FullControl
        }
        $hasStudentFullControl = $null -ne $studentRule
        Write-CheckResult "'Student' has explicit Full Control on 'Marketing Documents'" $hasStudentFullControl "Could not find explicit FullControl ACE for 'Student'."
        
    } catch {
        Write-CheckResult "Inspect 'C:\Marketing Documents' ACL" $false "Failed to read ACL: $($_.Exception.Message)"
    }
} else {
    Write-CheckResult "Folder 'C:\Marketing Documents' exists" $false "Directory '$marketingPath' was not found."
    Write-CheckResult "'C:\Marketing Documents' inheritance is disabled" $false "Folder does not exist."
    Write-CheckResult "'C:\Marketing Documents' owner is Administrators" $false "Folder does not exist."
    Write-CheckResult "'Student' has explicit Full Control on 'Marketing Documents'" $false "Folder does not exist."
}

# 8. Inherited File in Marketing Documents
$reportPath = "C:\Marketing Documents\First Quarter Report.txt"
$reportExists = Test-Path -Path $reportPath -PathType Leaf
Write-CheckResult "File 'First Quarter Report.txt' exists in 'C:\Marketing Documents'" $reportExists "File not found at '$reportPath'."

if ($reportExists) {
    try {
        $reportAcl = Get-Acl -LiteralPath $reportPath
        $hasInheritedRules = ($reportAcl.Access | Where-Object { $_.IsInherited }).Count -gt 0
        Write-CheckResult "'First Quarter Report.txt' inherits permissions from parent folder" $hasInheritedRules "Permissions do not appear to be inherited."
    } catch {
        Write-CheckResult "'First Quarter Report.txt' inheritance check" $false "Failed to check ACL: $($_.Exception.Message)"
    }
} else {
    Write-CheckResult "'First Quarter Report.txt' inherits permissions from parent folder" $false "File does not exist."
}

# 9. Network Share: Shared
try {
    $share = Get-SmbShare -Name "Shared" -ErrorAction Stop
    Write-CheckResult "SMB Share 'Shared' exists" $true
} catch {
    Write-CheckResult "SMB Share 'Shared' exists" $false "Share 'Shared' not found."
}

# 10. Restricted Access for 'Bad' User on TopSecret
if (Test-Path -Path $topSecretPath) {
    try {
        $tsAcl = Get-Acl -LiteralPath $topSecretPath
        $hasExplicitDeny = [bool]($tsAcl.Access | Where-Object { 
            ($_.IdentityReference -like "*\Bad" -or $_.IdentityReference -eq "Bad") -and 
            $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Deny 
        })
        
        $badAllowed = [bool]($tsAcl.Access | Where-Object {
            ($_.IdentityReference -like "*\Bad" -or $_.IdentityReference -eq "Bad" -or $_.IdentityReference -like "*Everyone") -and 
            $_.AccessControlType -eq [System.Security.AccessControl.AccessControlType]::Allow
        })
        
        $isBadRestricted = $hasExplicitDeny -or (-not $badAllowed)
        Write-CheckResult "Access to 'C:\TopSecret' is restricted for 'Bad' user" $isBadRestricted "User 'Bad' still has Allow access via group or direct ACE without Deny."
    } catch {
        Write-CheckResult "Check 'Bad' user access restriction on 'TopSecret'" $false "Failed to read ACL: $($_.Exception.Message)"
    }
} else {
    Write-CheckResult "Access to 'C:\TopSecret' is restricted for 'Bad' user" $false "Folder does not exist."
}

#------------------------------------------------------------------------------------
## Summary Score
#------------------------------------------------------------------------------------
$totalChecks = $Global:PassCount + $Global:FailCount
$scorePercent = if ($totalChecks -gt 0) { [math]::Round(($Global:PassCount / $totalChecks) * 100, 1) } else { 0 }

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "                SUMMARY SCORE                " -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Total Checks: $totalChecks"
Write-Host "Passed:       $($Global:PassCount)" -ForegroundColor Green
Write-Host "Failed:       $($Global:FailCount)" -ForegroundColor $(if ($Global:FailCount -gt 0) { "Red" } else { "Green" })
Write-Host "Score:        $scorePercent%" -ForegroundColor $(if ($scorePercent -ge 80) { "Green" } elseif ($scorePercent -ge 50) { "Yellow" } else { "Red" })
Write-Host "=============================================" -ForegroundColor Cyan
