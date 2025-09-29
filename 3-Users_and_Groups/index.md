# OSYS1200 Lab 3

# Lab 3 - Managing Users and Groups

> Please use your VM at [172.16.144.118](http://172.16.144.118/) . You should have the hang of connecting to this by now, but if you forgot jump [back to Lab 2](https://nscctruroit.github.io/OSYS1200/2-Utilities_and_Tools/).

> Connectivity from F305 and F308 should now be working! Just connect to the Sysnet wifi and you should be good to go!

## Activity 1 – Creating Users and Groups

### Part A - Making Matt

1. If necessary, start your VM and sign in.
1. Click the **Start** button and then click **Settings**.
1. In the Settings window, click **Accounts** and then click **Family & other users**.
1. In the Other users area, click **Add someone else to this PC**.
1. On the How will this person sign in screen, click **I don’t have this person’s sign-in information**.
1. On the Create account screen, click **Add a user without a Microsoft account**.
1. On the Create an account for this PC screen, enter the following information and then click **Next**:
    - User name: `Matt`
    - Password: `password`
    - Security question 1: What was your first pet’s name?
    - Your answer: `Fido`
    - Security question 2: What was your childhood nickname?
    - Your answer: `Fido`
    - Security question 3: What’s the first name of your oldest cousin?
    - Your answer: `Fido`

### Part B – Computer Management - MMC

1. Right-click the Start button and then click **Computer Management**.
1. In the left pane, expand Local Users and Groups and then click **Users**. Notice the users who are listed here: itstudent, Matt, DefaultAccount, Guest, WDAGUtilityAccount…
1. Double-click **Matt**.
1. In the Matt **Properties** dialog box, on the **General** tab, in the **Full name** box, type `Matt Redmond` and read the other available options.
1. Click the **Member Of** tab and read the list of groups that Matt is a member of (**Grab a screenshot!**), and then click **Cancel**.
1. In Computer Management, right-click **Users** and then click **New User**.
1. In the User name box, type `Jacob`.
1. In the Full name box, type `Jacob Smith`.
1. In the Password and Confirm password boxes, type `password`. Notice that, by default, the User must change password at next logon check box is selected.
1. Click **Create** and then click **Close**.
1. In the left pane, click **Groups**. Notice all the built-in groups that exist by default.
1. Double-click **Administrators** and read the list of group members. Notice that any user account configured as an administrator account is a member of this group. **Take a Screenshot**.
1. In the Administrator **Properties** dialog box, click **Cancel**.
1. Right-click **Groups** and then click **New Group**.
1. In the New Group dialog box, in the Group name box, type `TestGroup`.
1. Click the **Add** button.
1. In the Select Users dialog box, in the Enter the object names to select box, type `Jacob`, click **Check Names**, and then click **OK**.
1. Click **Create** and then click **Close**.
1. In the left pane, click **Users**.
1. Right-click **Jacob** and then click **Properties**.
1. Click the **Member Of** tab. Notice that Jacob is a member of TestGroup and Users. **Grab a screenshot!**
1. Log in user to Jacob (Click **Start**, Click your **user** and click **Jacob Smith**). Notice that you are given a message indicating that the password must be changed.
1. Click **OK** and enter a new password (twice) and press **enter**.
1. Click **Next** and **Accept** for the provacy settings.
1. Return to your itstudent session (Click **Start**, Click your **user** and click **itStudent**).
1. Next, add Jacob to the “Remote Desktop Users” group.
    1. Log in as itstudent and launch Computer Management
    1. Open the account properties dialogue for Jacob
    1. On the **Member Of** tab, click **Add**
    1. Click **Advanced** and **Find Now**
    1. Select **Remote Desktop Users** and click ok twice
    > This will be important later!
1. Log in as Jacob.
1. Launch **Task Manager** and click the **Users** tab. **Take a screenshot**.
1. Log out.

### Part C – Powershell User Management

1. Right-click the **Start** button and then click **Windows PowerShell (Admin)**.
1. In the User Account Control dialog box, click **Yes**.
1. At the Windows PowerShell prompt, type `net user` and then press Enter.
1. At the Windows PowerShell prompt, type `net user /?` and then press Enter.
1. At the Windows PowerShell prompt, type `net user Jacob` and then press Enter.
1. At the Windows PowerShell prompt, type `Get-LocalUser` and then press Enter.
1. At the Windows PowerShell prompt, type `Get-LocalUser | Where Enabled -eq $true` and then press Enter. **Grab a screenshot!**
1. At the Windows PowerShell prompt, type `Get-LocalUser Jacob` and then press Enter.
1. At the Windows PowerShell prompt, type `Get-LocalUser Jacob | Format-List` and then press Enter.
1. At the Windows PowerShell prompt, type `Set-LocalUser Jacob -Description "Test User Account"` and then press Enter.
1. At the Windows PowerShell prompt, type `Disable-LocalUser Jacob` and then press Enter.
1. At the Windows PowerShell prompt, type `Get-LocalUser Jacob | Format-List` and then press Enter. Notice that the describe text is present and the account is not enabled**. Grab another screenshot.**
1. Close the Windows PowerShell prompt window.

## Activity 2 – Password Reset

### Part A – Command Prompt

Jacob just showed up a your door. They forgot their password… again.

1. Press the Windows Logo Key and type `cmd`
1. Right click Command Prompt and choose **“Run as Administrator”**.
1. Type `net user` and press enter.
1. Type `net user Jacob` and enter again.
1. Type `net user Jacob It$tudent` and enter again. **Collect a screenshot.**
1. Answer this question: **What did you just do?**

### Part B – Powershell

Let’s try that again, but this time with some scripting! (Sort of… interactively)

1. Right-click the **Start** button and then click **Windows PowerShell (Admin)**. 
1. In the User Account Control dialog box, click **Yes**. (if applicable) 
1. First we will set the password to use and store is as a variable:

    ```powershell
    $NewPassword = (Read-Host -Prompt "Enter Password Yo! " -AsSecureString)
    ```

    > Notice how we force it to display a prompt using `Read-Host -Prompt`

1. Type a new password for Jacob and hit **enter**.
1. Next we can use that password try it… `echo $NewP` then **press tab.** See! It found the variable name we assigned in step 4 $NewPassword.
1. Ok press enter. It should show something like System.Security.SecureString…. Well that makes sense. It’s secure so it won’t show the actual password.
1. Now let’s use it to reset Jacobs’s password:

    ```powershell
    Set-LocalUser -Name Jacob -Password $NewPassword
    ```

1. **Take a screenshot**
1. Let's also save your hard work to a text file:
    ```powershell
    get-history | Out-File -FilePath "C:\Users\Student\Documents\ps-history.txt"
    ```

## Activity 3 – Profile Management

### Part A – Public Profile

This is pretty slick… let’s say you need to make sure every user on the system has a shortcut to an important App. One way to accomplish this is to create the shortcut in the public profile. Try creating a shortcut to Steam (or any other app, you can just copy an existing shortcut like from your "Links" folder) and saving it to **C:\Users\Public\Public Desktop** (note this folder may be hidden by default, in explorer click View→Show->Hidden Items). Check to see if the new shortcut showed up on your desktop. Test your solution by logging in as a different user and see if the shortcut is there. 

**Create a set of instructions (written, screenshots, recorded or a combination) for other admins to follow to add additional shortcuts to the public profile.**

### Part B – Types of Profiles

Visit the [Manage User Profiles Module](https://learn.microsoft.com/en-ca/training/modules/manage-user-profiles/) on Microsoft Learn and read through the first three units.

**Describe each of the following in your own words**

1. Local Profile
1. Mandatory Profile
1. Roaming Profile
1. Temporary Profile

>💡 Not sure where to start? Well Microsoft Documentation, google, but maybe ChatGPT, Windows Copilot or Gemini? Remember.. just be transparent. If you use AI, consider including the prompt(s) that helped you understand.

## Activity 4 – Start Menu Mastery (Windows 11 Edition)

Objective:
Customize the Windows 11 Start menu, export the layout, and apply it using Local Group Policy.

Steps:

1. Prepare the Environment

    Start VN located 172.16.144.118
1. Customize the Start Menu
    - Click the **Start** button and search for Paint.
    - **Right-click** Paint and select Pin to Start.
    - Repeat the process for:
        Computer Management
        Windows PowerShell

    > 📝 Note: In Windows 11, pinned apps appear in the Pinned section of the Start menu. You can drag and drop to rearrange them.

1. Organize Pinned Apps

    - Open the Start menu.
    - Drag **Paint**, **Computer Management**, and **Windows PowerShell** to the top row.
    - Right-click on one of them and select Move to group or Create new group (if available).
    - Name the group **Tools**.
1. Export the Start Layout

    Open Windows PowerShell as Administrator.
    Run the following commands:

    ```powershell
    md C:\Start
    Export-StartLayout -Path C:\Start\StartMenuLayout.json
    ```
1. Open the exported layout:

    ```PowerShell
    notepad C:\Start\StartMenuLayout.json
    ```
1. Review the JSON structure. Note the group name and apps listed.
1. Apply Layout via Group Policy
**Press Win + R, type mmc, and press Enter.**

1. In the Console1 window:

    Click **File > Add/Remove Snap-in.**
    Select **Group Policy Object Editor**, click **Add**, then **Finish**, and **OK**.
1. Navigate to **Local Computer Policy > User Configuration > Administrative Templates > Start Menu and Taskbar** and double-click **Start Layout**. Set it to **Enabled**.

1. In the Start Layout File box, enter `C:\Start\StartMenuLayout.json` and click **OK**.

1. Test the Layout
    
    In PowerShell, enable a test user (e.g., Jacob):

    ```PowerShell
    Enable-LocalUser Jacob
    ```
1. Sign out and sign in as Jacob.

    Verify that the Tools group appears in the Start menu. Take a screenshot for your lab documentation.
1. Revert the Policy
    
    Sign back in as your admin user.
In the Console1 window, double-click Start Layout again.
Set it to Not Configured and click OK.
Close all windows. Do not save the MMC console.

## Activity 5 - Groups! MMC Vs PS

Groups will be used to simplify the assignment of privileges and file system permissions. We’ll see this more when we explore storage devices and Windows security. For now, let’s try the basics: 

### Part A - Creating Groups

1. Press **`Win + X`** on your keyboard to open the Power User Menu.
1. Let’s create another group via MMC. Select **Computer Management** from the menu to open the Computer Management console.
1. In the Computer Management console, expand **Local Users and Groups** in the left panel.
1. Right-click on the **Groups** folder and choose **New Group.**
1. In the "New Group" dialog box:
    - Enter a "Group Name" of `redteam`
    - Provide a "Description" for the group like `A threat actor cleared for attacks and exploits.`
    - This would be a convenient time to add users to our group, but we’ll do that after it’s created. **Grab a screenshot** instead!
1. Click **Create** to create the group. Close the Create Group dialogue window.
1. But wait… If you guessed that we might need another group, you were right!  Leave Computer Management open, and launch Powershell as Administrator. Press **`Win + X`** on your keyboard.
1. Select **Windows PowerShell (Admin)**
1. In the PowerShell window, you can use the **`New-LocalGroup`** cmdlet to create a new local group. Here's the basic syntax:

```powershell

New-LocalGroup -Name "GroupName"

```

Replace "GroupName" with `blueteam`

```powershell

New-LocalGroup -Name "blueteam"

```

You can verify that the group has been created by using the **`Get-LocalGroup`** cmdlet and **Grab a Screenshot!**:

```powershell

Get-LocalGroup

```

> Up for a challenge? Remember we added a description to redteam try using powershell  to add the following description to  blueteam:  `Protects Confidentiality/Integrity/Availability` **Hint**: use `Set-LocalGroup` and specify the group using the `-Name` option

### Part B - Manage Group Members

1. Return to **Computer Management**. Expand the groups folder and right click on the **redteam** group.
1. Choose **Properties** and under Members click **Add…**
1. In the "Select Users" dialog box, click **Advanced** to search for users.
1. Click **Find Now** to list all available users on the system.
1. Select the Bad user, and click **OK.** Click **OK** again to add the selected users to the group. Notice that we could also remove a user from this group from this same Properties window. 
1. AND click **OK** one more time to save the group properties.
1. To modify group membership later, right-click on the group in the Groups folder and choose "Properties."
1. Now let’s add Jacob to the blueteam, but since we only want to add Jacob we’ll configure it on his account (not the group).
1. Under Computer Management expand **Users,** right-click **Jacob** and click **Properties.**
1. Click on the **Member Of** tab and click **Add…**
1. In the "Select Groups" dialog box, click **Advanced** to search for users.
1. Click **Find Now** to list all available users on the system.
1. Select the blueteam group, and click **OK.** Click **OK** again to add the selected users to the group. Notice that we could also remove this user from a group from this same Properties window. **Grab a screenshot!**
1. AND click **OK** one more time to save the group properties.

## What to submit
1. Activity 1: Requested screenshots w/ descriptions.
1. Activity 2:Requests screenshots & contents of ps-history.txt
1. Activity 3: Your own instructions & descriptions
1. Activity 4 & 5:
    Screenshot the output of this script to confirm completion
    1. Launch Powershell(Admin) with WIN+X
    1. Navigate to Documents `Set-Location "C:\Users\Student\Documents"`
    1. Download the "Grade-A-Tron" script  (this is one line):
    
    `Invoke-WebRequest -Uri "https://raw.githubusercontent.com/NsccTruroIT/OSYS1200/refs/heads/main/3-Users_and_Groups/Lab3-Grade-A-Tron.ps1" -OutFile ".\Lab3-Grade-A-Tron.ps1"`
    1. Allow script execution `Set-ExecutionPolicy RemoteSigned`
    1. Run the script `.\Lab3-Grade-A-Tron.ps1`