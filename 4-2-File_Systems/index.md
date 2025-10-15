# OSYS1200 Lab 4 - Part 2

Last Updated: Sept 30, 2025 18:18 PM
Created By: Matt Redmond
Updated By: Don Geraghty
Course: OSYS1200


# Unit 4 Lab – Part 2 File Systems and Permissions

We added some storage… next we’ll explore the existing storage devices on our machines and configure some new storage.

Your Virtual Machine has been updated with a few files, folders and NTFS ACL’s to make it easier to explore. If you prefer to follow along on a different device you can run the following PowerShell commands to quickly set up the environment:

- Code
    
    ```powershell
    #Create Bad User
    $password = ConvertTo-SecureString "It$tudents" -AsPlainText -Force
    New-LocalUser -Name "Bad" -Password $password -FullName "Bad User" -Description "Demo User"
    
    #Create Top Secrete Folder
    mkdir C:\TopSecret
    $NTFSpath = "C:\TopSecret"
    $acl = Get-Acl -Path $NTFSpath
    $accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule ('Everyone', 'FullControl', 'ContainerInherit, ObjectInherit', 'InheritOnly', 'Allow')
    $acl.SetAccessRule($accessrule)
    Set-Acl -Path $NTFSpath -AclObject $acl
    
    # Create Shared folder
    mkdir "$($env:USERPROFILE)\Documents\Shared"
    New-SmbShare -Name "Shared" -Path "$($env:USERPROFILE)\Documents\Shared" -ChangeAccess "Users" -FullAccess "Administrators"
    
    ```
    

    - To run this script on your system
        - Save the script to a local file i.e. lab4_setup.ps1
            `notepad lab4_setup.ps1`
        - Paste the content above into your file and save it
        - (If Necessary) Set the Execution Policy
            `Set-ExecutionPolicy Bypass`
        - Execute the script
            `.\lab4_setup.ps1`

## Activity 1 – What File System?

In class we saw a variety of tools that we can use in Windows to collect information about our storage devices. **Answer the following questions and provide a screenshot of how you found each answer (be adventurous!)**:

1. What File Systems are currently being used on your storage devices?
2. How can you ensure that files with the hidden attribute are still displayed file explorer?
3. How can you ensure that file extensions are displayed in file explorer?

## Activity 2 – Managing Mount Points

1. On the taskbar, click **File Explorer** and browse to **C:\**.
2. In File Explorer, right click select new then click **New folder**, type `MyAppData`, and press Enter.
3. If disk2 is not already attached, browse to **C:\Storage\** and double-click **Disk2.vhd(x)**. This mounts (attaches) the VHD; take note of the drive letter for the storage.
4. Browse to the drive, Right click and select new, then select new **Text Document**.
5. Type `DataFile` and press **Enter** to name to file.
6. Close File Explorer.
7. Right-click the **Start** button and click **Disk Management.**
8. Right-click VHDVOL (**driveletter:**) and click **Change Drive Letter and Paths**.
9. In the Change Drive Letter and Paths for driveletter: (VHDVOL) window, select the drive letter, and click **Remove**.
10. Open **File Manager** and notice that your drive is no longer available (just like a usb drive with a drive letter conflict)
11. In the **Disk Management** window, click **Yes** to acknowledge the warning.
12. Right-click **VHDVOL** and click **Change Drive Letter and Paths**.
13. In the Change Drive Letter and Paths for VHDVOL window, click **Add**.
14. In the Add Drive Letter or Path window, click **Mount** in the following empty NTFS folder, type `C:\MyAppData` in the text box, and click **OK**.
15. ****On the taskbar, click **File Explorer** and browse to C:\. Notice that MyAppData is displayed with a different icon and shows a size. **Grab a screenshot here!**
16. Close File Explorer.
17. Right-click the **Start** button and click **Command Prompt**.
18. At the command prompt, type `dir C:\my*` and press **Enter**. Notice that MyAppData is a junction point. **Grab a screenshot here!**
19. Type `cd \MyAppData` and press **Enter**.
20. Type `dir` and press **Enter**. Verify that DataFile.txt is there.
21. Close the command prompt.
22. In **Disk Management**, scroll down in the list of disks, right-click the disk containing **VHDVOL**, and click **Detach VHD**.
23. In the Detach Virtual Hard Disk window, click **OK**.
24. Close Disk Management.

## Activity 3 - File and Folder Attributes

In class we saw an example of viewing file and folder attributes using File Explorer and via the CLI using attrib. 

