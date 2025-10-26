# OSYS1200 Lab 6

Last Updated: October 26, 2024 8:00 AM

Created By: Matt Redmond

Edit: Don Geraghty

Course: OSYS1200

Status: In progress


## Activity 1 – File Explorer

### Part A - File Explorer View Options

In class we discussed the importance of ensuring that File explorer displays the extensions for filenames. This will ensure that we see the full name of the files that are shown in File Explorer. **List the steps required to configure File Explorer to show file extensions and hidden files.** and add a **Screenshot**

### Part B – Libraries

If necessary, start your computer and sign in.

1. On the taskbar, click File Explorer.
2. In the File Explorer window, find the Navigation Pane (the sidebar on the left). Right-click on any **empty/blank** space in that pane and click **Show libraries** from the context menu. A check mark will appear next to it. **Screenshot** Libraries in the left panel.
3. In the navigation pane, expand **Libraries** and then click **Documents**.
4. Right-click **Documents** and then click **Properties**.
5. In the Documents Properties window, click **Add**.
6. In the Include Folder in Documents window, in the address bar, type `C:\Users\Public`. **Grab a screenshot** and then press Enter.
7. Click **Public Documents** and then click **Include folder**.
8. In the Document Properties dialog box, the single green check mark identifies the Documents folder as your default save location. The green check mark with the users identifies the Public Documents folder as the public save location.
9. Right-click **Public Documents**, click **Set as default save location**, and then click **OK**. Notice that the view now includes both locations.
10. In the command bar at the top of the window, click the New button (it has a  `+` icon). From the dropdown menu, click **Text Document**. Type `NewPublicFile` as the file name, and then press Enter. Notice that the file was created in the Public Documents folder because that is the default save location for the Documents library. **Grab a screenshot.**
11. **Right-click on an empty/blank space** in the Navigation Pane again. Click **Show libraries** to remove the check mark from that item. **Grab a screenshot.**
12. Close the File Explorer window.

### Part C – Search w/ Indexing

