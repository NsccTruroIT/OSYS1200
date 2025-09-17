# Windows 11 Tools and Utilities

>💡To ensure consistency, this activitiy is designed to be completed using your provided Windows 11 Virtual Machine. Use our Get-VM Console page to start and connect to your Virtual Machine.

>💡Practice your workflow. Keep these instructions and your Lab Documentation open on your local machine and use the console to your Virtual Machine to execute the steps. Screenshots will be easiest to work with if you switch back to your local machine and then take a screenshot of the console window. 

## Activity 1 – System Settings VS Control Panel (Windows 11 Edition)

1. **Start your computer and sign in** if necessary.
1. **Click the Start button** (Windows icon on the taskbar) and then click **⚙ Settings** (or press **Win + I** to open Settings directly).
1. In the **Settings** window, click **System**, then scroll down and click **About**.
1. **Review your device specifications**: processor type and speed, installed RAM, device name, and Windows specifications. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot 📷</mark>
1. In the left-hand menu (or use the search bar at the top), click **Apps**, then **Installed apps**.
    - Use the search bar to find **Discord**.
    - Note the version number listed.
1. In the **Apps** section, click **Startup**.
    - Review the list of apps that launch at startup.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this list.
    >💡 _Tip: If you're using a remote desktop or Azure Labs, take the screenshot from your host machine using_ **_Win + Shift + S_** _after clicking outside the remote window._
1. Go back to **System > Storage**, then click **Show more categories** under “Local Disk (C:)”.
    - Review the breakdown of storage usage by category.
1. Return to the **Settings home page** and explore other available settings.
    - Choose one that interests you (e.g., **Personalization**, **Accessibility**, or **Privacy & Security**).
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> and **caption it** with a brief description of what it shows and why it interests you.
1. **Close the Settings window**.
1. Click the **Start button**, type **Control Panel**, and open it.
1. In Control Panel, click **System and Security**, then click **System**.
    - Notice how this redirects you to the **Settings > About** page.
1. Scroll down or look to the right and click **BitLocker Settings**.
    - This should redirect you back to the **Control Panel**.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this page.

## Activity 2 – Steam is the Devil

Some users have complained recently about an application that seems to start every time the log in to their machine. Please **provide a set of instructions** that can be followed to stop this application from running.

Option (Choose One):

1. Document the steps to stop Steam from starting automatically.
2. Document the steps to uninstall/remove Steam.

## Activity 3 – Configure AutoPlay (Windows 11 Edition)

You frequently work with digital images and want Windows 11 to automatically open **File Explorer** when a removable drive or memory card is inserted.

1. **Start your computer and sign in**, if necessary.
2. Click the **Start button**, then click **⚙ Settings** (or press **Win + I**).
3. In the **Settings** window, click **Bluetooth & devices**, then scroll down and click **AutoPlay**.
4. Under **Removable drive**, select **Open folder to view files (File Explorer)** from the dropdown menu.
5. Under **Memory card**, select **Open folder to view files (File Explorer)** from the dropdown menu.
6. **Close the Settings window**.
7. Click the **Start button**, type **Control Panel**, and open it.
8. In the **Control Panel** window, click **Hardware and Sound**, then click **AutoPlay**.
9. Scroll through the list of AutoPlay options.
    - Confirm that the settings for **Removable drive** and **Memory card** match what you configured in Settings.
    - Notice the additional detailed options available here.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this page.
10. **Close the AutoPlay window**.

## Activity 4 – Ease of Access (Windows 11 Edition)

Windows 11 includes several accessibility features to support users with visual and hearing differences. For each item below, **demonstrate** the feature by either taking a screenshot, listing the steps to enable it, sharing a shortcut, or linking to official documentation.

**1\. Magnifier**

- **How to enable**:
  - Press **Win + Plus (+)** to turn on Magnifier.
  - Press **Win + Esc** to turn it off.
- **Alternate method**:
  - Go to **Settings > Accessibility > Magnifier** and toggle it on.
- **Modes available**: Full screen, lens, docked.
- Suggested demonstration: **Screenshot the Magnifier settings page**.

