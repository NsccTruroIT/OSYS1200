# OSYS1200 Lab 5

Last Updated: Fall 2026
Created By: Matt Redmond
Course: OSYS1200
Status: Complete

## Activity 1 – Password C0mpl3xity (← so weak)

No doubt the importance of a password manager has already been impressed upon you.

- ICYMI: Up your password game!
    
    Strong, unique passwords can help reduce your vulnerability and mitigate the impact of compromised accounts. As an IT professional it is unrealistic to expect to be able to manage complex passwords that are unique for each of the hundreds of personal & professional accounts you’ll be expected to maintain. 
    
    1. Conduct some research on “[Password Managers](https://en.wikipedia.org/wiki/List_of_password_managers)”. We discussed a few popular examples in class:
        1. Bitwarden - My current choice
        2. 1Password - My previous fav (small bonus for being Canadian 🍁)
        3. Lastpass - greasy business moves made them dead to me, but lots of people still love it
        4. KeyPass - Open Source goodness!
    2.  Once you’ve made a decision, consult their documentation to get started migrating you password and setting up clients for your laptop, mobile devices and browsers.
    
    <aside>
    🔑 Don’t worry… this is not a life decision. All password managers will support exporting your data if you choose to move to a different product later.
    
    </aside>
    

If you have previously set up your password manager, this is just a reminder to always use it! There will be an expectation that everyone will use a password manager going forward. So it’s in your best interest to set it up now!

1. Use your password manager (not an online generator) to generate a new password. The strongest password it can!
2. The password must meet the following criteria:
    1. Minimum Characters: 128 (or as many as possible)
    2. Upper case and lowercase characters: As many as supported
    3. Numbers: 9 (or as many as possible)
    4. Special Character: 9 (or as many as possible)
    
    Here is an example from bitwarden, but all managers will have a similar capability:
    
    ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled.png)
    
    <aside>
    💡 What are ambiguous characters? You know that lower case l (L) that looks exactly like an uppercase I (i)… yeah annoying, but does it really matter? That only becomes an issue if you are trying to share a password or enter it manually. Both of which should be avoided.
    
    </aside>
    
3. **Submit your password!**

### Part B - Using Passwords

One of the big advantages of your new password manager is the ability to use your passwords easily on a variety of devices. **Demonstrate** how you can use a stored password using **any two** of the following methods:

