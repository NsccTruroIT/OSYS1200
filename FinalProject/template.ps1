<#
.SYNOPSIS
    Windows 11 Client Provisioning Automation
.DESCRIPTION
    A menu-driven script to automate local Windows 11 administrative tasks.
    Students must implement specific operations within the switch statement.
.NOTES
    Author: [Student Name]
    Date:   [Current Date]
#>

# ==========================================
# 1. PRE-FLIGHT CHECK: ADMINISTRATOR PRIVILEGES
# ==========================================
# This block ensures the script is running with elevated permissions.
# If not, it warns the user and exits immediately to prevent errors.
$currentPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "🚨 PERMISSION ERROR: This script must be run as Administrator."
    Write-Warning "Please right-click PowerShell and select 'Run as Administrator'."
    Start-Sleep -Seconds 5
    Exit
}

# ==========================================
# 2. MENU FUNCTION
# ==========================================
function Show-Menu {
    # Clear-Host keeps the terminal clean for the user
    Clear-Host
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "   WINDOWS 11 CLIENT PROVISIONING TOOL" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "1. [Operation 1 Name] (e.g., Create Local User)"
    Write-Host "2. [Operation 2 Name]"
    Write-Host "3. [Operation 3 Name]"
    Write-Host "4. [Operation 4 Name]"
    Write-Host "5. [Operation 5 Name]"
    Write-Host "Q. Quit / Exit"
    Write-Host "================================================" -ForegroundColor Cyan
}

# ==========================================
# 3. MAIN EXECUTION LOOP
# ==========================================

# Variable to control the loop state
$keepRunning = $true

while ($keepRunning) {
    # 1. Display the Menu
    Show-Menu

    # 2. Capture User Input
    $userInput = Read-Host "Select an operation"

    # 3. Process Input
    switch ($userInput) {
        '1' {
            Write-Host "Initializing Operation 1..." -ForegroundColor Yellow
            
            # --- STUDENT CODE AREA START ---
            # TODO: Paste your code for Operation 1 here.
            # Requirement: Use Try/Catch blocks.
            
            try {
                # EXAMPLE: $username = Read-Host "Enter Username"
                # EXAMPLE: New-LocalUser -Name $username
                Write-Host "placeholder for operation 1"
            }
            catch {
                Write-Error "An error occurred in Operation 1: $_"
            }
            # --- STUDENT CODE AREA END ---

            Pause # Waits for user to press Enter before clearing screen
        }

        '2' {
            Write-Host "Initializing Operation 2..." -ForegroundColor Yellow
            
            # --- STUDENT CODE AREA START ---
            # TODO: Insert code for Operation 2 here
            # --- STUDENT CODE AREA END ---

            Pause
        }

        '3' {
            Write-Host "Initializing Operation 3..." -ForegroundColor Yellow
            
            # --- STUDENT CODE AREA START ---
            # TODO: Insert code for Operation 3 here
            # --- STUDENT CODE AREA END ---
            
            Pause
        }

        '4' {
            Write-Host "Initializing Operation 4..." -ForegroundColor Yellow
            
            # --- STUDENT CODE AREA START ---
            # TODO: Insert code for Operation 4 here
            # --- STUDENT CODE AREA END ---
            
            Pause
        }

        '5' {
            Write-Host "Initializing Operation 5..." -ForegroundColor Yellow
            
            # --- STUDENT CODE AREA START ---
            # TODO: Insert code for Operation 5 here
            # --- STUDENT CODE AREA END ---
            
            Pause
        }

        { $_ -in 'Q', 'q', '6' } { 
            # Handles Q, q, or 6 to exit
            Write-Host "Exiting script. Goodbye!" -ForegroundColor Green
            $keepRunning = $false 
        }

        Default { 
            # Handles any input that isn't 1-5 or Q
            Write-Warning "Invalid selection. Please choose 1-5 or Q to quit."
            Start-Sleep -Seconds 2
        }
    }
}