**2\. Inverted Colours**

- **How to enable**:
  - Press **Ctrl + Win + C** to toggle Color Filters (including inverted colors).
- **Alternate method**:
  - Go to **Settings > Accessibility > Color Filters**.
  - Toggle Color Filters on and select **Inverted** or **Grayscale Inverted**.
- <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
- Note: Screenshots may not accurately capture inverted colors due to rendering limitations.
- Microsoft Documentation – Color Filters

**3\. High Contrast**

- **How to enable**:
  - Press **Left Alt + Left Shift + Print Screen** to toggle High Contrast mode.
- **Alternate method**:
  - Go to **Settings > Accessibility > Contrast Themes**.
  - Choose a theme like **High Contrast Black** and click **Apply**.
- **Suggested demonstration: Screenshot** the Contrast Themes selection screen.

**4\. On-Screen Keyboard**

- **How to enable**:
  - Press **Win + Ctrl + O** to toggle the On-Screen Keyboard.
- **Alternate method**:
  - Go to **Settings > Accessibility > Keyboard** and toggle **On-Screen Keyboard**.
- **Suggested demonstration: Screenshot** the On-Screen Keyboard in use or its settings page.

## Activity 5 – MMC Snap-Ins (Windows 11 Edition)

In this activity, you’ll create a custom Microsoft Management Console (MMC) by adding snap-ins of your choice. This allows you to build a personalized administrative toolset. Once complete, you’ll save your configuration as a .msc file and include it with your lab documentation.

Instructions

1. Start your computer and sign in, if necessary.
2. Press Win + R to open the Run dialog box.
3. Type mmc and press Enter.
    - This opens a blank Microsoft Management Console.
4. In the MMC window, click File > Add/Remove Snap-in…
5. In the Add or Remove Snap-ins dialog box:
    - Select a snap-in from the Available snap-ins list (e.g., Event Viewer, Device Manager, Local Users and Groups, etc.).
    - Click Add >.
    - If prompted, choose Local Computer and click Finish.
    - Repeat to add at least two different snap-ins.

<mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of the Add or Remove Snap-ins window showing the snap-ins you’ve added.

1. Click OK to return to the main MMC window.
    - You should now see your selected snap-ins listed in the left-hand pane.

<mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of the MMC window with your snap-ins visible.

1. Click File > Save As…
2. Choose a location to save your custom console (e.g., Desktop or Documents).
3. Name the file something meaningful (e.g., MyAdminTools.msc) and click Save.
4. Close the MMC window

## Activity 6 – Managing Services in Windows 11

1. Start your computer and sign in if it’s not already running.
2. Open Services:
    - Click the Start button or press the Windows key.
    - Type “Services” in the search bar.
    - Click the Services app from the search results.
3. If your PC **has Bluetooth**:
    - Scroll through the list or press **B** to jump to services starting with “B”.
    - Click **Bluetooth Support Service**.
    - On the left pane, you’ll see a brief description of the service.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this view.
4. **If your PC does not have Bluetooth**☹Optional
    - Choose another commonly available service such as **Windows Update**, **Print Spooler**, or **Windows Time**.
    - Click the service name to view its description in the left pane.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of the selected service and its description.
5. Switch to Standard View:
    - At the bottom of the Services window, click the Standard tab.
    - This view simplifies the list by removing the extended descriptions.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
