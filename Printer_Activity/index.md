### In-Class Activity: Network Printer Installation

**Scenario:**
A new printer has been set up in the hallway for student use. Your task is to connect your Windows 11 machine to this printer. This will involve verifying network connectivity, gathering information from its web page, pre-staging the driver, installing the printer manually, and verifying your work.

**Teacher-Provided Information:**
* **Printer IP Address:** `172.16.144.2`
* **Printer Manufacturer & Model:** `Kyocera ECOSYS P3150dn`

---

### Part A: Network Verification

Before we can install a printer, we must confirm our computer can communicate with it over the network.

1.  Click the **Start** button, type `cmd`, and open the **Command Prompt** app.
2.  At the prompt, type `ping 172.16.144.2` (using the IP address provided by your teacher) and press **Enter**.
3.  If the ping is successful, you will see "Reply from..." lines. This confirms you are on the same network.
4.  **Grab a screenshot** of the successful ping replies.
    * *(If your ping fails, stop and notify your instructor. This is a common troubleshooting step.)*

---

### Part B: Accessing the Printer's Web UI

Since you can `ping` the printer, it's "on the network." This means it's likely hosting a configuration webpage. This is the best place to find real-time information.

1.  Open **your favorite web browser**.
2.  In the address bar, type the printer's IP address (e.g., `http://172.16.144.2`) and press **Enter**.
3.  You may see a "Not secure" warning. This is normal for an internal device. Click **"Advanced"** and then **"Proceed..."**.
4.  This will open the printer's built-in control panel (for this printer, it's the **Kyocera Command Center RX**).
5.  On this page, look at the valuable information it gives you, such as device status, paper levels, and toner.
6.  Find the **Toner** level (e.g., "Black: 69%").
7.  **Grab a screenshot** of this web UI, showing the device status or toner/paper levels.

---

### Part C: Driver Research and Pre-Staging

Now that you've confirmed the exact model from the web UI, you need to "pre-stage" (install) the driver onto the Windows driver store.

1.  Go to the manufacturer's support website (for this lab, search for `Kyocera ECOSYS P3150dn driver`).
2.  Find the **Windows 11 (64-bit)** or **Windows 10 (64-bit)** drivers. (A recent 64-bit Windows 10 driver will almost always work on Windows 11).
3.  Download the driver package (it will likely be a `.zip` or `.exe` file).
4.  If the file is a `.zip`, right-click and **Extract All...**. If it's an `.exe`, it is likely a Self-Extractor, so double-click it to extract the files.
5.  Once the files are extracted, browse the folder and run the **`Setup.exe`** or **`KmInst64.exe`** application.
6.  The "Express Install" will likely fail to find the printer. If it does, choose a **"Custom Install"** option. Your goal is to install the *driver* onto the system, not to find the printer (we will do that manually in the next step).
7.  Complete the installation wizard to get the driver files onto your computer.

---

### Part D: Manual Printer Installation

This is the most important part! Now that the driver is pre-staged, we will manually build the connection to the printer using its IP address.

> **Teacher's Note:** Why are we doing this manually? The "Express Install" wizard often fails to "discover" the printer, even though you can ping it. This is because `ping` uses a direct path (ICMP), but wizards use broadcast/multicast protocols (like WSD or SNMP) which are often blocked by firewalls. The manual TCP/IP method bypasses this problem.

1.  Click the **Start** button and then click **Settings**.
2.  In the Settings window, click **Bluetooth & devices** from the left menu, and then click **Printers & scanners**.
3.  Click the **Add device** button. After it searches for a moment, click **Add manually** (which appears when "The printer that I want isn't listed" is shown).
4.  In the "Add Printer" dialog box, select **Add a printer using a TCP/IP address or hostname** and then click **Next**.
5.  On the "Type a printer hostname or IP address" screen:
    * **Device type:** Select `TCP/IP Device`.
    * **Hostname or IP address:** Type `172.16.144.2`.
    * **Port name:** This box will auto-fill. Just click inside it, and it will copy the IP address (`172.16.144.2`). This is correct.
    * **Crucially:** **Deselect** the **"Query the printer and automatically select the driver to use"** check box. This forces Windows to ask *us* for the driver.
6.  Click **Next**. Windows will try to detect the port (this may take a moment).
7.  You are now at the "Install the printer driver" screen.
8.  From the **Manufacturer** list on the left, click **"Kyocera"**.
9.  From the **Printers** list on the right, select **"Kyocera ECOSYS P3150dn KX"** and click **Next**.
10. In the "Printer name" box, give it a unique name: `[Your Name]'s Kyocera Printer`. Click **Next**.
11. On the "Printer Sharing" screen, select **Do not share this printer** and then click **Next**.
12. **Grab a screenshot** of this "Printer Sharing" screen.
13. Click **Finish**. The printer is now installed!

---

### Part E: The Test Print

Let's create a test job.

1.  Click the **Start** button, type `Notepad`, and open the app.
2.  In the blank document, type the following two lines:
    * Your Student ID (e.g., `w0123456`)
    * `Hello World!`
3.  On the menu bar, click **File** $\rightarrow$ **Print...**.
4.  From the list of printers, select the new printer you just installed (e.g., `[Your Name]'s Kyocera Printer`).
5.  Click **Print**.

    * **Note:** This job will print *very* fast. By the time you open the print queue, it will likely already be gone. This is normal! In the next step, we will learn how to "catch" a job.

6.  Go to the hallway printer and retrieve your printed page to show your instructor.

---

### Part F: Print Management & Queue Control

You've seen the "user" way to print. Now, let's use the "IT Professional" tool to manage the printer and "catch" a print job.

1.  Click the **Start** button, type `print management`, and open the **Print Management** console.
2.  In the left pane, expand **Print Servers** $\rightarrow$ **[Your Computer Name] (local)** $\rightarrow$ **Printers**.
3.  In the center pane, find your newly installed printer (e.g., `[Your Name]'s Kyocera Printer`).
4.  **Right-click** your printer and select **"Pause Printing"**. You will see the status in the console change to "Paused".
5.  Now, go back to **Notepad**. Type a new line so your document now says:
    * `Hello World!`
    * `Hello World 2!`
6.  Click **File** $\rightarrow$ **Print...** and send this second job to the *same* (now paused) printer.
7.  Go back to the **Print Management** console. **Double-click** your printer (or right-click and select **"Open Print Queue"**).
8.  You will now see your "Hello World 2!" test page sitting in the queue with the status **"Paused"**.
9.  **Grab a screenshot** of this print queue window showing your paused job.
10. **Right-click** the "Hello World 2!" test job and select **"Cancel"**.
11. Click **Yes** to confirm. The job will disappear. This is how you manually clear a stuck job.
12. Close the print queue window. Back in the main **Print Management** console, **right-click** your printer and select **"Resume Printing"** to un-pause it.
13. While you are still in Print Management, click the **"Drivers"** folder in the left pane. Do you see your Kyocera driver?
14. Click the **"Ports"** folder. Do you see the Standard TCP/IP Port with the IP `172.16.144.2`?
15. **Grab one final screenshot** showing either the `Drivers` or `Ports` list.
16. Close all windows. You have successfully completed the lab!