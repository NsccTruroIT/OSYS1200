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
    Write-CheckResult "User 'Matt' exists