6. Restart Network Connection Broker:

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABAUAAAA1CAYAAAA5zFLKAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAB4GSURBVHhe7d19bBxnnQfwr5N0N01Yl8beK7Hvj7NlV8FtkSUOIdscmACKnIIAcWAqNVSiaC2VKgk+eldzJXdwBUMLsZ2LytkURJX20vR6Ogh0TURpQ3WOdU2hIWls0904aVLbjTdOU29Sukub5/54ZnZnZud91/a+fD/RSPHuPLMzz/ObeWaeeeYZCJ96B54UvQNPiru//6i4+/uPit6hJ0Xv0JPinocOinseOih2PfIbseuR34hvDD8pvjH8pLi9b6+4vW+v6NvzqOjb86g4eHRKHDw6JR742S/FAz/7ZWa5IwefEyMHnxP//otx8e+/GBd3/uuPxZ3/+mPdb2fFxEAbBNAmBmLG7/SiEQhAmSJR49dCxAZEm/o92kRbJCIikYhoa8t+pvsNzfxtbRERibSJiGElYgNt5mnll9nf87I+ms8sl2m2PCGEEFERAQTaBoQuqXZbchZqJyYGIuo2qnnRpkya/Nb+np/tUtcbEWG5ZRGztH7T2ayni3jI3S7NvE5xY7Uci9/NxhgE2tpEJBIREWXetoGosn9Yb7+euj/JZWXLUl/GaIvk5pfK4/qrtPundQzalKfV7xp/02q+nPXL5oUsJ1lW6jpa7mIZ2rwcEDHHv5cCj4+macyWJ0SJHh+NceT0dzFT19Vk/1ZFI0o+GObJfK49Dsq8bxsYsDhu2BxPFOb1Q6HTWX2eZb68Qh//i4XDcSuzj1h8r8aCYT/X5pV6TJfLiYgB5Tt9Ev/l4icel2L99FzsX5r1yDlMuj1+mizfb5x6T2c83jn9vZKsz7cyk5rXnusFhW06mWap405XhtBsW+Yzk3rVar3V/DI7p7OMy6ziO88sPjB+4FapNQpkC9omeGJRMRDRB6ss0AERNVt+VLtTQkSMM1mdwAihOyBYrY6IxUTUuD5tbSIyEDU/mDnuHBYnvUIfxNY7i7mYab7JE2DTdfW6XXY7qcK8cvabTmG6XTbxYLVd0Zh+u5zixuPvxqIDmYpS+5tuTwKyNJVUziQPbANmK2Dkcf2F0O4rFmUhhHN5us1/l+sXi2oP4nJqa4uIaMxyBXXUylDdn5z+LjweH3XK9PhojCOnv4uXm+NVNi6M22N9HLQ6blh9nmVePxQ6ndXnWebLk6y3201+FiPn41Y0YrMfWzQKCKEc07X7YETu6+YXwktVLtbLLfT6GZkvR89yHrfHT4v1sc4P+zj1ms54vHP6e+XYnW8pkzavPdYLGVbpNOdFSxp3av2Xc3PJ5txBaNLp8sQkjWNcahTheWaxqRJCCOThru8/BgBIpd8CAPzkm3cCAG77pz1yhqtvAwD2P9gLAOj+hx8AAL54++cAAFcuXgQABNetBwBcEwwAAE6fOgcA+NrnPwIiIiIicmsUPVVbMYIIomIYXcavqfLEB9He/DWMR6IQw8USEX7j1G86IrKyyvgBEREREZWw+J9wAgDa3otm43dUmZp24psRACP/hsG48csV4jdO/aYjIkt59xTw6hN3/DMAYPPmDwEAmlqaAABX35Hfn5+bAwCcnn4VADA3+xoA4PEfyp4GRERERGQtPtiO5q+NA0V1V5hWnnKHvUjiwm+c+k1HRNbYU4CIiIiopIxisGcQoyZ3fOOjPfKCCW0YuIcXTKTVheFoBBjZip5R43dLwW+c+k1HRH4te08B1cduvxcA8NtHvwcAuOu7jwAAHvrGHQCAT/Z8GwDwq+FdmTREREREpD5TDaCtDZFbbgFwAidGxjEOAGhDJHoEvIlKK8tvnPpNR0R+sacAERERUUnpwj3RAUTa2tA2Po6RkRGMjIxjHG1oiwwgGuMFExUDv3HqNx0R+bViPQWIiIiIiIiIaGWxpwARERERERFRhWKjABEREREREVGFYqMAERERERERUYUqmTEFqvqmjB8RERERERERVRzRv8n4kW/sKUBERERERERUofLuKbD3l0cBAHd/6gO6z3f/15j8j9Ls0Pu5DgDADw48BwB480oSALDry7cqKeyxpwARERERERERewoQERERERERUQH47inwH7/+AwBgTZVsVxBVq+XfSjPDu6rfBQC4uroKAHAmPiO/F28DAC5fuQwA+Jc72VOAiIiIiIiIyC32FCAiIiIiIiKivPnuKaCKnngVABC+TvYMuG7dWgDA6lWy58A7a+Ti3/zznwEAJ1+eBQCcfeU1AEDf7R+FG+wpQERERERERMSeAkRERERERERUAK57Cvzwv48AADZcL3sE1G2sBQDU19cAANa9I+c7/sLzAIDEW2sAAG8rS29q+GsAQE3d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)

