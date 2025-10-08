# OSYS1200 Lab 4 - Part 1

Last Updated: Sept 30, 2025 17:57 PM
Created By: Matt Redmond
Upadted By: Don Geraghty
Course: OSYS1200

# Unit 4 Lab – Part 1 Disks and Storage

Your VM already has a `C:\Storage` folder, but if you prefer to follow along locally you can just create the folder yourself. If you like overcomplicating things (like me) try PowerShell:

```powershell
New-Item -Path 'C:\Storage' -ItemType Directory
```

## Activity 1 – What Disks?

In class we saw a variety of tools that we can use in Windows to collect information about our storage devices. **Answer the following questions and provide a screenshot of how you found each answer (be adventurous!)**:

1. How many physical disks are currently connected to the system?
2. What is the capacity of Disk 0?
3. What file system is used on the D: volume?
4. How much Free space is available on the C: volume?

## Activity 2 – Creating VHDs

1. Create a new VHD via Computer Management→Disk Manager (->Action->Create VHD) with the following specs:
    1. Location: C:\Storage\Disk2.vhdx (Type in this file name)
    2. Size: 5GB
    3. Virtual hard disk format: VHDX
    4. Virtual hard disk type: Dynamically Expanding
2. Did it work? **Provide a screenshot.**
3. Great! Now let’s try using a different method. Using DiskPart or PowerShell, **document the steps required to create another VHD (Disk3.vhdx) with the same specs.**
    
    <aside>
    ☝🏽 If you don’t see your new VHD in disk manager right away, just remember to make sure your new VHD is attached.
    
    </aside>
    
4. Almost done. Test your documentation by following your own steps to create a third VHD (Disk4.vhd)
5. Open File Explorer and confirm that the storage is now available. 
    
    <aside>
    ❓ WAIT… that’s a trick right? It’s not there? We need to set it up!
    
    </aside>
    

## Activity 3 – Initializing a Disk

Now that we have some shiny new storage attached to the system, let’s look at how we can configure this storage for use.

1. Launch Computer Management and find the first 5GB disk you added. 
    
    <aside>
    🗣 Ignore any pop-ups for now, we’ll trigger things manually.
    
    </aside>
    
2. Right-click the 5 GB of unallocated space from the VHD disk and note the available volume creation options are all grayed out and unavailable.
3. Right-click the VHD’s disk name next to the blue drive icon and select **Initialize Disk** from the shortcut menu.
4. Note in the Initialize Disk window which partition styles are available for use with the VHD disk. Select **MBR** and click **OK**.
5. Right-click the unallocated space from the VHD disk and select **New Simple Volume**
6. Click **Next**. Click **Next** again. Note the drive letter assigned to the new simple volume and then click **Next**.
7. Change the default volume label of New Volume to `VHDVOL`. Click **Next** and then click **Finish** to complete the New Volume Wizard. During the creation and formatting of the drive, Windows might mistakenly prompt you to format the new volume even though the wizard is performing that task for you. If that happens, just click Cancel on the prompt asking “Do you want to format it?”
8. Note the size of the newly created partition in Disk Management. It is reported as the full size of 5 GB you specified in the New Volume Creation Wizard.
9. Switch to the **File Explorer** window and browse to `C:\Storage`. **Right click** on the drive and select **properties** Note the size of the VHD file in that folder and the fact that it is much smaller that the reported volume size. If necessary use the view tabs to change to “Details” view:
    
    ![Veiw Options][def]
    
10. In the File Explorer window, right-click the drive letter assigned to the VHD disk and select **Properties** from the shortcut menu. Note the Used Space and Free Space values shown on the **General tab**. Compare this with the actual size of the VHD file noted in the previous step. **Grab a screenshot**~
11. Click **OK** to close the drive Properties window.
12. Close all open windows, but do not sign out or restart.

## Activity 4 – Detach a VHD

