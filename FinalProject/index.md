# OSYS1200 - Final Project

# Windows 11 Setup Script

🚨 **Lab Environment:** You can perform this on any Windows 11 machine. You can use your assigned Virtual Machine to avoid conflicts with your local machine. Ensure you launch PowerShell as an **Administrator (or elevate to administrator within your script)**, or many of these commands will fail due to User Account Control (UAC).

## Overview

In this assignment, you will assume the role of a Desktop Support Administrator. You have been provided with a template for a "setup script" to automate the configuration of new Windows 11 laptops for employees.

The provided template already has the required interactive menu, you must supply the required powershell commands to complete the setup tasks. (Look for the “STUDENT CODE AREA START”)

## Requirements

Your PowerShell script must include the following features:

1. **Interactive Menu:** A loop that prompts the user to select an operation (1-4) or to quit. (Template Provided)
2. **Operations:** Throughout our course we’ve seen numerous examples of using Powershell to perform common **Windows 11** client tasks, now you can apply those techniques. You may **choose 4** from the following or propose your own:
    - **Local User Management:** Create local user accounts (non-domain) for specific employees.
        - Example Code (Yes, you can use this)
            
            ```bash
            # Prompt for input
            $username = Read-Host "Enter the new local username"
            $fullName = Read-Host "Enter the user's full name"
            
            # Create password securely
            $password = Read-Host "Enter a temporary password" -AsSecureString
            
            try {
                # Check if user exists first (optional logic, or let the error catch it)
                New-LocalUser -Name $username -FullName $fullName -Password $password -PasswordNeverExpires
                Write-Host "Success: User $username created locally." -ForegroundColor Green
            }
            catch {
                Write-Host "Error: Could not create user. $($_.Exception.Message)" -ForegroundColor Red
            }
            ```
            
    - **Local Group Management:** Create a local group (e.g., "Contractors") and add users to it.
    - **System Configuration:** Set the “Computer Name” host name for Windows 11.
    - **Windows Features:** Enable client features (e.g., Hyper-V Platform, Subsystem for Linux, Telnet Client).
    - **System Maintenance:** Clean up temporary files, checking for Windows Updates, or exporting a list of installed software.
3. **Error Handling:**
    - If the user selects an invalid option, display an error.
    - Use `Try/Catch` blocks to handle errors (e.g., trying to create a user that already exists).
4. **Documentation:** 
    - Comments explaining what each cmdlet does.
    - Screenshots of successful execution

## Resources

### Suggested Cmdlets for Windows 11

Since we are not on a Server, we swap the AD modules for Local Account modules:

- **Users/Groups:** `New-LocalUser`, `New-LocalGroup`, `Add-LocalGroupMember`, `Set-LocalUser`.
- **Windows System Settings:** `Set-TimeZone` , `Set-Date`, `Rename-Computer`.
- **Networking:** `Get-NetAdapter`, `New-NetIPAddress`, `Set-DnsClientServerAddress`.
- **Features:** `Get-WindowsOptionalFeature`, `Enable-WindowsOptionalFeature`.
- **General:** `Get-ComputerInfo`, `Restart-Computer`.

### Provided Template

Script Download :

[template.ps1](template.ps1)

- Template Code
    
    ```bash
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
    ```
    

## Submission

- Upload your complete script file
- Upload screenshots of successful execution of each chosen task.

### Note on AI

- This assignment is AI friendly. Feel free  to use your preferred AI for help with creating and testing your code. As always, be sure to execute and understand anything you submit.