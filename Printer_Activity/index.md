### In-Class Activity: Network Printer Installation

**Scenario:**
A new printer has been set up in the hallway for student use. Your task is to connect your Windows 11 machine to this printer. This will involve verifying network connectivity, finding the correct driver, installing the printer manually, managing the print queue, and verifying your work using professional admin tools.

**Teacher-Provided Information:**
* **Printer IP Address:** `172.16.99.99` *(Replace with real IP)*
* **Printer Manufacturer & Model:** `HP LaserJet Pro M404dn` *(Replace with real model)*

---

### Part A: Network Verification

Before we can install a printer, we must confirm our computer can communicate with it over the network.

1.  Click the **Start** button, type `cmd`, and open the **Command Prompt** app.
2.  At the prompt, type `ping 172.16.99.99` (using the IP address provided by your teacher) and press **Enter**.
3.  If the ping is successful, you will see "Reply from..." lines. This confirms you are on the same network.
4.  **Grab a screenshot** of the successful ping replies.
    * *(If your ping fails, stop and notify your instructor. This is a common troubleshooting step.)*

---

### Part B: Driver Research and Download

Next, you need to find the correct "blueprint" (the driver) that tells Windows how to talk to this specific printer model.

1.  On the taskbar, click **Microsoft Edge**.
2.  Go to the support website for the printer's manufacturer (e.g., `support.hp.com`, `support.dell.com`).
3.  Find the "Software & Drivers" section.
4.  Search for the exact printer model provided by your teacher (e.g., `HP LaserJet Pro M404dn`).
5.  Find the **Windows 11 (64-bit)** drivers. Look for a **"Universal Print Driver (UPD)"** or a model-specific driver. **PCL6** or **PostScript (PS)** are both excellent choices.
6.  Download the driver.
7.  If the download is an `.exe` file, double-click it. It is likely a **Self-Extractor**.
8.  When the extractor opens, **do not** click "Install." Instead, choose the option to **"Unzip"** or **"Extract"** the files.
9.  Save the driver files to a new, easy-to-find folder on your C: drive (e.g., `C:\Drivers\HP`).

---

### Part C: Manual Printer Installation

Now we will manually add the printer using the IP address and the drivers you just downloaded.

1.  Click the **Start** button and then click **Settings**.
2.  In the Settings window, click **Bluetooth & devices** from the left menu, and then click **Printers & scanners**.
3.  Click the **Add device** button. After it searches for a moment, click **Add manually** (which appears when "The printer that I want isn't listed" is shown).
4.  In the "Add Printer" dialog box, select **Add a printer using a TCP/IP address or hostname** and then click **Next**.
5.  In the "Hostname or IP address" text box, type the printer's IP address: `172.16.99.99`.
6.  **Crucially:** **Deselect** the **"Query the printer and automatically select the driver to use"** check box. This forces Windows to ask *us* for the driver. Click **Next**.
7.  Windows will try to detect the port (this may take a moment).
8.  On the "Install the printer driver" screen, click the **"Have Disk..."** button.
9.  In the "Install From Disk" pop-up, click **"Browse..."**.
10. Navigate to the folder where you extracted your drivers (e.g., `C:\Drivers\HP`).
11. Select the main `.inf` file for the driver (it might be named `hpcuXXX.inf` or similar) and click **Open**, then **OK**.
12. From the list of printers, select the exact model (or the Universal PCL6 driver) and click **Next**.
13. In the "Printer name" box, give it a unique name: `[Your Name]'s Hallway Printer`. Click **Next**.
14. On the "Printer Sharing" screen, select **Do not share this printer** and then click **Next**.
15. **Grab a screenshot** of this "Printer Sharing" screen.
16. Click **Finish**.

---

### Part D: The Test Print

Let's create a test job.

1.  Click the **Start** button, type `Notepad`, and open the app.
2.  In the blank document, type the following two lines:
    * Your Student ID (e.g., `w0123456`)
    * `Hello World!`
3.  On the menu bar, click **File** $\rightarrow$ **Print...**.
4.  From the list of printers, select the new printer you just installed (e.g., `[Your Name]'s Hallway Printer`).
5.  Click **Print**.

---

### Part E: Print Queue Management

You've sent the job, but where did it go? This is the most common troubleshooting step for printing.

1.  Quickly, go back to **Settings** $\rightarrow$ **Bluetooth & devices** $\rightarrow$ **Printers & scanners**.
2.  Click on the printer you just installed (e.g., `[Your Name]'s Hallway Printer`).
3.  Click **"Open print queue"**.
4.  You should see your "Hello World" document listed with the status "Printing" or "Spooled."
5.  **Grab a screenshot** of your job in the print queue.
6.  **(Optional Challenge):** Right-click the job and see if you can **Pause**, **Restart**, or **Cancel** it before it disappears from the queue.
7.  Go to the hallway printer and retrieve your printed page to show your instructor.

---

### Part F: The Admin View (Print Management)

You've now seen the standard "user" way to manage printers via the Settings app. Now, let's look at the "IT Professional" tool for this.

1.  Click the **Start** button, type `print management`, and open the **Print Management** console.
2.  In the left pane, expand **Print Servers** $\rightarrow$ **[Your Computer Name] (local)**.
3.  Click on the **"Drivers"** folder. Do you see the HP driver you just installed in this list?
4.  Click on the **"Ports"** folder. Do you see the Standard TCP/IP Port with the IP address `172.16.99.99` that you created?
5.  Click on the **"Printers"** folder. You will see your `[Your Name]'s Hallway Printer` listed here as well.
6.  **Grab a screenshot** of the Print Management console showing either your new driver, your new port, or your new printer.