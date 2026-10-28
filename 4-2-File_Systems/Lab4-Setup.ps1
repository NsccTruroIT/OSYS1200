<#
.SYNOPSIS
    OSYS1200 Lab 4 - Part 2 Environment Setup Script
.DESCRIPTION
    Configures and verifies the prerequisites for Lab 4-2:
    1. Creates the 'Bad' demo user account (if not already present).
    2. Creates 'C:\TopSecret' folder with baseline ACL for security testing.
    3. Creates the 'Shared' folder under C:\Users\Student\Documents\Shared (or profile Documents)
       and publishes the 'Shared' SMB share for Activity 5.
.NOTES
    Run this script with administrative privileges in PowerShell.
#>

#Requires -RunAsAdministrator

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  OSYS1200 Lab 4-2 Environment Setup Script  " -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Verifying and provisioning required lab components...`n"

# 1. Create 'Bad' user account
Write-Host "[1/3] Checking 'Bad' user account..." -ForegroundColor Yellow
$badUser = Get-LocalUser -Name "Bad" -ErrorAction SilentlyContinue
if (-not $badUser) {
    try {
        $password = ConvertTo-SecureString 'It$tudents' -AsPlainText -Force
        New-LocalUser -Name "Bad" -Password $password -FullName "Bad User" -Description "Demo User for Lab 4 Security Auditing" -PasswordNeverExpires -ErrorAction Stop | Out-Null
        Write-Host "  [OK] Created local user 'Bad'." -ForegroundColor Green
    } catch {
        Write-Warning "Failed to create user 'Bad': $($_.Exception.Message)"
    }
} else {
    Write-Host "  [INFO] User 'Bad' already exists." -ForegroundColor Gray
}

# 2. Create C:\TopSecret folder with baseline ACL
Write-Host "`n[2/3] Checking 'C:\TopSecret' folder & permissions..." -ForegroundColor Yellow
$topSecretPath = "C:\TopSecret"
if (-not (Test-Path -Path $topSecretPath)) {
    New-Item -ItemType Directory -Path $topSecretPath -Force | Out-Null
    Write-Host "  [OK] Created folder '$topSecretPath'." -ForegroundColor Green
} else {
    Write-Host "  [INFO] Folder '$topSecretPath' already exists." -ForegroundColor Gray
}

try {
    $acl = Get-Acl -Path $topSecretPath
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule (
        'Everyone',
        'FullControl',
        'ContainerInherit, ObjectInherit',
        'InheritOnly',
        'Allow'
    )
    $acl.SetAccessRule($accessRule)
    Set-Acl -Path $topSecretPath -AclObject $acl
    Write-Host "  [OK] Baseline permissions configured on '$topSecretPath'." -ForegroundColor Green
} catch {
    Write-Warning "Failed to set ACL on '$topSecretPath': $($_.Exception.Message)"
}

# 3. Create Shared folder & SMB share
Write-Host "`n[3/3] Checking 'Shared' folder & SMB share..." -ForegroundColor Yellow
$sharedPath = if (Test-Path "C:\Users\Student\Documents") {
    "C:\Users\Student\Documents\Shared"
} else {
    "$env:USERPROFILE\Documents\Shared"
}

if (-not (Test-Path -Path $sharedPath)) {
    New-Item -ItemType Directory -Path $sharedPath -Force | Out-Null
    Write-Host "  [OK] Created folder '$sharedPath'." -ForegroundColor Green
} else {
    Write-Host "  [INFO] Folder '$sharedPath' already exists." -ForegroundColor Gray
}

$existingShare = Get-SmbShare -Name "Shared" -ErrorAction SilentlyContinue
if (-not $existingShare) {
    try {
        New-SmbShare -Name "Shared" -Path $sharedPath -ChangeAccess "Users" -FullAccess "Administrators" -ErrorAction Stop | Out-Null
        Write-Host "  [OK] SMB Share 'Shared' published at '$sharedPath'." -ForegroundColor Green
    } catch {
        Write-Warning "Failed to create SMB share 'Shared': $($_.Exception.Message)"
    }
} else {
    Write-Host "  [INFO] SMB Share 'Shared' already exists pointing to '$($existingShare.Path)'." -ForegroundColor Gray
    if ($existingShare.Path -ne $sharedPath) {
        Write-Host "  [NOTICE] Updating share path to '$sharedPath'..." -ForegroundColor Yellow
        Remove-SmbShare -Name "Shared" -Force -Confirm:$false
        New-SmbShare -Name "Shared" -Path $sharedPath -ChangeAccess "Users" -FullAccess "Administrators" -ErrorAction Stop | Out-Null
        Write-Host "  [OK] SMB Share 'Shared' re-created at '$sharedPath'." -ForegroundColor Green
    }
}

Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "       Setup Completed Successfully!         " -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Your environment is ready for Lab 4-2.`n"
