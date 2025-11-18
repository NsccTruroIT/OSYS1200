# OSYS1200 Lab 

Last Updated: November 05, 2025 11:57 AM
Created By: Matt Redmond
Edited By: Don Geraghty
Course: OSYS1200

# Lab 7 – Performance and Recovery!

> - Administrator privileges required for Activities 3, 4, 5, and 8.  
> - Ensure at least 5 GB free disk space for Activity 6 (File History).  
> - Do NOT perform Activity 8 (System Reset) on personal machines.

## Activity 1 – Task Manager

1.  If necessary, start your computer and sign in.
2.  Click the **Start** button, in the search box type `cmd`, and then press **Enter**.
3.  In the command prompt window, type `mspaint` and then press **Enter**.
4.  **[Win 11 Update]** Press **Ctrl + Shift + Esc** to open Task Manager. (Alternatively, you can right-click the **Start** button and choose **Task Manager**).
5.  **[Win 11 Update]** The new Windows 11 Task Manager opens. It uses a navigation bar on the left. If the bar is collapsed, you may only see icons. Click the **Processes** icon (it looks like a list) if it's not already selected.
6.  You can see that both the command prompt and Paint are listed in the Apps section.
7.  Expand **Windows Command Processor (2)**. Notice that two processes are listed for this App.
8.  Right-click **Windows Command Processor** and then click **Go to details**. This switches to the Details tab, with `cmd.exe` selected. **Screenshot it!**
9.  Right-click `cmd.exe` and then click **End process tree**.
10. Read the warning and then click **End process tree**. This closes both the command prompt and Paint because Paint was started by the command prompt.
11. Click the **CPU** column header once. This sorts the processes by CPU utilization.
12. **[Win 11 Update]** On the left-side navigation bar, click the **Services** icon (it looks like a puzzle piece). This tab displays the status of services running on the computer.
13. **[Win 11 Update]** On the left-side navigation bar, click the **Performance** icon (it looks like a graph). This tab provides basic CPU and memory utilization information. **Screenshot it!**
14. Click **Ethernet** (or **Wi-Fi**) on the list to display an overview of network utilization and status.
15. **[Win 11 Update]** On the left-side navigation bar, click the **Users** icon (it looks like a person). This tab displays a list of all users who are signed in.
16. Close the Task Manager window.

### Activity 2 (Revised) - Resource Monitor

1.  If necessary, start your computer and sign in.
2.  Click the **Start** button, type `resource`, and then click **Resource Monitor**.
3.  Click the **Overview** tab if it is not already selected. Review the graphs at the right side of the screen for CPU, Disk, Network, and Memory.
4.  Expand the **CPU** summary bar if it is not already expanded and review the listed processes in the Image column.
5.  Click the **CPU** column header so that a down arrow appears. This sorts the processes from highest to lowest.
6.  Collapse the **CPU** summary bar and expand the **Disk** summary bar. Read the information about each process.
7.  Collapse the **Disk** summary bar and expand the **Network** summary bar. Read the information about each process.
8.  Collapse the **Network** summary bar and expand the **Memory** summary bar. Read the information about each process.
9.  Click the **CPU** tab, and in the Processes area, click the **Image** column header twice to sort alphabetically from A to Z. **Screenshot it!**
10. Select the **explorer.exe** process by checking the box next to its name.

    > **Note:** When you check the box next to a process, Resource Monitor filters all other panels (like Associated Handles, Modules, and the graphs) to show *only* data related to that process. It also pins it to the top of the list until you uncheck it.

11. Expand the **Associated Handles** summary bar. Scroll down and review the resources.
    * **What is a Handle?** A Handle is a reference to a resource that the process is using. Think of it as a "ticket" that `explorer.exe` is holding to access a file, a registry key, or a folder.
12. Collapse the **Associated Handles** summary bar and expand the **Associated Modules** summary bar. Scroll down and review the files.
    * **What is a Module?** A Module is a supporting file (like a `.dll` or "Dynamic Link Library") that the main `explorer.exe` program needs to run. These are like "helpers" it calls on to get work done.
13. In the Processes area, uncheck **explorer.exe** to show information for all processes again.