1. Scroll to Network Connection Broker.
    - Right-click it and select Restart.
    - If prompted with a Restart Other Services dialog, take a screenshot of the message. If an error appears instead, screenshot that.

1. Confirm Restart:
    - In the dialog box, click Yes to restart the service and any dependent services.
1. View Service Properties:
    - Double-click Network Connection Broker.
    - On the General tab, review the service name, description, path to executable, and startup type.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
1. Check Log On Settings:
    - Click the Log On tab.
    - Observe whether the service runs under a system account or a specific user account.
    - Take a screenshot.
1. Review Recovery Options:
    - Click the Recovery tab.
    - Note the actions configured for first, second, and subsequent failures (e.g., Restart the Service).
    - Take a screenshot.
1. View Dependencies:
    - Click the Dependencies tab.
    - Review both the services this one depends on and those that depend on it.
1. Close the Services Window:
    - Click Cancel to close the properties window.
    - Close the Services window.

## Activity 7 – Command Prompt in Windows 11

1. Start your computer and sign in, if necessary.
1. Open Command Prompt:
    - Click the Start button or press the Windows key.
    - Type `cmd` in the search bar.
    - You’ll see an option to Run as administrator on the right or below the result. This is required for some administrative tasks.
1. Launch Command Prompt:
    - Click Command Prompt in the search results (you can choose to run it normally or as administrator depending on your task).
1. View Network Configuration:
    - At the command prompt, type: `ipconfig` and press Enter.
    - This displays your network configuration. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
1. View Help for ipconfig:
    - Type: `ipconfig /?` and press Enter.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of the Help Output:
1. List Files in the Current Directory:
    - Type: `dir` and press Enter.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
    - This shows the contents of the current directory. Note that ipconfig is not listed because it resides in a system folder.
1. View the PATH Environment Variable:
    - Type: **echo %path%** and press Enter.
    - This displays the directories that Windows searches when you run a command.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
1. Try Running a Built-in Command as an Executable:
    - Type: `dir.exe` and press Enter.
    - This will fail, because dir is a built-in command, not a separate executable file.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
1. View Help for the dir Command:
    - Type: `dir /?` and press Enter.
    - This displays help information for the built-in dir command.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
1. Close the Command Prompt:
    - Type `exit` or click the **X** in the top-right corner of the window.

# Activity 8 – Powershell!

1. If necessary, start your computer and sign in.
2. Right-click the **Start** button and then click **Windows PowerShell (Admin)** on the shortcut menu.
3. In the User Account Control window, click **yes**.
4. At the Windows PowerShell prompt, type `Get-Service` and then press Enter. This displays all services with the default view showing Status, Name, and DisplayName.
5. Type `Get-Service | Sort-Object Status` and then press Enter. This command sends the list of services to the Sort-Object cmdlet which sorts the services based on the value of the Status property.
6. Type `Get-Service -Name w32time` and then press Enter. This gets information for just one service.
7. Type `Get-Service w32time | Format-List` and then press Enter. This displays the information for the service in a list format.
8. Type `Get-Service w32time | Format-List \*` and then press Enter. This displays ALL (\*) properties in a list format.
9. Type `Get-Service w32time | Format-Table Name,DisplayName,Status,StartType` and then press Enter. This displays specific properties in a table format. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
10. Type `Get-Process | Out-GridView` and then press Enter. This displays information in a sortable grid view similar to a spreadsheet. The information in grid view is a snapshot and does not update. You can sort the data by clicking the column names.
11. Close the `Get-Process | Out-GridView` window.
12. At the Windows PowerShell Prompt, type `Get-Command \*-Service` and then press Enter. This displays all the cmdlets you can use to manage services.
13. Type `get-help Restart-service` and then press Enter.
14. If prompted, type `y` and then press Enter to update the help content from the Internet. Wait for a few minutes while the help updates.
15. Read the help information that is displayed for `Restart-Service`. This is only the summary information. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
16. Type `get-help Restart-service -Full` and then press Enter.
17. Scroll up and down to read the full help for the `Restart-Service cmdlet`. This information now includes detailed information about the parameters and examples.
18. Type `Get-ExecutionPolicy` and then press Enter. By default, running Windows PowerShell scripts is not allowed.
19. Type `Set-ExecutionPolicy RemoteSigned` and then press Enter. This allows you to run any Windows PowerShell scripts that you create but not unsigned scripts from the Internet. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
20. If prompted, type `y` and then press Enter to confirm making the change.
21. Close the Windows PowerShell prompt window.