1. On the taskbar, click **File Explorer.**
2. If necessary, expand **This PC** and then click **Local Disk (C:)**.
3. In the command bar at the top, click the New button (the `+` icon) and select **Folder**. Type `NewData` as the folder name, and then press Enter.
4. Double-click the **NewData** folder. In the command bar, click the **New** button (+) and select Text Document. Type `SearchFile` as the file name, and then press Enter.
5. Double-click `SearchFile` to open the file in Notepad.
6. In the Notepad window, type `Kangaroo`, click **File** on the menu bar, and then click **Save**.
7. Exit Notepad.
8. On the taskbar, click the **Search** icon (it looks like a magnifying glass). In the search box that appears at the top, type `Kangaroo`.
9. The search panel will show web results. At the top of this panel, click the **Documents** filter. You should see a "No results found" message. This is because the new folder is not indexed.
10. Close all open windows.
11. Click the **Start** button and then click **Settings**.
12. In the Settings window, click on **Privacy & security** from the left-hand menu.
13. On the "Privacy & security" page, under the "Windows permissions" section, click on **Searching Windows.**
14. On the "Searching Windows" screen, under the "Find my files" section, click **Customize search locations here** (it's a link below the "Classic" and "Enhanced" options).
15. In the Indexing Options window, click **Modify**.
16. In the Indexed Locations window, expand Local Disk (C:), select the NewData check box, **grab a screenshot** and then click **OK**.
17. In the Indexing Options dialog box, click **Close**.
18. On the taskbar, click the **Search** icon again. Type `Kangaroo` and click the **Documents** filter at the top. This time, the search should find your SearchFile.txt file. Grab a **screenshot** of the search result.

## Activity 2 – One Drive

### Part A – Sharing Files

Find a partner to explore file shares with (or share with me!). For this activity,  you can use either the local OneDrive Client or OnDrive Online, although you may find some features are only available online.  **Create the following shared folders and screenshot the configuration of each:**

1. Folder named “Group Work” – grant Direct Access
2. File named “Secret Stuff” – this should be read-only!
3. Folder named “Sharing is Caring” – Provide a link that can be used by external users with full access for one month.

Now that you have set up your shares… Is there a way to view anything that has been shared by you? But who has accessed the share? **List the steps to view.**

Is there a way to view that information? **List the steps to create a sharing Report.**

## Activity 3 – Printing

### Part A – Stage a Driver

1. On the taskbar, click Microsoft Edge.
2. In the Search or enter web address box, type [`support.hp.com`](https://support.hp.com/ca-en) and then press Enter.
3. Click Software and Drivers and then click Printer.
4. On the Identify your printer screen, in the Enter your product name box, type `hp universal print driver` and then click HP Universal Print Driver Series for Windows.
5. In the search area, click **Search all support** and then select **Software, Drivers, and Updates**.

<aside>
🔥 If you get lost, you can try [this direct link](https://support.hp.com/ca-en/drivers/hp-universal-print-driver-series-for-windows/503548), but there is a chance this could change.

</aside>

1. Expand **Driver** – **Universal Print Driver (3)**, and for HP Universal Print Driver for Windows PCL6 (64-bit), click **Download** and then click **Save**

![Untitled](OSYS1200%20Lab%207%209f7a87b855504dd6b25b5a97f8b2c985/Untitled.png)

1. When the download is complete, close the Microsoft Edge window.
2. On the taskbar, click **File Explorer** and then click **Downloads**.
3. Double-click the file you just downloaded.
4. In the WinZip Self-Extractor window, in the Unzip to folder box, type `C:\HPDriver`, deselect the **When done unzipping open: .\install.exe** check box, and then click **Unzip**.
5. Click **OK** and then close all open windows.
6. Right-click the Start button, click **Windows PowerShell (Admin)**, and then click **Yes**.
7. Type `pnputil /?` and then press Enter. This command displays the list of available options for pnputil.exe.
8. Type `pnputil /enum-drivers` and then press Enter. This command displays the list of third-party driver packages that have been installed. The HP Universal Print Driver package is not listed.
9. Type `dir C:\HPDriver\*.inf` and then press Enter. This command displays all INF files in the HPDriver directory.
    
    <aside>
    🚧 The next command installs the printer driver package into the printer driver store. If the command prompt is not running as an administrator, this command fails. Pay attention to the filename. This file might not be available in your downloaded version of the driver. If this file is not available, select the verions of the .inf file you downloaded.
    
    </aside>
    
10. Type `pnputil /add-driver C:\HPDriver\hpcuXXXu.inf`  (remember to use TAB to autocomplete the path) and then press Enter. **Grab a screenshot!** 
11. After the package is added, type `pnputil /enum-drivers` and then press Enter. Notice that the driver is now listed and named oemx.inf, where x is a number. **Grab a screenshot!** The .inf file for each driver is renamed when it is added to the driver store. This guarantees that all .inf files have a unique name.
12. Close all open windows.

### Part B – Install a Printer

1. Click the **Start** button and then click Settings.
2. In the **Settings** window, click **Devices** and then click **Printers & scanners**.
3. Click **Add a printer or scanner**. Windows takes a few minutes to scan the network to attempt to find printers and display any printers that are found.
4. Click **The printer that I want isn’t listed**.
5. In the Add Printer dialog box, click **Add a printer using a TCP/IP address or hostname** and then click **Next**.
6. In the Device type list, select **TCP/IP Device**.
7. In the Hostname or IP address text box, type `172.16.99.99`. No printer resides at this IP address; it is chosen for the purposes of this activity only to see the interface. **Grab a screenshot.**
8. Deselect the **Query the printer and automatically select the driver to use** check box and then click **Next**. In most cases, you want to leave this option on. You are deselecting it because this activity simulates the process.
9. After the TCP/IP port is detected (which might take a few minutes), on the Additional port information required screen, click **Standard** and then click **Next**.
10. In the Manufacturer area, click **HP**.
11. In the Printers box, select **HP Universal Printing PCL 6** and then click **Next**.
12. In the Printer name box, type `HP Printer PCL6` and then click **Next**.
13. On the Printer Sharing screen, click **Do not share this printer** and then click **Next**. **Grab a screenshot.**
14. Click Finish.

### Part C – MMC Snap-in

1. Click the Start button, type print, and then click Print Management.
2. If necessary, in the left pane, expand Custom Filters and then click All Printers. This filter displays all the printers installed on every print server that is being monitored. In this case, only the local printers are displayed because only the local computer is being monitored.
3. In the left pane, click All Drivers. This filter displays all the printer drivers that are installed on every print server that is being monitored. This allows you to see if different printer driver versions are installed on various print servers.
4. In the left pane, if necessary, expand Print Servers, expand your computer, and then click Drivers. This node displays only the printer drivers that are installed on your computer.
5. In the left pane, click Forms. This node displays the forms that are configured on your computer. Forms are the paper sizes the printer is configured to use. You can add, edit, or delete forms by right-clicking the Forms node and then clicking Manage Forms.
6. In the left pane, click Ports. This node displays all the ports configured on your computer that can be used for printing. You can add additional ports or manage existing ports from here.
7. In the left pane, click Printers. This node displays all of the printers that are installed on your computer. You can manage the printers from here and install new printers.
8. In the left pane, right-click Printers and then click Add Printer.
9. Click Add a new printer using an existing port, if necessary, select LPT1: (Printer Port), and then click Next.
    
    <aside>
    🚧  After printer installation, this printer will generate an error message when you attempt to print because no printer is physically attached to your computer on LPT1.
    
    </aside>
    
10. Click Use an existing printer driver on the computer, if necessary, click HP Universal Printing PCL6, and then click Next.
11. In the Printer Name box, type Local.
12. Leave the option Share this printer checked, type Local in the Share Name box, **Grab a screenshot!** and then click Next.
13. On the Printer Found screen, click Next.
14. When the printer installation is finished, click Finish.
15. In the left pane, click Printers. The new printer named Local is installed here now.
16. Right-click Local and then click Pause Printing.
17. Right-click Local and then click Print Test Page.
18. In the Local dialog box, click Close.
19. In the left pane, click Printers With Jobs. Notice that this screen now displays the printer Local because a job is in the queue. **Grab a screenshot!**
20. Close all open windows.

### Part D – Manage Print Jobs

1. Click the Start button and then click Settings.
2. Click Devices, click Printers & scanners, and then click your local printer. Note that the Printer is paused.
3. Click Open queue. Notice that a Test Page job exists from Part B. **Grab a Screenshot.**
4. Right-click Test Page and then click Pause. Notice that the status of the job changes to Paused.
5. Right-click Test Page and then click Resume.
6. Right-click Test Page and then click Properties.
7. Click the General tab. You can modify the priority and schedule of the job here.
8. Click OK to close the Test Page Document Properties dialog box.
9. Right-click Test Page and then click Cancel.
10. When prompted, click Yes to confirm canceling the job.
11. Close all open windows.

## Activity 4 – PowerToys

### Part A - Install

We looked at Microsofts PowerToys in class. This suite of tools is more of an Administrators productivity tool. There are numerous installation methods available, but the most exciting is via the new package manager winget!

1. Run Powershell as Administrator
2. Enter `winget install Microsoft.PowerToys --source winget`
3. Wow… the game has changed. **Grab a screenshot!**

### Part B – Demo

Explore the tools and **choose one** that interests you. Demonstrate the capability of this tool and **grab a screenshot** for your lab.

## Activity 5 – Regedit

### Part A – View and Change

1. Click the Start button, type services, and then click Services.
2. Scroll down and then double-click the Print Spooler service.
3. In the Print Spooler Properties (Local Computer) dialog box, read the information for the service and then click Cancel. Notice that the Startup type is Automatic. **Grab a screenshot.**
4. Click the Start button, type `regedit`, and then click Registry Editor
5. In the User Account Control dialog box, click Yes.
6. In the Registry Editor, navigate to **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler**.
7. Right-click Spooler and then click Export.
8. In the Export Registry File window, click This PC and then double-click Local Disk (C:).
9. In the File name box, type `SpoolerBak` and then click Save.
10. In the Registry Editor, double-click Start.
11. In the Edit DWORD (32-bit) Value dialog box, in the Value data box, type 4, **Grab a screenshot** and then click OK.
12. In the Services window, press F5 to refresh the view, verify that the value in the Startup Type column for the Print Spooler service is now Disabled, **grab a screenshot** and then close the Services window.
13. In the Registry Editor, collapse all the hives so that no keys are visible and then close the Registry Editor window.

### Part B – Restore a Backup

1. On the taskbar, click File Explorer, navigate to C:\, and then double-click **SpoolerBak**.
2. In the User Account Control dialog box, click Yes. Notice that the Registry Editor is being started.
3. In the Registry Editor window, click Yes to continue.
4. Click OK to acknowledge the successful import and then close the File Explorer window.
5. Click the Start button, type regedit, and then click Registry Editor.
6. In the User Account Control dialog box, click Yes.
7. In the Registry Editor, expand HKEY_LOCAL_MACHINE and then click SYSTEM.
8. Click Edit on the menu bar and then click Find.
9. In the Find dialog box, in the Find what box, type spooler.
10. In the Look at area, deselect all check boxes except Keys and then click Find Next.
11. Keep pressing F3 to Find Next until the Print Spooler service identified in the previous activity is located. This will take about 5–10 presses, but review the information that is found along the way.
12. Read the Start value and verify that it has been set back to 2. **Grab a screenshot.**
13. Click the Start button, type services, and then click Services.
14. Scroll down to the Print Spooler service and verify that the Startup Type is Automatic.
15. Close all open windows.

### Part C – Commandline

1. If necessary, start your computer and sign in.
2. Right-click the Start button, click Windows PowerShell (Admin), and then click Yes in the User Account Control dialog box.
3. At the Windows PowerShell prompt, type `reg /?` and then press Enter to view the general help information.
4. Type `reg query /?` and then press Enter to view the query help information. Scroll up and down to read all of it.
5. Type `reg query HKLM\SYSTEM\CurrentControlSet\Services\Spooler` and then press Enter. Verify that the Start value is 0×2.
6. Type `reg add /?` and then press Enter to view the add help information. Scroll up and down to read all of it.
7. Type `reg add HKLM\SYSTEM\CurrentControlSet\Services\Spooler /v Start /d 0×4` and then press Enter. This sets the Start value to 0×4.
8. Press Y and then press Enter to confirm overwriting the value.
9. Type `reg query HKLM\SYSTEM\CurrentControlSet\Services\Spooler` and then press Enter. Verify that the Start value is 0×4. **Grab a screenshot.**
10. Type `reg import /?` and then press Enter to view the import help information.
11. Type `reg import C:\SpoolerBak.reg` and then press Enter.
12. Type `reg query HKLM\SYSTEM\CurrentControlSet\Services\Spooler` and then press Enter. Verify that the Start value is 0x2 as it was restored from the backup. **Grab a screenshot.**
13. Close the Windows PowerShell prompt window.

### Part D – Powershell

1. Right-click the Start button and then click Windows PowerShell (Admin).
2. In the User Account Control dialog box, click Yes.
3. At the Windows PowerShell prompt, type `Get-PSDrive` and then press Enter. You can see that HKCU and HKLM are available.
4. Type `Set-Location HKLM:` and then press Enter or use the alias `cd HKLM:` . Notice that the prompt has changed to indicate you are in HKLM.
5. Type `Get-ChildItem` or try the alias `ls` and then press Enter. You can see the same registry keys as in regedit.
6. Type `Set-Location SYSTEM\CurrentControlSet\Services\Spooler` and then press Enter.
7. Type `Get-ItemProperty .` and then press Enter. The period in this command represents the current folder of Spooler. Notice that Start has a value of 2.
8. Type `Set-ItemProperty . -Name Start -Value 4` and then press Enter. **Grab a screenshot.**
9. Type `Get-ItemProperty .` and then press Enter. Verify that Start has a value of 4.
10. Type `reg import C:\SpoolerBak.reg` and then press Enter.
11. Close the Windows PowerShell prompt window.

## Activity 6 – MSI App Install

1. On the taskbar, click **Microsoft Edge**. In Microsoft Edge, in the address bar, type `https://www.7-zip.org/download.html` and then press Enter.
2. On the Download page, in the first table, in the row with Type of .msi and Windows 64-bit x64, click Download and then click Save.
3. When the download is complete, click **Open folder**.
4. In the File Explorer window, double-click the file you downloaded. This starts an installation with the standard user interface.
5. Click Cancel to stop the installation, click **Yes** to confirm, and then click **Finish**.
6. Close the File Explorer window.
7. Click the Start button, type `cmd`, and then click **Run as administrator** below Command Prompt. It is preferable to use a command prompt for this task because the syntax is not interpreted properly by a Windows PowerShell prompt.
8. In the User Account Control dialog box, click Yes.
9. At the command prompt, to change to the downloads folder, type `cd \users\user1\downloads` and then press Enter. If necessary, substitute user1 with the name of your user account.
10. To view the MSI files in the current directory, type `dir *.msi` and then press Enter. Verify that the file you just downloaded is listed.
11. To view the options for misexec.exe, type `msiexec.exe /?` and then press Enter.
12. In the Windows Installer dialog box, scroll down, read the available options, and then click OK.
13. At the command prompt, to install 7-Zip silently, type `msiexec.exe /i 7z1900-x64.msi INSTALLDIR="C:\Program Files\7-Zip" /quiet` and then press Enter. The INSTALLDIR variable could also be set by using a transform file. If necessary, substitute 7z1900-x64.msi with the name of the file you downloaded. **Screenshot it!**
14. Click the Start button and then click Settings.
15. In the Settings window, click Apps and then verify that 7-Zip is in the list of installed apps.
16. Close the Settings window.
17. At the command prompt, to remove 7-zip silently, type `msiexec.exe /x 7z1900-x64.msi /quiet` and then press Enter. If necessary, substitute 7z1900-x64.msi with the name of the file you downloaded (remember tab will autocomplete!). **Screenshot it!**
18. Click the Start button and then click Settings.
19. In the Settings window, click Apps and then verify that 7-Zip is not in the list of installed apps. **Screenshot it!**
20. Close all open windows.

## Activity 7 – UWP Apps

1. On the taskbar, click Microsoft Store.
2. In the Microsoft Store window, in the Search box, type Whiteboard and then press Enter.
3. In the list of search results, click **Microsoft Whiteboard**.
4. Read the information about Microsoft Whiteboard and then click **Get**.
5. In the Use across your devices dialog box, click **No, thanks**.
6. Wait while Microsoft Whiteboard downloads and installs.
7. Close the Microsoft Store window.
8. Right-click the Start button and then click **Windows PowerShell (Admin)**.
9. In the User Account Control dialog box, click Yes.
10. At the Windows PowerShell prompt, to view a list of installed packages, type `Get-AppPackage` and then press Enter. Microsoft Whiteboard appears at the end of the list. **Screenshot it!**
11. To display a simplified list, type `Get-AppPackage | Format-List Name` and then press Enter.
12. To view only information about Microsoft Whiteboard, type `Get-AppPackage -Name Microsoft.Whiteboard` and then press Enter.
13. To remove Microsoft Whiteboard, type `Get-AppPackage -Name Microsoft.Whiteboard | Remove-AppPackage` and then press Enter. **Screenshot it!**
14. Close the Windows PowerShell window.