14. **[New Addition]** Let's test the **Suspend Process** feature.
    * a. Open **Notepad** (Click Start, type `notepad`, and open it).
    * b. Go back to Resource Monitor, find `notepad.exe` in the **CPU** tab's "Processes" list.
    * c. Right-click **notepad.exe** and select **Suspend Process**. Click **Suspend Process** to confirm.
    * d. Go back to your Notepad window. Try to type in it or close it. It will be completely frozen. **Screenshot or explain your findings**
    * e. Go back to Resource Monitor, right-click **notepad.exe** and select **Resume Process**.
    * f. Check your Notepad window again. It is now unfrozen and works perfectly. This is a useful troubleshooting step for a "stuck" application.

15. Click the **Memory** tab. Look at the **Physical Memory** bar graph at the bottom. This gives you a great visual breakdown of how your computer's RAM is being used (Hardware Reserved, In Use, Standby, Free). **Screenshot**
16. Click the **Disk** tab. In the "Disk Activity" panel, click the **Total (B/sec)** column header to see which processes are reading or writing the most data to your hard drive *right now*.
17. Click the **Network** tab. In the "Network Activity" panel, click the **Total (B/sec)** column header. This shows you which processes are using your network or internet connection the most.**Screenshot**
18. Close Resource Monitor and Notepad.

## Activity 3 (Revised) – Performance Monitor

#### Part A – Setting up the Graph

1.  If necessary, start your computer and sign in.
2.  Click the **Start** button, type `Performance`, and then click **Performance Monitor**.
3.  In the Performance Monitor window, expand **Monitoring Tools**, and select **Performance Monitor**.
4.  By default, the **% Processor Time** counter is shown. Click on it in the counter list at the bottom of the screen and press the **Delete** key. We will build our own graph from scratch.
5.  In the toolbar, click the **Add** button (the green plus symbol).

    > **Understanding Counters:** We are about to add the "Big Three" counters to monitor a PC's health: CPU, Memory, and Disk.
    > * **CPU:** `% Processor Time` - What percentage of the CPU's power is being used.
    > * **Memory:** `Available MBytes` - How much RAM is free.
    > * **Disk:** `Avg. Disk sec/Transfer` - The *time* (latency) it takes your disk to respond to a request. This is the best way to see if your disk is "slow."

6.  In the list of "Available counters," find **Processor**, expand it, and click **% Processor Time**.
7.  In the "Instances of selected object" box, click **\_Total** (this monitors all CPU cores combined). Click **Add**.
8.  Now find **Memory** in the counter list, click **Available MBytes**, and click **Add**. (It has no other instances).
9.  Finally, find **PhysicalDisk** in the counter list, click **Avg. Disk sec/Transfer**.
10. In the "Instances of selected object" box, click **\_Total** (this monitors all physical disks).
11. Click **Add** and then click **OK**.

12. **Fixing the Graph:** Look at your graph. It's a mess! The CPU line is bouncing, but the `Available MBytes` line is probably a flat line at the top, and the `Avg. Disk sec/Transfer` line is a flat line at the bottom. This is because the "Scale" is wrong. The graph's Y-axis is 0-100 by default.
    * Your `Available MBytes` (e.g., 8000) is way above 100, so it's off the chart.
    * Your `Avg. Disk sec/Transfer` (e.g., 0.002) is so small it looks like 0.

13. Let's fix this. At the bottom of the screen, find the **Available MBytes** counter. Right-click it and choose **Properties**.
14. Change the **Scale** dropdown to **0.001**. (This will multiply the value, so 8000 MBytes will plot on the graph as '8'). Click **OK**.
15. Now, find the **Avg. Disk sec/Transfer** counter. Right-click it and choose **Properties**.
16. Change the **Scale** dropdown to **1000**. (This will make a small latency like '0.01' plot on the graph as '10').
17. In the same Properties box, go to the **Style** tab, and change the **Color** to a bright red so it stands out. Click **OK**.
18. Your graph should now be much more useful, with all three counters bouncing in the 0-100 range. **Screenshot it!**

#### Part B – Stressing the System

Now we'll make the graphs react by putting the system under load. Keep your Performance Monitor window visible.

1.  Click the **Start** button, type `PowerShell`, right-click **Windows PowerShell**, and select **Run as administrator**.
2.  Click **Yes** on the UAC prompt. We will use this to stress the Disk and CPU.
3.  First, let's stress the **Disk**. We'll create a 5GB test file. First, make a temp directory by typing:
    `mkdir C:\temp`