## Activity 9 – Optional Features in Windows 11

1. Start your computer and sign in.
2. Click the Start button and then click Settings.
3. In the Settings window, click System, then click Optional features.
4. Review the list of installed features. Click View features under “Add an optional feature”.
5. Scroll through the list of available features. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this list, then close the Settings window.
6. Click the Start button, type Control Panel, and open it.
7. In Control Panel, click Programs, then click Turn Windows features on or off. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this dialog.
8. Scroll through the list of Windows features. Click Cancel to exit.
9. Close Control Panel.
10. Right-click the Start button and click Windows PowerShell (Admin).
11. At the User Account Control prompt, click Yes.
12. In PowerShell, type the following command and press Enter:
    - `Get-WindowsOptionalFeature -Online`
    - Review the list and <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
13. Type the following command and press Enter:
    - `Get-WindowsOptionalFeature -Online | Where-Object State -eq Enabled`
    - This displays only the enabled features.
14. Type the following command and press Enter:
    - `Get-WindowsOptionalFeature -Online -FeatureName TelnetClient`
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
15. Then type:
    - `telnet.exe`
    - Press Enter. This should fail because Telnet is not yet enabled.
16. Type:
    - `Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient`
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
17. Type:
    - `telnet.exe`
    - Press Enter. Telnet should now start.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
18. Type:
    - Quit
    - Press Enter to exit Telnet.
19. Type:
    - `dism.exe /online /get-features`
20. Type:
    - `dism.exe /online /get-featureinfo:telnetclient`
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
21. Type:
    - `dism.exe /online /disable-feature:telnetclient`
    - Press Enter to remove Telnet.

## Activity 10 – Managing Hardware with Device Manager in Windows 11

1. Start your computer and sign in.
2. Right-click the Start button and click Device Manager.
3. If any devices show a yellow warning icon, <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
    - Expand Network adapters, then double-click your network card. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
4. In the General tab, review the device status.
5. Click the Advanced tab (if available). Review the settings.
6. Click the Driver tab. Review driver information.
7. Click Driver Details. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of the list of driver files.
8. Click OK, then go to the Details tab.
9. Use the Property dropdown to browse available properties. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of the list.
10. Click the Events tab to view device activity.
    - If available, click the Resources tab to view hardware resource usage. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
    - If available, click the Power Management tab to view power settings. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
11. Click Cancel to close the dialog.
12. Close Device Manager.

## Activity 11 – Task Scheduler in Windows 11

1. Start your computer and sign in.
2. Right-click the Start button and click Computer Management.
3. In the left pane, click Task Scheduler. The middle pane displays the Task Scheduler Summary, showing the status of currently running and previously run tasks. Future scheduled tasks are listed under Active Tasks.
4. In the Actions pane, click Enable All Tasks History. This enables logging for troubleshooting.
5. In the left pane, expand Task Scheduler, then expand Task Scheduler Library, Microsoft, Windows, and click Defrag.
6. In the middle pane, click the Triggers tab. Note that the ScheduledDefrag task does not have a schedule because it is triggered by automatic maintenance.
7. Click the Actions tab. This shows that the task runs the defrag.exe program.
8. Click the Conditions tab. This shows that the task runs only when the computer is on AC power. It stops if the computer switches to battery power.
9. Click the Settings tab. This shows that if the computer is off when the task is scheduled to run, it will start as soon as possible after the computer is turned on. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this tab.
10. Click the History tab. This displays event log entries for the task, including start and completion times, and any errors.
11. Close the Computer Management window.

