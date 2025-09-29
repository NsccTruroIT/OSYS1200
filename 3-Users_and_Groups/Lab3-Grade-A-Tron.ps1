<#
.SYNOPSIS
    A PowerShell script to validate the configuration changes made in OSYS1200 Lab 3.
.DESCRIPTION
    This script checks for the creation and configuration of users, groups, files, and
    folders as specified in the lab instructions. It provides a simple Pass/Fail
    report for each check.
.NOTES
    Run this script with administrative privileges.
#>

#Requires -RunAsAdministrator

# Helper function to display the result of a check in a consistent format.
function Write-CheckResult {
    param(
        [string]$CheckName,
        [bool]$Success,
        [string]$Message
    )
    if ($Success) {
        Write-Host ("[PASS] - " + $CheckName) -ForegroundColor Green
    } else {
        Write-Host ("[FAIL] - " + $CheckName + " | Reason: " + $Message) -ForegroundColor Red
    }
}

# --- Main Script ---
Write-Host "--- OSYS1200 Lab 3 Validation Script ---" -ForegroundColor Cyan
Write-Host "Checking system state against lab requirements..."

#------------------------------------------------------------------------------------
## Activity 1: User and Group Creation
#------------------------------------------------------------------------------------
Write-Host "`n## Activity 1 Checks" -ForegroundColor Yellow

# Check for user 'Matt' and his properties.
try {
    $userMatt = Get-LocalUser -Name "Matt" -ErrorAction Stop
    Write-CheckResult "User 'Matt' exists" $true
    
    $isFullNameCorrect = $userMatt.FullName -eq "Matt Redmond"
    Write-CheckResult "Matt's Full Name is 'Matt Redmond'" $isFullNameCorrect "Expected 'Matt Redmond', but found '$($userMatt.FullName)'"
} catch {
    Write-CheckResult "User 'Matt' exists" $false "User not found."
    Write-CheckResult "Matt's Full Name is 'Matt Redmond'" $false "Cannot check; user not found."
}

# Check for user 'Jacob' and his properties.
try {
    $userJacob = Get-LocalUser -Name "Jacob" -ErrorAction Stop
    Write-CheckResult "User 'Jacob' exists" $true

    $isFullNameCorrect = $userJacob.FullName -eq "Jacob Smith"
    Write-CheckResult "Jacob's Full Name is 'Jacob Smith'" $isFullNameCorrect "Expected 'Jacob Smith', but found '$($userJacob.FullName)'"

    $isDescCorrect = $userJacob.Description -eq "Test User Account"
    Write-CheckResult "Jacob's Description is 'Test User Account'" $isDescCorrect "Expected 'Test User Account', but found '$($userJacob.Description)'"

    $isDisabled = -not $userJacob.Enabled
    Write-CheckResult "Jacob's account is disabled" $isDisabled "Account is currently enabled, but should be disabled."

} catch {
    Write-CheckResult "User 'Jacob' exists" $false "User not found."
    Write-CheckResult "Jacob's Full Name is 'Jacob Smith'" $false "Cannot check; user not found."
    Write-CheckResult "Jacob's Description is 'Test User Account'" $false "Cannot check; user not found."
    Write-CheckResult "Jacob's account is disabled" $false "Cannot check; user not found."
}

# Check for 'TestGroup' and Jacob's membership.
try {
    $null = Get-LocalGroup -Name "TestGroup" -ErrorAction Stop
    Write-CheckResult "Group 'TestGroup' exists" $true

    $members = Get-LocalGroupMember -Group "TestGroup" -ErrorAction SilentlyContinue
    # <-- CORRECTED CHECK -->
    $isJacobMember = "Jacob" -in @($members.Name)
    Write-CheckResult "Jacob is a member of 'TestGroup'" $isJacobMember "User 'Jacob' was not found in the group."

} catch {
    Write-CheckResult "Group 'TestGroup' exists" $false "Group not found."
    Write-CheckResult "Jacob is a member of 'TestGroup'" $false "Cannot check; group not found."
}

# Check Jacob's membership in 'Remote Desktop Users'.
try {
    # This check requires both the user 'Jacob' and the group to exist.
    $null = Get-LocalUser -Name "Jacob" -ErrorAction Stop
    $members = Get-LocalGroupMember -Group "Remote Desktop Users" -ErrorAction Stop
    # <-- CORRECTED CHECK -->
    $isJacobRdpMember = "Jacob" -in @($members.Name)
    Write-CheckResult "Jacob is a member of 'Remote Desktop Users'" $isJacobRdpMember "User 'Jacob' was not found in the group."
} catch {
    Write-CheckResult "Jacob is a member of 'Remote Desktop Users'" $false "Could not perform check. User 'Jacob' or group 'Remote Desktop Users' may not exist."
}