4.  Press **Enter**. Now, type the following command to create the file and press **Enter**:
    `fsutil file createnew C:\temp\testfile.tmp 5368709120`
5.  **Watch your Performance Monitor!** As the file is being created, you will see the red **Disk** (Avg. Disk sec/Transfer) line spike, showing high latency.
> **Warning:** The following CPU stress loop will max out your processor.  
> Press **Ctrl + C immediately after taking your screenshot** to stop it.  
> Leaving it running may freeze your system.
6.  Now, let's stress the **CPU**. In the same PowerShell window, type this one-line loop and press **Enter**:
    `while($true){ $i = 1 }`
7.  **Watch your Performance Monitor!** Your **% Processor Time** line will immediately spike to 100% and stay there. Your computer fan may even spin up.
8.  Let the graph run for about 15-20 seconds with both spikes visible. **Screenshot the graph showing your CPU and Disk spikes!**
9.  Click back to the PowerShell window and press **Ctrl + C** to stop the CPU loop.
10. To clean up, delete the test file by typing:
    `rm C:\temp\testfile.tmp`
11. Close the PowerShell window.

#### Part C – Graph Types

1.  Back in Performance Monitor, let's look at other views.
2.  On the toolbar, click the **Change graph type** button (or press **Ctrl+G**). This changes the graph to a bar chart. **Screenshot it!**
3.  Click the **Change graph type** button again. This changes the graph to a report, showing the raw numbers. **Screenshot it!**
4.  In the left pane, right-click **Performance Monitor** and then click **Properties**. On the **General** tab, you can modify the graph sample rate and the time span that is displayed.
5.  Click **Cancel** and close all open windows.

## Activity 4 (Revised) – Automatic Startup

> **Understanding Startup Locations:** Windows has many places where programs can be told to run at login. This is a common feature for legitimate programs (like OneDrive, Steam, or antivirus) to start automatically. It is *also* a primary target for malware to hide and run every time you boot up. We will explore three of the most common user-level locations.

#### Part A – The "Startup" Folder (Persistent)

1.  If necessary, start your computer and sign in.
2.  On the taskbar, click **File Explorer**.
3.  In the File Explorer window, in the address bar, type `shell:startup` and then press **Enter**. This is a special shortcut that takes you to the current user's personal Startup folder.
4.  Right-click an open area, point to **New**, and then click **Shortcut**.
5.  In the "Type the location of the item" text box, type `C:\Windows\System32\notepad.exe` and then click **Next**.
6.  In the "Type a name for this shortcut" text box, type `AutoNotepad` and then click **Finish**. **Screenshot the File Explorer window showing your new shortcut!**
7.  Close the File Explorer window.
8.  Press **Ctrl + Shift + Esc** to open Task Manager.
9.  Click the **Startup apps** icon on the left-side navigation bar.
10. Look at the list. You will see your `AutoNotepad` shortcut listed, and its "Status" will be "Enabled." **Screenshot it!**
11. Close Task Manager.

#### Part B – The "Run" Registry Key (Persistent)

Now we will add another persistent startup item, but this time using the Registry, just like many applications do.

1.  Click the **Start** button, type `registry`, and then click **Registry Editor**. Click **Yes** at the UAC prompt.
2.  In the Registry Editor window, navigate to the *exact* same key as before, but without "Once":
    `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`
3.  Click **Edit** on the menu bar, point to **New**, and then click **String Value**.
4.  Type `MyCalc` and then press **Enter** to name the value.
5.  Double-click **MyCalc**, in the **Value data** box, type `C:\Windows\System32\calc.exe`, and then click **OK**. **Screenshot the Registry Editor window showing your new 'MyCalc' value!**
6.  *Do not close the Registry Editor yet.*
7.  Open **Task Manager** again (**Ctrl + Shift + Esc**) and go to the **Startup apps** tab.
8.  Notice that your new registry entry, `MyCalc`, is *also* listed here, right next to `AutoNotepad`. Task Manager is the central place to manage all these different locations.
9.  Close Task Manager.

#### Part C – The "RunOnce" Registry Key (Temporary)

Finally, we'll look at a *temporary* startup key.

