# OSYS1200 Lab 5

Last Updated: October 19, 2024 8:51 AM
Created By: Matt Redmond Edit Don Geraghty
Course: OSYS1200
Status: incomplete

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

DESCRIPTION: Windows Defender Antivirus is used to prevent malware installation and remove malware. You can test the functionality of anti-malware software by using the EICAR anti-malware test file. The test file has a specific text string that all anti-malware software detects but poses no risk of a malware infection. In this activity, you test real-time scanning and on-demand scanning.

1. If necessary, start your computer and sign in.
2. On the **taskbar**, click **Microsoft Edge**.
3. In the Search or enter web address box, type `www.eicar.org` and then press Enter.
4. On the Eicar website, click the DOWNLOAD ANTI MALWARE TESTFILE icon in the upper-right corner and then click DOWNLOAD in the left navigation menu.
5. On the Download page, scroll down and below the **Download** area using the secure, SSL enabled protocol https heading, click **eicar_com.zip** and then click **Save**. You should be notified that Windows Defender detected malware and deleted it. **Grab a screenshot!**
6. Click on the **three dots** in the upper right corner and click **settings** and type `smart` in the search box.
7. Find “Microsoft Defender Smart Screen” and toggle it **off**.

    ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%203.png)

1. Click **eicar_com.zip** again to download the file. Still blocked?
2. Leave the Microsoft Edge window open for later in this activity.
3. Click the **Start** button and then click **Settings**.
4. In the Settings window, click **Update & Security** and then click **Windows Security**.
5. On the **Windows Security** screen, click **Virus & threat protection**.
6. In the **Windows Security** window, below **Virus & threat protection** settings, click **Manage settings**.
7. Click the **Real-time protection** switch to turn it **Off**. If necessary, click Yes in the User Account Control prompt to confirm the action.
8. In Microsoft Edge, click **eicar_com.zip** and then click **Save**. If the download still fails, click the three dots and choose **Keep**. 
9. Click Open folder and verify that the file is downloaded.
10. In the Windows Security window, click the Real-time protection switch to turn it On. Notice that the eicar_com.zip file is not detected immediately because the file hasn’t been accessed yet.
11. In the left navigation pane, click Virus & threat protection and then click Scan options.
12. On the Scan options screen, click Custom scan and then click Scan now.
13. In the Select Folder dialog box, browse to Local Disk (C:), select the Users folder, and then click Select Folder.
14. When the scan is complete, the EICAR test file is shown as a detected threat. Click Virus:DOS/EICAR_Test_File to view the details.
15. Click See details and then click Yes in the User Account Control prompt. **Grab a screenshot!**
16. Read the detailed information about the EICAR test file and then click OK.
17. Click Start actions to apply the default action.
18. Close all open windows.
19. Click the Start button, type PowerShell, right-click Windows PowerShell, and then click Run as administrator.
20. In the User Account Control dialog box, click Yes.
21. At the Windows PowerShell prompt, type `Get-MpThreat` and then press Enter. Read the threat information. **Grab a screenshot!**
22. At the Windows PowerShell prompt, type `Get-MpThreatDetection` and then press Enter. Read the threat detection information.
23. At the Windows PowerShell prompt, type `Get-MpPreference` and then press Enter. Read the configuration information.
24. At the Windows PowerShell prompt, type `Get-MpComputerStatus` and then press Enter. Read the status information. **Grab a screenshot!**
25. Close the Windows PowerShell window.

## Activity 6 - Advanced Threat Protection 😲

Sounds scary, but this is a great opportunity to explore a variety of best practices for mitigating threats. Most of these have already been implemented by Windows or Edge.

Check out the [Defender ATP](https://demo.wd.microsoft.com/?ocid=cx-wddocs-testground) features.. these are pretty easy to explore by downloading a variety of files. Complete each of the following and **document the results**:

1. [URL Reputation](https://demo.wd.microsoft.com/Page/UrlRep)
    1. Expected Results: each page will trigger some type of warning or block content.
2. [Cloud Delivered Protection](https://demo.wd.microsoft.com/Page/CloudBlock)
    1. Expected Result: Download is Blocked
3. [Block at First Sight (sign in with NSCC account)](https://demo.wd.microsoft.com/Page/BAFS)
    1. Expected Results: Warning message and options to delete, keep, report… etc.
4. [Potentially Unwanted Apps](https://demo.wd.microsoft.com/Page/PUA)
    1. Expected Results: Different warning message and options to delete, keep, report… etc.
5. [Controlled Folder Access](https://demo.wd.microsoft.com/Page/CFA)
    - Expected Result (Scenario 1):
        
        ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%204.png)
        
    - Expected Result (Scenerio 2):
        
        ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%205.png)
        
    
    ![Untitled](OSYS1200%20Lab%206%20fecc521bed2a4eefaeb3df3bc5fd961e/Untitled%206.png)
    
6. [Network Protection](https://demo.wd.microsoft.com/Page/NP)
    1. Expected Result: Test with Chrome - Page does not  load and notification “Blocked as Malicious”
7. [Exploit Protection](https://demo.wd.microsoft.com/Page/EP) (Optional)
8. [Attack Surface Reduction](https://demo.wd.microsoft.com/Page/ASR) (Optional - but don’t be scared!)