1. Right-click the Start button and click **Powershell (Admin)**. If you are prompted by User Account Control for permission to run this application, click **Yes**.
2. Type `diskpart` and press Enter.
3. To focus attention on the VHD created in the previous activity, type:`select vdisk file= “C:\Storage\Disk2.vhdx”`
4. Type the command `detail vdisk` and press Enter to display detailed information about the VHD. **Grab a screenshot** Note the Virtual size and Physical size attributes listed in the output of the command.
5. Type `detach vdisk` and press Enter to dismount the VHD. **Grab a screen shot!**
6. To leave the DiskPart utility, enter the command `exit`.
7. Close all open windows, but keep on rollin’

## Activity 5 – Storage Spaces

We should still have two VHD’s mounted from Activity 2, let’s see if we can use these to configure a Storage Spaces pool.

1. Open the start menu and search for “Storage Spaces” and launch the configuration wizard.
2. Click **Create a new pool and storage space**.
3. Notice the disks appear to be usable even though they have not been initialized!
4. Check both disks and click **Create pool**.
5. Name your new Storage Space: `Storage space` (default).
6. Resiliency? It would be nice to have some resiliency. Review each of the options to determine the most appropriate option for us. **Document your choice in your lab notes!**
7. Click **Create Storage Space**.
8. Open File Explorer and find your new storage device “Storage Space”. What is the available space? **Why might this be different than the capacity of the two disks you added to the pool?**

## Activity 6 - CLI Disk Mastery

### Part A - Diskpart

</aside>

1. If necessary, start your computer and sign in.
2. Click the **Start** button, in the search box type `cmd`, and then click **Run as administrator** in the details pane.
3. In the User Account Control dialog box, click **Yes**.
4. Type `diskpart` and then press **Enter** to start the DiskPart utility in its interactive mode. Note that the prompt changes to DISKPART>.
5. Type `help` and then press Enter to see a list of DiskPart commands.
6. Type `help select` and then press Enter to see information about the select command.
7. Type `help select disk` and then press Enter to see information and examples for the select disk command.
8. To see what disks can be selected, type `list disk` and then press **Enter**.
9. The DiskPart utility has not been focused on a particular disk yet, so some commands will not be able to run. For example, type `list partition`, press **Enter**, and note the error message.
10. To focus attention on the first disk, type `select disk = 0` and then press **Enter**.
11. Type `list partition`, press **Enter**, and note that the error message is gone.
12. To see what volumes are visible to the DiskPart utility, type `list volume` and then press **Enter**. **Grab a screenshot!**
13. To leave the DiskPart utility, type `exit` and then press **Enter**.
14. Close the Administrator: Command Prompt window.

### Part B - Powershell

</aside>

1. If necessary, start your computer and sign in.
2. Right-click the **Start** button and then click **Windows PowerShell** (Admin).
3. In the User Account Control dialog box, click **Yes**.
4. Type 
```powershell
Get-Command -Module Storage
```
 and then press **Enter**. This lists all the cmdlets available in the currently installed Windows Storage module.

5. At the Windows PowerShell prompt, type **`Get-Disk`** and then press Enter. This lists all physical disk objects, like basic disks, organized in a table.
6. Type
```powershell
 Get-Disk | FL Number, FriendlyName, PartitionStyle, BusType 
 ```
 and then press **Enter**. **Grab a screenshot!** This lists specific attributes for each drive, including some additional information that was not shown in the default table format. Note that not all data returned by a straightforward PowerShell command like Get-Disk is displayed on the screen by default.

7. Type `Get-Partition` and then press **Enter**. This shows all the partitions, organized by disk, even if they are not formatted as a volume to store files.
8. Type **`Get-Volume`** and then press **Enter**. This returns a table of all volumes on all partitions for all disks.
9. Type
```powershell
 Get-Volume | Where-Object {$_.DriveLetter -ne $null}
 ```
  and then press **Enter**. This shows the power of PowerShell to generate a filtered view, in this case only the volumes that have a drive letter assigned. **Grab a screenshot!**

10. Close the Windows PowerShell prompt window.

[def]: ./screenshot-view.png