1.  In your open Registry Editor, navigate to the `RunOnce` key:
    `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce`
2.  Click **Edit** on the menu bar, point to **New**, and then click **String Value**.
3.  Type `Paint` and then press **Enter** to name the value.
4.  Double-click **Paint**, in the **Value data** box, type `C:\Windows\System32\mspaint.exe`, and then click **OK**. **Screenshot this window, showing the 'Paint' value in the 'RunOnce' key!**
5.  *Keep the Registry Editor open.*
6.  Open **Task Manager** one more time and check the **Startup apps** tab. Notice that `Paint` is **NOT** listed. The `RunOnce` key is temporary and hidden; it is not meant to be managed by the user.
7.  Close Task Manager and the Registry Editor.

#### Part D – Testing and Cleanup
> **Important:** Complete all cleanup steps before leaving the lab.  
> If you skip this, apps will keep launching at startup.

1.  **Sign out** of your computer and then **sign in** again.
2.  When you log in, all three programs should start automatically: **Notepad**, **Calculator**, and **Paint**. **Take a screenshot showing all three applications open on your desktop!**
3.  Open the **Registry Editor** (Click Start, type `registry`).
4.  Navigate back to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce`. Notice that the `Paint` value is **gone**.
5.  Now navigate to the `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` key. Notice that `MyCalc` is **still there**. **Take a screenshot of your Registry Editor showing both the empty 'RunOnce' key and the 'Run' key with 'MyCalc' still in it!** (You may need to position the window to show both panes).
6.  Close the Registry Editor.
7.  **Sign out and sign in one more time.**
8.  This time, **Notepad** and **Calculator** will open, but **Paint** will not. This confirms the difference between `Run` and `RunOnce`.
9.  Close Notepad and Calculator.
10. **Final Cleanup:**
    * a. Open **Task Manager** > **Startup apps**.
    * b. Right-click `AutoNotepad` and select **Disable**.
    * c. Right-click `MyCalc` and select **Disable**. This stops them from running, but doesn't delete them.
    * d. To fully remove them, open File Explorer and type `shell:startup` in the address bar. **Delete** the `AutoNotepad` shortcut.
    * e. Open the **Registry Editor**, navigate to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`, right-click the `MyCalc` value, and select **Delete**.
11. Close all open windows.

### Activity 5 (Revised) – System Events

> **Understanding Event Logs:** The Windows Event Viewer is the central log book for *everything* that happens on your computer. When a service fails, a user logs in, or an application crashes, a log "event" is created. This is one of the most important tools for troubleshooting.
>
> Windows logs are primarily organized into three categories:
> * **Application:** Logs from software (like Chrome, Office, or games).
> * **Security:** Login attempts (success and failure), elevated privileges.
> * **System:** Logs from Windows itself (drivers, services, hardware events).

#### Part A – Creating and Finding an Event (Event Viewer)

First, we need to create an event so we have something specific to look for.

1.  If necessary, startup your computer and sign in.
2.  Click the **Start** button, type `Task Scheduler`, and click **Open**.
3.  In the Task Scheduler window, click **Action** on the menu bar and select **Create Basic Task...**
4.  For the "Name", type `Lab 8 Test Task` and click **Next**.
5.  For the "Trigger", select **One time** and click **Next**.
6.  Accept the default "Start" time and click **Next**.
7.  For the "Action", select **Start a program** and click **Next**.
8.  In the "Program/script" box, type `cmd.exe` and click **Next**.
9.  On the "Summary" screen, review your task. **Screenshot this summary window!** Click **Finish**.
10. In the main Task Scheduler window, find your `Lab 8 Test Task` in the list. Right-click it and select **Run**. A `cmd` window will flash open and close.
11. Now, find the task again, right-click it, and select **Delete**. Click **Yes**.
12. Close Task Scheduler. We have now created (and deleted) a task, and this activity is logged in the Event Viewer.

Now, let's find the logs for what we just did.