## Activity 11 – Task Scheduler in Windows 11**

1. Start your computer and sign in.
2. Right-click the Start button and click **Computer Management**.
3. In the left pane, click **Task Scheduler**. The middle pane displays the Task Scheduler Summary, showing the status of currently running and previously run tasks. Future scheduled tasks are listed under Active Tasks.
4. In the Actions pane, click **Enable All Tasks History**. This enables logging for troubleshooting. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
5. In the left pane, expand **Task Scheduler**, then expand **Task Scheduler Library**, **Microsoft**, **Windows**, and click **Defrag**. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
6. In the middle pane, click the **Triggers** tab. Note that the ScheduledDefrag task does not have a schedule because it is triggered by automatic maintenance. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
7. Click the **Actions** tab. This shows that the task runs the defrag.exe program.
8. Click the **Conditions** tab. This shows that the task runs only when the computer is on AC power. It stops if the computer switches to battery power.
9. Click the **Settings** tab. This shows that if the computer is off when the task is scheduled to run, it will start as soon as possible after the computer is turned on. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark> of this tab.
10. Click the **History** tab. This displays event log entries for the task, including start and completion times, and any errors. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
11. Close the Computer Management window.

## Activity 12 – Scheduling with PowerShell in Windows 11

1. Start your computer and sign in.
2. Right-click the Start button and click Windows PowerShell.
3. At the PowerShell prompt, type:
    - `md C:\Scripts`
    - Press Enter to create a folder for scripts.
4. Type:
    - `md C:\AppTemp`
    - Press Enter to create a folder for temporary application files.
5. Type:
    - `"unneeded log file" | Set-Content C:\AppTemp\LogFile.txt`
    - Press Enter to create a sample log file.
6. Type:
    - `Get-ChildItem C:\AppTemp`
    - Press Enter to verify that LogFile.txt exists.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
7. Type:
    - `"Get-ChildItem C:\AppTemp | Remove-Item" | Set-Content C:\Scripts\CleanTemp.ps1`
    - Press Enter to create a script that deletes temporary files.
8. Type:
    - `Get-Content C:\Scripts\CleanTemp.ps1`
    - Press Enter to verify the script contents. If incorrect, repeat step 7.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
9. Right-click the Start button and click Computer Management.
10. In Computer Management, expand Task Scheduler, then click Task Scheduler Library.
11. In the Actions pane, click Create Basic Task.
12. In the wizard, enter the name: Clean Application Temp Files, then click Next.
13. On the Task Trigger screen, select Weekly, then click Next.
14. On the Weekly screen, set the start time to 11:00:00 PM.
15. Select Sunday, then click Next.
16. On the Action screen, select Start a program, then click Next.
17. In the Program/script box, type:
    - `powershell.exe`
18. In the Add arguments box, type:
    - `-File C:\Scripts\CleanTemp.ps1`
    - Then click Next.
    - Click Finish.
19. Review the security options. The task will run only when you are signed in. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
20. Double-click **Clean Application Temp Files**.
21. In the Properties dialog, click **Change User or Group**.
22. In the Select User or Group dialog, type System, click **Check Names**, then click **OK**.
23. Click OK to close the Properties dialog.
24. Right-click Clean Application Temp Files and click Run.
25. Click the History tab and verify that the task ran successfully. <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>.
26. At the PowerShell prompt, type:
    - `Get-ChildItem C:\AppTemp`
    - Press Enter. No output should appear, confirming the file was deleted.
    - <mark style="background-color: red; color: white; font-weight: bold">Take a Screenshot</mark>
27. Close all open windows.