- [Browser Extension](https://bitwarden.com/help/getting-started-browserext/)
- [Mobile App](https://bitwarden.com/help/getting-started-mobile/)
- [Desktop App](https://bitwarden.com/help/getting-started-desktop/)
- Web Interface (logging in via the web)

## Activity 2 - Trusted Applications
1. Download this file:
     [PowerToys](https://github.com/microsoft/PowerToys/releases/download/v0.95.0/PowerToysUserSetup-0.95.0-x64.exe)
1. **Double click** the download to install.
1. Accept defaults.
1. **Wait**... did you just install something you downloaded from a reandom git repo? That's not smart.
1. It's a little later now, but we should make sure it hasn't been tampered with. SHA hashing provides a solution. Software vendors usually provide the original SHA Hashes so you can confirm your's matches their original. This one should be:

    `F2B57F03575591591192DC486162F5FA113079F515A48E9ED6B3E2ABE0FE81E3`
1. Check your downloaded file by opening **Powershell** and navigating to your downloads folder (or wherever you save the file above):

   `cd ~/Downloads`
1. Now generate an SHA 256 hash from the file:

   `Get-FileHash PowerToysUserSetup-0.95.0-x64.exe -Algorithm SHA256`

1. Does the output match? If it does, you're file is that same as the one the vendor provided. Phew. 
1. But, what if we did tamper with it? Let's inject some malicious text!

    `Add-Content -Path ".\PowerToysUserSetup-0.95.0-x64.exe" -Value "rm / -rf"`
1. Now let's generate an SHA 256 hash from the file again:

   `Get-FileHash PowerToysUserSetup-0.95.0-x64.exe -Algorithm SHA256`

1. Ahah! This has does not match the hash provided by the vendor! Even the slightest modification to the source file will result in a significantly different Hash.

### Since you already installed it.... Check out Powertoys! Thank me later!

## Activity 3 – Configure a Local Security Policy

This will likely work best if done on your proxmox VM.

1. Click the Start button, type Local, and then click Local Security Policy.
2. Right click on **Security Settings** and choose **Export policy…**

    ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%201.png)

1. Click **Desktop** to select the location and in the **File name** box enter `secpolBackup.inf` and click **save**.
2. In the Local Security Policy window, in the left pane, expand **Account Policies**, and then click **Password Policies**.
3. Double-click to open **Minimum password length**.
4. In the select box, enter **8**.  **Grab a screenshot** and then click OK.
5. Let’s test it out! Right-click the **Start** button and choose **Computer Management**.
6. Expand **Local Users and Groups** and click on **Users.**
7. Right-click **Bad** and choose  **Set Password**.

> [!TIP]
> If you do not already have the local user account **Bad** on your VM from Lab 4, run in PowerShell (Admin):
> `powershell
> New-LocalUser -Name 'Bad' -NoPassword
> `

8. Ah Warning! Meh… Click **Proceed.**
9. Enter the new password `12345` and then again… and then click **ok**. **Screenshot the results!** Click **ok →cancel.**
10. Remember the default expiry of 42 days? Let’s see why that might not always apply. Right-click **Bad** again and choose **Properties**.
11. **What setting changes might be required in order to enforce the password expiry?**
12. **Document the steps to use the** **secpolBackup.inf we create in step one to revert your changes.** 
13. Leave **Local Security Policy** open for the next activity.

## Activity 4 – Auditing

- Without auditing, you’re working in the dark (with the lights out, and no back-lit keyboard, um and no display, errr you get what I’m trying to say).
1. Open **Windows PowerShell (Admin)**.
2. In the User Account Control dialog box, click **Yes**.
3. At the Windows PowerShell prompt, type `auditpol /get /category:*` and then press Enter. This displays a list of all the advanced audit policy settings and their configurations.
4. Read the list of policy settings that are enabled. **Grab a screenshot!**  (don’t worry if you can’t see them all.) This is the default configuration for Windows 10. Notice that below Object Access, File System auditing is not enabled. After you enable policy settings in the local security policy, these settings are removed, and only the settings explicitly applied in the policy are effective.
5. Close the Windows PowerShell prompt window.
6. If needed, click the **Start** button, type **local**, and then click **Local Security Policy**.
7. In the left pane, expand **Local Policies** and then click **Audit Policy**. Review the list of categories for basic auditing and notice that none is enabled in the local security policy.
8. In the left pane, expand **Advanced Audit Policy Configuration**, expand **System Audit Policies - Local Group Policy Object**, and then click Object Access.
        
     ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%202.png)
        
    
1. Double-click **Audit File System**. This option enables auditing for file access.
2. In the Audit File System Properties dialog box, select the **Configure the following audit events** check box and then select the **Success and Failure** check boxes.
3. Click the **Explain tab**, read the explanation, and then click OK. The system is now able to track successful file access when users have permission to access a file and unsuccessful file access when users do not have permission to access a file; however, auditing must still be enabled for the individual files. **Take a Screenshot**
4. Close Local Security Policy, and close all open windows.
5. On the **taskbar**, click **File Explorer** and then click **Documents**.
6. Right-click an open area in the **Name column**, point to **New**, and then click **Text Document**.
7. Type `Audit` and then press **Enter**.
8. Right-click **Audit**, click **Properties**, and then click the **Security tab**.
9. In the Audit Properties dialog box, click **Advanced** and then click the **Auditing tab**. Notice that no auditing is configured by default.
10. You may need to click on Continue to get admin access. Click **Add**, click Select a **principal**, type `Everyone`, click **Check Names**, and then click **OK**. This configures auditing to track access by all users. You can limit auditing to certain users or groups. 
11. In the **Drop Down** box, select **All**. This configures auditing of successful and failed access.
12. Below Basic permissions, select the **Full control** check box. This configures auditing to track all changes to the file.
13. **Grab a screenshot** and then click **OK** three times to close all open dialog boxes.
14. Double-click **Audit** to open the file and then **add some content** to the file. Press **CTRL+s** to save.
15. Close the File Explorer window.
16. Right-click the Start button and then click Computer Management.
17. In the left pane, expand **Event Viewer,** expand **Windows Logs**, and then click **Security**. This displays all the events in the security log.
18. Right-click **Security** and then click **Filter Current Log**.
19. In the **Event sources box**, select **Microsoft Windows security auditing**.
20. In the **<All Event IDs>** box, type `4663` and then click **OK**. Notice that multiple events are listed. These events were generated by editing the file.

    ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%207.png)

21. Starting with the first event, read the Account Name identified in the event. Continue down until the Account Name referenced is **itstudent**. Read the description of the event. The description indicates that a file was written by itstudent, the file opened was Audit.txt; and the program used to write the file was notepad.exe. **Grab a Screenshot!**
22. Close the Computer Management window.

## Activity 5 – Defender!

**DESCRIPTION:** Windows Defender Antivirus is used to prevent malware installation and remove threats. You can safely test anti-malware software using the **EICAR anti-malware test file**—a standardized 68-character benign test string that all commercial antivirus software recognizes as a threat without posing any actual risk. 

In this activity, you will test:
1. **Web Download Protection** (Edge & SmartScreen blocking malicious downloads)
2. **Local Real-Time Protection** (minifilter driver blocking file creation on disk)
3. **On-Demand Scanning** (scanning dormant files on disk)
4. **Administrative Auditing via PowerShell**

---

### Part 1: Test Web Download Protection (Edge & SmartScreen)

1. Open **Microsoft Edge** inside your student VM.
2. Download the test archive **`eicar_test_file.zip`**:
   * **Primary Source:** Download the **`eicar_test_file.zip`** attached directly on the **Notion Course Hub** lab page.
   * **Mirror Source (GitHub Raw):** If downloading outside Notion, use the direct GitHub mirror:
     [Download eicar_test_file.zip (GitHub Mirror)](https://raw.githubusercontent.com/fire1ce/eicar-standard-antivirus-test-files/master/eicar-standard-antivirus-test-file.zip)
3. When Edge begins the download, observe the browser alert:
   * Edge SmartScreen and Windows Defender will immediately flag the download as dangerous (`eicar_test_file.zip was blocked because it could harm your device`).
4. **Grab a screenshot** of the blocked download notification in Edge!

---

### Part 2: Test Real-Time Protection (Local File Creation)

Even if an attacker bypasses the browser or brings malware in via another method, Defender's real-time minifilter driver intercepts any file written to disk.

1. Click the **Start** button and type **Notepad**. Open it.
2. Copy the exact 68-character EICAR test string below and paste it into the blank Notepad file (ensure there are no extra spaces or line breaks):
   ```
   X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*
   ```
   *(Alternatively, in an elevated PowerShell window, you can run:*  
   `Set-Content -Path "$HOME\Downloads\eicar.com" -Value 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'`*)*
3. In Notepad, click **File > Save As...**.
4. Set the destination to your **Downloads** folder, change "Save as type" to **"All Files (*.*)"**, and enter the file name: **`eicar.com`**.
5. Click **Save**.
6. Almost instantly, Windows Defender will intercept the write. The save will fail or be aborted, and a Windows Security toast notification will appear in the bottom-right corner.
7. Click the notification (or open **Windows Security > Protection history**). You will see the detected threat: `Virus:DOS/EICAR_Test_File`.
8. **Grab a screenshot** showing the real-time detection in Windows Security!

---

### Part 3: Test On-Demand Scanning (Bypassing Real-Time to Stage the File)

To test an on-demand scan, we will temporarily disable Real-Time Protection, stage the file, re-enable protection, and scan for it.

1. Click **Start > Settings > Privacy & security > Windows Security** (or search **Windows Security** in Start).
2. Click **Virus & threat protection**.
3. Under **Virus & threat protection settings**, click **Manage settings**.
4. Toggle **Real-time protection** to **Off** (confirm **Yes** at the UAC prompt).
5. Return to **Notepad** (with the EICAR string still present) and click **File > Save As...**.
6. Save the file as **`eicar.com`** in your **Downloads** folder (with "Save as type" set to "All Files").
7. This time, the file will save cleanly. Open File Explorer and verify that `eicar.com` is present in your Downloads folder.
8. Return to the Windows Security window and toggle **Real-time protection** back to **On**.  
   *(Notice that the file is not immediately removed because it has not been executed or accessed yet).*
9. In the left navigation pane of Windows Security, click **Virus & threat protection** and click **Scan options**.
10. Select **Custom scan** and click **Scan now**.
11. In the folder browser, select **Local Disk (C:) > Users**, and click **Select Folder**.
12. When the scan finishes, Defender flags the dormant EICAR file. Click **Virus:DOS/EICAR_Test_File** and click **See details** (confirming UAC).
13. **Grab a screenshot** showing the custom scan detection details!
14. Click **Start actions** to allow Defender to remediate/quarantine the file.

---

### Part 4: Review Detections in Administrative PowerShell

1. Close all open windows.
2. Right-click the **Start** button and select **Terminal (Admin)** or **Windows PowerShell (Admin)**. Click **Yes** at the UAC prompt.
3. At the PowerShell prompt, inspect recorded threat instances:
   ```powershell
   Get-MpThreat
   ```
   **Grab a screenshot** of the detected threat output!
4. Query historical threat telemetry:
   ```powershell
   Get-MpThreatDetection
   ```
5. Inspect the current Defender configuration preferences:
   ```powershell
   Get-MpPreference | Select-Object -Property DisableRealtimeMonitoring, DisableBehaviorMonitoring, ControlledFolderAccessProtectedFolders
   ```
6. Check overall engine status, signature versions, and engine health:
   ```powershell
   Get-MpComputerStatus | Select-Object -Property AntivirusEnabled, RealTimeProtectionEnabled, AntivirusSignatureAge, AntivirusSignatureLastUpdated
   ```
   **Grab a screenshot!**
7. Close the PowerShell window.

## Activity 6 - Advanced Threat Protection 😲

Sounds scary, but this is a great opportunity to explore a variety of best practices for mitigating threats. Most of these have already been implemented by Windows or Edge.

Check out the [Defender ATP](https://demo.wd.microsoft.com/?ocid=cx-wddocs-testground) features.. these are pretty easy to explore by downloading a variety of files. Complete each of the following and **document the results**:

1. [URL Reputation](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-smartscreen-url-reputation)
    1. Expected Results: each page will trigger some type of warning or block content.
    2. **Screenshot and document the results**
2. [Cloud Delivered Protection](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-cloud-delivered-protection)
    1. Expected Result: Download is Blocked
    2. **Screenshot and document the results**
3. [Block at First Sight (sign in with NSCC account)](https://demo.wd.microsoft.com/Page/BAFS)
    1. Expected Results: Warning message and options to delete, keep, report… etc.
    2. Link to Upadted BAFS information: [block at first sight](https://learn.microsoft.com/en-us/defender-endpoint/configure-block-at-first-sight-microsoft-defender-antivirus?ocid=wd-av-demo-fl-bottom)
    2. **Screenshot and document the results**
4. [Potentially Unwanted Apps](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-potentially-unwanted-applications)
    1. Expected Results: Different warning message and options to delete, keep, report… etc.
    2. **Screenshot and document the results**
5. [Controlled Folder Access](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-controlled-folder-access)
    - Expected Result (Scenario 1):
    About five seconds after executing the ransomware test file, you should see a notification that CFA blocked the encryption attempt
        
        ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%204.png)
        
    - Expected Result (Scenerio 2): The files in c:\demo are encrypted and you should get a warning message.
Execute the ransomware test file again to decrypt the files
        
        ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%205.png)
        
    
        ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%206.png)

         **Screenshot and document the results**
    
6. [Network Protection](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-network-protection)
    1. Expected Result: Navigation to the website should be blocked and you should see a Connection blocked notification.
    2. **Screenshot and document the results**
7. [Exploit Protection](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-exploit-protection) (Optional)
    **Screenshot and document the results**
8. [Attack Surface Reduction](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-attack-surface-reduction-rules) (Optional - but don’t be scared!)
    **Screenshot and document the results**

## Activity 7 – Windows Defender Credential Guard & Virtualization-Based Security (VBS)

Even if an attacker gains full Local Administrator rights on a Windows system, their immediate next objective is usually **credential dumping**—extracting plaintext passwords, NTLM hashes, and Kerberos tickets directly from memory used by the Local Security Authority Subsystem Service (`lsass.exe`). Tools like Mimikatz historically made this trivial for Pass-the-Hash and Pass-the-Ticket attacks.

**Enter Credential Guard:**
Windows Defender Credential Guard uses **Virtualization-Based Security (VBS)** to move sensitive credential storage into an isolated Virtual Secure Mode (VSM) enclave known as **`LSAIso.exe`** (Isolated LSA). The standard Windows OS and `lsass.exe` communicate with the isolated enclave via RPC calls, but the host operating system kernel itself cannot directly access the memory inside the VSM container. Even kernel-level malware or rootkits cannot read those secrets!

Starting with Windows 11 Enterprise and Pro (version 22H2+), Credential Guard is **enabled by default** on supported hardware that has Secure Boot, TPM 2.0, and CPU Virtualization extensions enabled.

---

### Step 1: Check Credential Guard Status in System Information (`msinfo32`)

1. Press `Win + R`, type `msinfo32`, and press **Enter** (or search for **System Information** in the Start Menu).
2. Ensure **System Summary** is selected in the left pane.
3. Scroll down in the right pane to find the **Virtualization-based security** properties:
   - **Virtualization-based security**: Should display `Running` (or `Enabled`).
   - **Virtualization-based security Services Configured**: Check if `Credential Guard` is listed.
   - **Virtualization-based security Services Running**: Check if `Credential Guard` is listed.
4. **Grab a screenshot** showing your System Information summary with these fields clearly visible!

---

### Step 2: Query Credential Guard State via PowerShell (Admin)

Admins and security engineers automate verification using WMI/CIM instead of clicking through GUI menus.

1. Open **Windows PowerShell (Admin)**.
2. Run the following command to query the `Win32_DeviceGuard` CIM instance:

   ```powershell
   Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard | Select-Object VirtualizationBasedSecurityStatus, SecurityServicesConfigured, SecurityServicesRunning, RequiredSecurityProperties
   ```

3. Interpret the output:
   - `VirtualizationBasedSecurityStatus`: Value `2` means VBS is currently **Running** (`0` = Not enabled, `1` = Configured but not running, `2` = Running).
   - `SecurityServicesRunning`: An array of numeric IDs for running VBS services. Value **`1`** corresponds to **Credential Guard**, and **`2`** corresponds to **Hypervisor-Enforced Code Integrity (HVCI)**.
4. For a cleaner, human-readable check, run:

   ```powershell
   $dg = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard
   [PSCustomObject]@{
       "VBS Status" = switch ($dg.VirtualizationBasedSecurityStatus) { 0 {"Disabled"} 1 {"Configured"} 2 {"Running"} default {"Unknown"} }
       "Credential Guard Running" = ($dg.SecurityServicesRunning -contains 1)
       "HVCI / Memory Integrity"   = ($dg.SecurityServicesRunning -contains 2)
   }
   ```

5. **Grab a screenshot** of your PowerShell terminal showing the command output!

---

### Step 3: Inspect Core Isolation & Memory Integrity in Windows Security

1. Open the **Start Menu**, search for **Windows Security**, and open it.
2. In the left navigation, click **Device security**.
3. Under **Core isolation**, click **Core isolation details**.
4. Confirm whether **Memory integrity** (Hypervisor-Protected Code Integrity / HVCI) is toggled **On**.
5. **Grab a screenshot** of the Core Isolation details screen!

---

### Reflection Questions (Include in your Lab Report):

1. **What specific class of cyberattacks does Credential Guard prevent, and how does it prevent an attacker who already has Local Administrator privileges from stealing credentials?**
2. **What underlying hardware and virtualization features must be enabled in the UEFI/BIOS and hypervisor (like Proxmox or Hyper-V) for Credential Guard and VBS to function?**