#------------------------------------------------------------------------------------
## Activity 2: Password Reset
#------------------------------------------------------------------------------------
Write-Host "`n## Activity 2 Checks" -ForegroundColor Yellow

# Check for the PowerShell history file from the new step.
$historyPath = "C:\Users\itstudent\Documents\ps-history.txt"
$historyFileExists = Test-Path -Path $historyPath -PathType Leaf
Write-CheckResult "PowerShell history file 'ps-history.txt' exists" $historyFileExists "File not found at '$historyPath'."

#------------------------------------------------------------------------------------
## Activity 3: Profile Management
#------------------------------------------------------------------------------------
Write-Host "`n## Activity 3 Checks" -ForegroundColor Yellow
$publicDesktopPath = "C:\Users\Public\Public Desktop"
$shortcuts = Get-ChildItem -Path $publicDesktopPath -Filter "*.lnk" -ErrorAction SilentlyContinue
$shortcutExists = $null -ne $shortcuts -and $shortcuts.Count -gt 0
Write-CheckResult "A shortcut exists in the Public Desktop folder" $shortcutExists "No shortcut (.lnk) files were found in '$publicDesktopPath'."

#------------------------------------------------------------------------------------
## Activity 4: Start Menu Mastery
#------------------------------------------------------------------------------------
Write-Host "`n## Activity 4 Checks" -ForegroundColor Yellow
$startPath = "C:\Start"
$pathExists = Test-Path -Path $startPath -PathType Container
Write-CheckResult "Directory 'C:\Start' exists" $pathExists "Directory not found."

$jsonPath = "C:\Start\StartMenuLayout.json"
$fileExists = Test-Path -Path $jsonPath -PathType Leaf
Write-CheckResult "File 'StartMenuLayout.json' exists" $fileExists "File not found in C:\Start."

# Check if the Group Policy was reverted to "Not Configured".
# This means the specified registry value should NOT exist.
$regPath = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
$regValueName = "StartLayoutFile"
$policyReverted = $true
if (Test-Path $regPath) {
    $policySetting = Get-ItemProperty -Path $regPath -Name $regValueName -ErrorAction SilentlyContinue
    if ($null -ne $policySetting) {
        $policyReverted = false
    }
}
Write-CheckResult "Start Layout Group Policy is reverted" $policyReverted "Policy appears to be enabled. Registry value '$regValueName' is still present."

#------------------------------------------------------------------------------------
## Activity 5: Groups
#------------------------------------------------------------------------------------
Write-Host "`n## Activity 5 Checks" -ForegroundColor Yellow

# Check for group 'redteam' and its properties.
# Note: Membership is not checked as the user 'Bad' was not created in the lab.
try {
    $groupRed = Get-LocalGroup -Name "redteam" -ErrorAction Stop
    Write-CheckResult "Group 'redteam' exists" $true

    # Check if the description is not empty, instead of checking for a specific long string.
    $hasDescription = -not ([string]::IsNullOrWhiteSpace($groupRed.Description))
    Write-CheckResult "'redteam' group has a description" $hasDescription "Group description is empty."

} catch {
    Write-CheckResult "Group 'redteam' exists" $false "Group not found."
    Write-CheckResult "'redteam' group has a description" $false "Cannot check; group not found."
}

# Check for group 'blueteam' and its properties.
try {
    $groupBlue = Get-LocalGroup -Name "blueteam" -ErrorAction Stop
    Write-CheckResult "Group 'blueteam' exists" $true
    
    # Check if the description is not empty, instead of checking for a specific long string.
    $hasDescription = -not ([string]::IsNullOrWhiteSpace($groupBlue.Description))
    Write-CheckResult "'blueteam' group has a description" $hasDescription "Group description is empty."

    $members = Get-LocalGroupMember -Group "blueteam" -ErrorAction SilentlyContinue
    # <-- CORRECTED CHECK -->
    $isJacobMember = "Jacob" -in @($members.Name)
    Write-CheckResult "Jacob is a member of 'blueteam'" $isJacobMember "User 'Jacob' was not found in the group."
} catch {
    Write-CheckResult "Group 'blueteam' exists" $false "Group not found."
    Write-CheckResult "'blueteam' group has a description" $false "Cannot check; group not found."
    Write-CheckResult "Jacob is a member of 'blueteam'" $false "Cannot check; group not found."
}

Write-Host "`n--- Validation Complete ---" -ForegroundColor Cyan