# OSYS1200 Lab 3

# Lab 3 - Managing Users and Groups

While the activities contained in this lab could be completed on any Windows 10 computer, the activities have been tailored to work in our Azure labs environment. If you would rather not make changes to your local machine, please use your VM at [172.16.144.118](https://172.16.144.118/) . You should have the hang of connecting to this by now, but if you forgot jump [back to Lab 2](https://www.notion.so/OSYS1200-Lab-2-b659376c11fa49bf9d14db009609147a?pvs=21).

## Activity 1 – Creating Users and Groups

### Part A - Making Matt

1. If necessary, start your computer and sign in.
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

1. If necessary, start your azure labs computer and sign in.
2. Right-click the Start button and then click **Computer Management**.
3. In the left pane, expand Local Users and Groups and then click **Users**. Notice the users who are listed here: itstudent, Matt, DefaultAccount, Guest, WDAGUtilityAccount…
4. Double-click **Matt**.
5. In the Matt **Properties** dialog box, on the **General** tab, in the **Full name** box, type `Matt Redmond` and read the other available options.
6. Click the **Member Of** tab and read the list of groups that Matt is a member of (**Grab a screenshot!**), and then click **Cancel**.
7. In Computer Management, right-click **Users** and then click **New User**.
8. In the User name box, type `Jacob`.
9. In the Full name box, type `Jacob Smith`.
10. In the Password and Confirm password boxes, type `password`. Notice that, by default, the User must change password at next logon check box is selected.
11. Click **Create** and then click **Close**.
12. In the left pane, click **Groups**. Notice all the built-in groups that exist by default.
13. Double-click **Administrators** and read the list of group members. Notice that any user account configured as an administrator account is a member of this group. **Take a Screenshot**.
14. In the Administrator **Properties** dialog box, click **Cancel**.
15. Right-click **Groups** and then click **New Group**.
16. In the New Group dialog box, in the Group name box, type `TestGroup`.
17. Click the **Add** button.
18. In the Select Users dialog box, in the Enter the object names to select box, type `Jacob`, click **Check Names**, and then click **OK**.
19. Click **Create** and then click **Close**.
20. In the left pane, click **Users**.
21. Right-click **Jacob** and then click **Properties**.
22. Click the **Member Of** tab. Notice that Jacob is a member of TestGroup and Users. **Grab a screenshot!**
23. Log in user to Jacob (For Azure: Log out and run the downloaded .rdp file again. For Local: Click Start, Click your user and click Jacob Smith). Notice that you are given a message indicating that the password must be changed.
24. Click **OK** and return to your itstudent session (log in as itstudent).
25. Change the properties of Jacob to remove the “User must change password…” requirement. (as observed in step 10)
26. Test logging in a Jacob again. Another problem???
27. Next, add Jacob to the “Remote Desktop Users” group.
    1. Log in as itstudent and launch Computer Management
    2. Open the account properties dialogue for Jacob
    3. On the **Member Of** tab, click **Add**
    4. Click **Advanced** and **Find Now**
    5. Select **Remote Desktop Users** and click ok twice
    6. Log out.
28. Log in as Jacob. For Azure, you can only be logged in remotely to one account at a time so if you see a message similar to the one below, click **Yes**.

![Untitled](Untitled.png)

1. Click **OK** and wait for the new profile to be created.
2. On the Choose privacy settings for your device screen, click **Accept**.
3. Launch **Task Manager** and click the **Users** tab. **Take a screenshot**.
4. Log out.

### Part C – Powershell User Management

1. If necessary, start your Azure labs computer and sign in as itstudent.
2. Right-click the **Start** button and then click **Windows PowerShell (Admin)**.
3. In the User Account Control dialog box, click **Yes**.
4. At the Windows PowerShell prompt, type `net user` and then press Enter.
5. At the Windows PowerShell prompt, type `net user /?` and then press Enter.
6. At the Windows PowerShell prompt, type `net user Jacob` and then press Enter.
7. At the Windows PowerShell prompt, type `Get-LocalUser` and then press Enter.
8. At the Windows PowerShell prompt, type `Get-LocalUser | Where Enabled -eq $true` and then press Enter. **Grab a screenshot!**
9. At the Windows PowerShell prompt, type `Get-LocalUser Jacob` and then press Enter.
10. At the Windows PowerShell prompt, type `Get-LocalUser Jacob | Format-List` and then press Enter.
11. At the Windows PowerShell prompt, type `Set-LocalUser Jacob -Description "Test User Account"` and then press Enter.
12. At the Windows PowerShell prompt, type `Disable-LocalUser Jacob` and then press Enter.
13. At the Windows PowerShell prompt, type `Get-LocalUser Jacob | Format-List` and then press Enter. Notice that the describe text is present and the account is not enabled**. Grab another screenshot.**
14. Close the Windows PowerShell prompt window.

## Activity 2 – Password Reset

### Part A – Command Prompt

Bad user just showed up a your door. They forgot their password… again. 

1. If necessary, start your Azure labs computer and sign in.
2. Press the Windows Logo Key and type `cmd`
3. Right click Command Prompt and choose **“Run as Administrator”**.
4. Type `net user` and press enter.
5. Type `net user Jacob` and enter again.
6. Type `net user Jacob It$tudent` and enter again. **Collect a screenshot.**
7. Answer this question: **What did you just do?**

### Part B – Powershell

Let’s try that again, but this time with some scripting! (Sort of… interactively)

1. If necessary, start your Azure labs computer and sign in.
2. Right-click the **Start** button and then click **Windows PowerShell (Admin)**. 
3. In the User Account Control dialog box, click **Yes**. (if applicable) 
4. First we will set the password to use and store is as a variable:

```powershell
$NewPassword = (Read-Host -Prompt "Enter Password Yo! " -AsSecureString)
```

(Notice how we force it to display a prompt using `Read-Host -Prompt`)

1. Type a new password for Jacob and hit **enter**.
2. Next we can use that password try it… `echo $NewP` then **press tab.** See! It found the variable name we assigned in step 4 $NewPassword.
3. Ok press enter. It should show something like System.Security.SecureString…. Well that makes sense. It’s secure so it won’t show the actual password.
4. Now let’s use it to reset Jacobs’s password:
    
    ```powershell
    Set-LocalUser -Name Jacob -Password $NewPassword
    ```
    
5. **Take a screenshot** and close Powershell.

## Activity 3 – Profile Management

### Part A – Public Profile

This is pretty slick… let’s say you need to make sure every user on the system has a shortcut to an important App. One way to accomplish this is to create the shortcut in the public profile. Try creating a shortcut to Discord (or any other app, you can just copy an existing shortcut) and saving it to **C:\Users\Public\Public Desktop** (note this folder may be hidden by default, in class I demonstrated how to show hidden files in explorer by clicking View→Hidden Items ). Check to see if the new shortcut showed up on your desktop. Test your solution by logging in as a different user and see if the shortcut is there. **Create a set of instructions for other admins to follow to add additional shortcuts to the public profile.**

### Part B – Types of Profiles

There are a few more types of profiles, we’ll explore some later in the course. For now **please describe each of the following, include links to any resource that might be beneficial**:

1. Default Profile
2. Mandatory Profile
3. Roaming Profile

<aside>
💡 Not sure where to start? Well google, but maybe ChatGPT or Windows Copilot? Remember.. just be transparent. If you use AI, consider including the prompt(s) that helped you understand.

</aside>

## Activity 4 – Start Menu Mastery (Windows 11 Edition)
Objective:
Customize the Windows 11 Start menu, export the layout, and apply it using Local Group Policy.

Steps:
1. Prepare the Environment
Start VN located 172.16.144.118
2. Customize the Start Menu
Click the **Start** button and search for Paint.
**Right-click** Paint and select Pin to Start.
Repeat the process for:
Computer Management
Windows PowerShell
📝 Note: In Windows 11, pinned apps appear in the Pinned section of the Start menu. You can drag and drop to rearrange them.

3. Organize Pinned Apps
Open the Start menu.
Drag **Paint**, **Computer Management**, and **Windows PowerShell** to the top row.
Right-click on one of them and select Move to group or Create new group (if available).
Name the group **Tools**.
4. Export the Start Layout
Open Windows PowerShell as Administrator.
Run the following commands:

```powershell
md C:\Start
Export-StartLayout -Path C:\Start\StartMenuLayout.json
```
Open the exported layout:

```PowerShell
notepad C:\Start\StartMenuLayout.json
```
Review the JSON structure. Note the group name and apps listed.
5. Apply Layout via Group Policy
**Press Win + R, type mmc, and press Enter.**

In the Console1 window:

**Click File > Add/Remove Snap-in.**
Select Group Policy Object Editor, **click** Add, then Finish, and OK.
Navigate to:

Local Computer Policy > User Configuration > Administrative Templates > Start Menu and Taskbar
**Double-click** Start Layout.

Set it to Enabled.

In the Start Layout File box, enter:
```
C:\Start\StartMenuLayout.json
```

Click OK.

6. Test the Layout
In PowerShell, enable a test user (e.g., Jacob):

```PowerShell
Enable-LocalUser Jacob
```
Sign out and sign in as Jacob.
Verify that the Tools group appears in the Start menu.
Take a screenshot for your lab documentation.
7. Revert the Policy
Sign back in as your admin user.
In the Console1 window, double-click Start Layout again.
Set it to Not Configured and click OK.
Close all windows. Do not save the MMC console.

## Activity 5 - Groups! MMC Vs PS

Groups will be used to simplify the assignment of privileges and file system permissions. We’ll see this more when we explore storage devices and Windows security. For now, let’s try the basics: 

### Part A - Creating Groups

1. Press **`Win + X`** on your keyboard to open the Power User Menu.
2. Let’s create another group via MMC. Select **Computer Management** from the menu to open the Computer Management console.
3. In the Computer Management console, expand **Local Users and Groups** in the left panel.
4. Right-click on the **Groups** folder and choose **New Group.**
5. In the "New Group" dialog box:
    - Enter a "Group Name" of `redteam`
    - Provide a "Description" for the group like `This group will pose as a threat actor and is authorized to conduct a variety of attacks and exploits targeting hosts on our network.`
    - This would be a convenient time to add users to our group, but we’ll do that after it’s created. **Grab a screenshot** instead!
6. Click **Create** to create the group. Close the Create Group dialogue window.
7. But wait… If you guessed that we might need another group, you were right!  Leave Computer Management open, and launch Powershell as Administrator. Press **`Win + X`** on your keyboard.
8. Select **Windows PowerShell (Admin)**
9. In the PowerShell window, you can use the **`New-LocalGroup`** cmdlet to create a new local group. Here's the basic syntax:

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

<aside>
❓ Up for a challenge? Remember we added a description to redteam try using powershell  to ad the following description to  blueteam:  `This group will valiantly defend our confidentiality, Integrity and ensure Availability.` **Hint**: use `Set-LocalGroup` and specify the group using the `-Name` option

</aside>

### Part B - Manage Group Members

1. Return to **Computer Management**. Expand the groups folder and right click on the **redteam** group.
2. Choose **Properties** and under Members click **Add…**
3. In the "Select Users" dialog box, click **Advanced** to search for users.
4. Click **Find Now** to list all available users on the system.
5. Select the Bad user, and click **OK.** Click **OK** again to add the selected users to the group. Notice that we could also remove a user from this group from this same Properties window. 
6. AND click **OK** one more time to save the group properties.
7. To modify group membership later, right-click on the group in the Groups folder and choose "Properties."
8. Now let’s add Jacob to the blueteam, but since we only want to add Jacob we’ll configure it on his account (not the group).
9. Under Computer Management expand **Users,** right-click **Jacob** and click **Properties.**
10. Click on the **Member Of** tab and click **Add…**
11. In the "Select Groups" dialog box, click **Advanced** to search for users.
12. Click **Find Now** to list all available users on the system.
13. Select the blueteam group, and click **OK.** Click **OK** again to add the selected users to the group. Notice that we could also remove this user from a group from this same Properties window. **Grab a screenshot!**
14. AND click **OK** one more time to save the group properties.