1. Open **File Explorer**.
2. In the left pane, click **Local Disk (C:)**.
3. Right-click on the directory **Top Secret** and choose properties**.**
4. Note the current state of the Read-Only and Hidden attributes. Click **Advanced**. **Grab a Screenshot!** 
5. Close the advanced and properties windows. 
6. Press WIN+R and type `cmd` then press enter.
7. Change to the C: drive by entering `cd C:\`
8. Now check the attributes of Top Secret, type `attrib “TopSecret”` and press enter.
9. Let’s make this folder hidden, type `attrib +h “TopSecret”` and press enter.
10. Press the up arrow key twice, this should bring up your first attrib command. Press enter to verify that the H attribute has been added. **Get a screenshot!**
11. For good measure check the current attributes assigned to the entire C:\. type `attrib` and press enter. Notice how we didn’t specify an individual file or folder so it show results for the entire current working directory.

## Activity 4 - Managing File System Permissions

Now that we have some shiny new storage attached to the system, let’s look at how we can configure this storage for use.

1. Right-click the **Start** button and then click **File Explorer**.
2. In the left pane, click **Local Disk (C:)**.
3. Create a new folder called **Marketing Documents** in C:\.
4. Right-click the **Marketing Documents** folder and then click Properties.
5. In the Marketing Documents Properties dialog box, click the **Security** tab and review the users and groups assigned permissions.
6. Click the **Advanced** button and review the specific permissions that have been applied to the users and groups.
7. In the Advanced Security Settings for Marketing Documents dialog box, click the **Effective Access** tab.
8. Click the **Select a user** link to display the Select User or Group dialog box.
9. Type your user name and then click **OK** to continue.
10. Click the **View effective** **access** button. **Grab a Screenshot!** On the Effective Access tab, notice which advanced NTFS permissions have a check mark next to them. You have all available permissions because your account is a local administrator.
11. Note the current owner of the folder. Your account is the owner of the folder because you created it. Click the **Change** link to the right of the name in the Owner field.
12. In the Select User or Group dialog box, type **Administrators** and then click **OK** to change the owner of the folder to the local Administrators group and any user that belongs to that group.
13. Select the **Replace owner on subcontainers and objects** check box.
14. If necessary, click the **Change Permissions** button to enable the controls for changing permissions.
15. Click the **Disable inheritance** button.
16. In the Block Inheritance warning dialog box, click **Remove all inherited permissions from this object** to start with blank security settings for the Marketing Documents folder.
17. Click the **Add** button in the Advanced Security dialog box to display the **Permission Entry** dialog box.
18. Click **Select a principal** link.
19. Enter itstudent (or your user) and then click **OK** to continue.
20. In the list of basic permissions, place a check next to the **Full control** permission.
21. Note that all other basic permissions are automatically assigned and that the permission scope is set to **This folder, subfolder and files**. **Grab a Screenshot!** 
22. Click **OK** to continue.
23. Note the new permission entry on the **Permissions** tab in the **Advanced Security Settings** dialog box. **Grab a screenshot!**
24. Notice that the Inherited from column shows as None for the directly assigned permission.
25. Click **OK** to close the Advanced Security Settings dialog box.
26. Click **OK** to close the Marketing Documents Properties dialog box. This is required to refresh the contents of that window.
27. Right-click the **Marketing Documents** folder and then click **Properties**.
28. Click to select the **Security** tab. Notice the new permission setting and the simpler view. **Grab a screenshot!**
29. Click **OK** to close the Marketing Documents Properties dialog box.
30. Create a new text document called `First Quarter Report.txt` in the **C:\Marketing Documents** folder.
31. Right-click **First Quarter Report.txt**, click **Properties**, and then click the **Security** tab. Notice that the permissions from the Marketing Documents folder are inherited by this file, as indicated by the grey check marks.
32. Click **Cancel** and close all windows and dialog boxes.
33. To release all open and attached VHDs, plus the active storage pool created with virtual disks, restart your computer. These virtual disks will not reattach automatically the next time you sign in.

## Activity 5 – Share Permissions

Share permissions are sometimes confused with file permissions. Share permissions are a simplified way to provide access to files and folders for other users and groups. They offer a limited set of permissions, but are available for any file system. As we saw NTFS file permissions are more comprehensive, but are only available for NTFS file systems.

1. Someone has created a shared folder in itstudent’s “Documents” folder.

![Untitled][def]

1. This makes you wonder… what other shared folders might exist on this machine? Let’s find out.
2. Right click the **Start** button and open **Computer Management**.
3. Click the arrow beside **Shared Folders** and click **Shares**. **Grab a screenshot!**
4. Right click the **Shared** folder and click **properties**.
5. Click **Share Permissions** and document the current permissions in your lab.
6. Close **Computer Management** and open **File Explorer**.
7. **Demonstrate the steps you would take via File Explorer to deny Bad user access to this share?**
    
    <aside>
    📂 Be sure not to deny access for everyone though!
    
    </aside>
    

## Activity 6 – Bad User

On VM, you’ll notice I set up a folder in C:\ called “TopSecret”. The permissions for this folder have been slightly modified, but somebody reported that the  “Bad” user (already created on the system) also has access to this folder:

![Untitled][def2]

You need to restrict access to this folder for Bad user without disrupting access for any other users.

 **You can choose to answer the following questions with screenshots, text, audio, video, links or anything else that works for you** 😊

1. How can you tell what the current permissions are for this folder?
2. What options are available to ensure the “Bad” user does not have access to “Top Secret”?
3. Can you prove that you restricted access for Bad?

[def]: Untitled.png
[def2]: Untitled1.png