13. Click the **Start** button, type `event`, and then click **Event Viewer**.
14. In the left navigation pane, expand **Applications and Services Logs**, then expand **Microsoft**, then **Windows**.
15. Scroll all the way down and find **TaskScheduler**. Expand it and click on the **Operational** log.
16. In the center pane, you will see a list of all recent task events. The top events should be the ones you just performed.
17. Look for an event with **Event ID 106** (Task registered) and the "Task Name" `Lab 8 Test Task`. Double-click it to see the details. **Screenshot the General tab for this event!**
18. Close the event details. Now find the event with **Event ID 200** (Action started) and **Event ID 107** (Task deleted). This is the exact record of your activity.

#### Part B – Filtering and Custom Views

1.  Now let's look at the main system logs. In the left navigation pane, click on **Windows Logs**.
2.  Click the **System** log. Notice how busy it is.
3.  In the **Actions** pane on the right, click **Filter Current Log...**
4.  In the "Event sources" dropdown, find and select **Service Control Manager**. Click **OK**.
5.  Now the log only shows events from the `Service Control Manager`. **Screenshot this filtered log view!**
6.  In the **Actions** pane, click **Clear Filter**.
7.  In the left navigation pane, under "Custom Views", click **Administrative Events**.
8.  This is a pre-filtered "summary" view that collects all **Error** and **Warning** events from all the major logs into one place. This is often the first place an administrator will look to see if a computer is having problems. **Screenshot this window!**

#### Part C – PowerShell (Get-WinEvent)

1.  Open PowerShell as an **administrator** (Click Start, type `PowerShell`, right-click **Windows PowerShell**, and click **Run as administrator**).
2.  The `Get-WinEvent` command is the PowerShell equivalent of Event Viewer. First, let's see all the logs on the system. (You can press **Ctrl+C** to stop it after it scrolls for a bit).
    `Get-WinEvent -Listlog *`
3.  Now, let's get the 10 most recent events from the main `System` log. **Screenshot the output of this command!**
    `Get-WinEvent -LogName System -MaxEvents 10`
4.  Finally, let's find the *exact* logs for the task we created earlier. The log name is `Microsoft-Windows-TaskScheduler/Operational`. Let's get the 5 most recent events from it.
    `Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" -MaxEvents 5`
5.  This shows the raw data, but it's hard to read. Let's pipe the most recent one to `Format-List` to see all its properties, just like we did in the Event Viewer GUI.
    `Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" -MaxEvents 1 | Format-List *`
6.  **Screenshot the PowerShell window showing the output of this final command!**
7.  Close all open windows.

### Activity 6 (Revised) – File History

> **Understanding File History:** File History is Windows' built-in, automatic backup tool for user files. It works by "snapshotting" your libraries (Desktop, Documents, Pictures, etc.) and saving any changes to a *separate* drive. It requires a second drive to function (like a USB drive or network share).
>
> We don't have a second drive, so we will create a **Virtual Hard Disk (VHD)** to *simulate* one.

> **Important for VHD Creation:**  
> - Ensure your VM has at least **5 GB of free space** on the C: drive.  
> - You must have **administrator privileges** to create and mount a VHD.  
> - If you encounter errors, check disk space or confirm you are logged in as an admin.

> **Performance Tip:** VHD creation may take longer on virtual machines with dynamically allocated disks. Be patient during this step.

1.  If necessary, start your computer and sign in.
2.  **[New Addition]** Open **File Explorer** and navigate to your `C:\` drive. Create a new folder named `Storage`. This is where we will save our virtual disk.
3.  Right-click the **Start** button and then click **Disk Management**.
4.  Click **Action** on the menu bar and then click **Create VHD**.
5.  For "Location", browse to `C:\Storage\VHDFileHistory.vhdx`.
6.  Change the "Virtual hard disk size" unit from MB to **GB** and type `4`.
7.  In the "Virtual hard disk format" area, click **VHDX**.
8.  Confirm that **Dynamically expanding** is selected and then click **OK**.
9.  In the bottom pane, scroll to the new 4 GB disk (e.g., "Disk 2"). It will say "Unknown" and "Not Initialized." Right-click the *disk name* and then click **Initialize disk**.
10. Accept the default settings (GPT) and click **OK**.
11. The disk now says "Online." Right-click the large "Unallocated" space on that disk and then select **New Simple Volume**.
12. In the New Simple Volume Wizard, click **Next** twice to accept the default size.
13. Note the assigned drive letter (e.g., `E:`). **Screenshot the drive letter assignment screen!** Click **Next**.
14. In the "Volume label" box, type `File History Data` and then click **Next**.
15. Click **Finish**. Your new drive is now formatted and ready.
16. **[New Addition]** Your Disk Management window should now show the new disk as "Online" and "Healthy." **Screenshot the bottom pane of Disk Management showing your new 'File History Data' drive!**
17. Close the Disk Management window.
18. Click the **Start** button and then click **Settings**.
19. **[Win 11 Update]** In the Settings window, click **System** on the left, then click **Storage**.
20. **[Win 11 Update]** Scroll down and click **Advanced storage settings**, and then click **Backup options**.
21. Under the heading "Back up using File History," click **Add a drive**.
22. When the drive search completes, click the drive labeled **File History Data**.
23. The "Add a drive" section is replaced with a toggle switch. **Screenshot this 'Backup options' window showing the drive is enabled!**
24. Click **More options**.
25. In the "Back up my files" box, select **Every 10 minutes**.
26. In the "Keep my backups" box, select **Until space is needed**.
27. Below "Overview," click **Back up now**. This will perform the first backup.
28. Close the Settings window.
 ### Update: Step 21 - Configuring File History (Windows 11)

*Note: Microsoft has moved the legacy File History settings out of the main Settings app. Please use the following instructions to complete this step via the Control Panel.*

1. Click the **Start** button.
2. Type **Control Panel** and press **Enter**.
3. In the Control Panel, change the "View by" setting (top right) to **Large icons**.
4. Click on **File History**.
5. Click **Select drive** on the left-hand menu.
6. Select the drive labeled **File History Data** and click **OK**.
7. Click the **Turn on** button (if it is not already on).
    > **Deliverable:** Screenshot this window showing the drive is enabled (Status should read "File History is on").
8. Click **Advanced settings** on the left-hand menu.
9. In the "Save copies of files" box, select **Every 10 minutes**.
10. In the "Keep saved versions" box, select **Until space is needed**.
11. Click **Save changes**.
12. Back on the main screen, click **Run now** (under the drive info) to perform the first backup.
13. Close the Control Panel.   

---

### Activity 7 (Revised) – Restore

1.  If necessary, start your computer and sign in.
2.  On your **Desktop**, right-click, point to **New**, and then click **Text Document**.
3.  Edit the name to be `Grocery List` and press **Enter**.
4.  Double-click the **Grocery List** text document. In the Notepad editor, enter the text `Version one – eggs`.
5.  Exit Notepad and click **Save**.
6.  Click the **Start** button, type `backup`, and then click **Backup settings**.
7.  Below "Back up using File History," click **More options** and then click **Back up now**. This forces a backup of "Version one."
8.  Leave the Settings window open.
9.  On the Desktop, double-click the **Grocery List** text document.
10. Edit the text to read `Version two – eggs, apples`.
11. Exit Notepad and click **Save**.
12. In the Settings window, click **Back up now**. This forces a backup of "Version two."

#### Part A - Restore using "Previous Versions"

1.  On the Desktop, right-click the **Grocery List** document, click **[Win 11 Update]** **Show more options**, and then click **Restore previous versions**.
2.  A "Properties" window opens. You should see two different backups listed in the "File versions" box. **Screenshot this 'Previous Versions' tab!**
3.  Select the **oldest** version (the one from a few minutes ago) and click the **Restore** button.
4.  In the "Replace or Skip Files" dialog box, click **Replace the file in the destination**.
5.  Open the **Grocery List** file on your desktop. You will see it has reverted to `Version one – eggs`.
6.  Exit Notepad and close the Grocery List Properties dialog box.

#### Part B - Restore using the File History UI

1.  Open **File Explorer** and click on your **Desktop** in the navigation pane.
2.  Click the **[Win 11 Update]** **...** (See more) button in the command bar at the top, and then click **History**.
3.  The File History window opens, showing your Desktop folder. Click the **right arrow** (Next) at the bottom to go to the most recent backup.
4.  You should see your `Grocery List.txt` file. Double-click it to preview it. It will show `Version two – eggs, apples`. **Screenshot this File History preview!**
5.  Confirm that version two is displayed, then click the **Restore to original location** (green circular arrow) button at the bottom.
6.  In the "Replace or Skip Files" dialog box, click **Replace the file in the destination**.
7.  Close the File History window. The `Grocery List.txt` on your desktop now shows "Version two" again.
8.  In the **Settings** window, scroll to the bottom and click **Stop using drive**.
9.  Close all open windows.

---

### Activity 8 (Revised) – System Reset

> **Critical Warning:** This activity will reinstall the Windows 11 operating system. While "Keep my files" *should* protect your data, you should **NEVER** do this on a personal computer you care about.
>
> This activity is intended *only* for lab machines or virtual machines that can be erased.

1.  If necessary, start your computer and sign in.
2.  Click the **Start** button and then click **Settings**.
3.  **[Win 11 Update]** In the Settings window, click **System** on the left, and then click **Recovery** on the right.
4.  In the "Recovery options," find the **Reset this PC** section and click the **Reset PC** button.

#### Part A - Investigating "Remove everything"

1.  In the "Reset this PC" window, click **Remove everything**.
2.  Select **Local reinstall**.
3.  On the "Additional settings" screen, it will show you a summary. Click **Change settings**.
4.  On the "Choose settings" screen, read the available options (e.g., "Clean data?"). This option is for securely wiping a drive. **Screenshot this 'Choose settings' window!**
5.  Click **Cancel** to go back.
6.  On the "Additional settings" screen, click **Cancel** again. You will be returned to the main Settings window. We are **not** proceeding with this option.

#### Part B - Performing "Keep my files"

1.  In the **System > Recovery** settings page, click the **Reset PC** button again.
2.  This time, click **Keep my files**.
3.  Select **Local reinstall**.
4.  On the "Additional settings" screen, click **Next**.
5.  On the "Ready to reset this PC" screen, it will warn you what will happen. Click the **View apps that will be removed** link.
6.  This list shows all desktop apps that will be uninstalled (apps from the Microsoft Store are usually kept). **[New Addition] Take a screenshot of the 'apps that will be removed' list!** (If it's empty, that's fine, just screenshot that).
7.  Click **Back**.
8.  On the "Ready to reset this PC" screen, click **Reset**. **Screenshot the final "Ready to reset this PC" screen!**
9.  **DO NOT PROCEED** unless you are on a lab machine you are authorized to reset.
10. If you *do* proceed, the reset will take 30-60 minutes, and the system will reboot several times.
11. After the reset, sign in. You should find a new file on your desktop named **Removed Apps.html**. **Screenshot your desktop showing this new file!**

## ✅ Lab Completion Checklist

### Screenshots Required:
- Activity 1: Task Manager – Details tab with `cmd.exe` selected.
- Activity 1: Performance tab graph.
- Activity 2: CPU tab sorted alphabetically.
- Activity 2: Suspend Process test (Notepad frozen).
- Activity 2: Memory tab physical memory bar.
- Activity 2: Network tab activity panel.
- Activity 3: Performance Monitor graph with counters.
- Activity 3: Graph type changes (bar chart and report).
- Activity 4: Startup folder showing AutoNotepad shortcut.
- Activity 4: Task Manager Startup tab showing AutoNotepad and MyCalc.
- Activity 4: Registry Editor showing MyCalc value.
- Activity 4: Registry Editor showing RunOnce Paint value.
- Activity 4: Desktop showing Notepad, Calculator, Paint after sign-in.
- Activity 4: Registry Editor showing empty RunOnce and Run with MyCalc.
- Activity 5: Task Scheduler summary window.
- Activity 5: Event Viewer – Event ID 106 details.
- Activity 5: Event Viewer filtered log view.
- Activity 5: Administrative Events view.
- Activity 5: PowerShell Get-WinEvent outputs (System log and TaskScheduler).
- Activity 6: Disk Management – drive letter assignment.
- Activity 6: Disk Management – File History Data drive healthy.
- Activity 6: Settings Backup options showing drive enabled.
- Activity 7: Previous Versions tab showing two versions.
- Activity 7: File History preview showing Version two.
- Activity 8: Choose settings screen for Remove everything.
- Activity 8: Apps that will be removed list.
- Activity 8: Ready to reset this PC screen.
- Activity 8: Desktop showing Removed Apps.html (if reset performed).

### Input/Action Points:
- Activity 2: Explain findings after Suspend Process test.
- Activity 7: Confirm restored version after Previous Versions and File History restore.