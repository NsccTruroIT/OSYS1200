# OSYS1200 Lab 8: The Final Challenge – Deployment
**Course:** OSYS1200
**Status:** Final Lab

## 🎯 Lab Objectives
In this final lab, you will simulate the role of a System Administrator creating a custom deployment image. You are required to:
1.  Obtain the official Windows 11 installation media directly from Microsoft.
2.  **Customize the installation media** by injecting a configuration file to force a specific Windows edition.
3.  Configure a Hyper-V Virtual Machine (VM) that meets strict Windows 11 hardware requirements (TPM/Secure Boot).
4.  Perform a clean installation using your custom ISO.
5.  Bypass standard OOBE (Out of Box Experience) restrictions to create a local account.

> 💡 **Submission:** As with previous labs, use the **Snipping Tool** (`Win + Shift + S`) to capture proof of your work. Paste these into a Word document labeled `YourName_Lab9_Final.docx`.

---

### Activity 1 – Obtaining the Installation Media

**Scenario:** You need to deploy a fresh image of Windows 11. As a System Administrator, it is critical that you use the official, unmodified source media from the vendor to ensure security and stability.

1.  Open **Google Chrome** or **Microsoft Edge**.
2.  Navigate to the [Download Windows 11](https://www.microsoft.com/software-download/windows11) page.
3.  Scroll down to the section titled **Download Windows 11 Disk Image (ISO) for x64 devices**.
4.  Click the dropdown menu and select **Windows 11 (multi-edition ISO for x64 devices)**.
5.  Click the **Download Now** button.
6.  A new section will appear asking for product language. Select **English** (or English International) and click **Confirm**.
7.  A **64-bit Download** button will appear. Click it to begin the download.
8.  **Screenshot the browser window showing the download has started!**
9.  Save the ISO file to your `Downloads` folder (or the `C:\Storage` folder if you created one in Lab 8). The file is approximately 5-6 GB.

---

### Activity 2 – Customizing the ISO (The "ei.cfg" Trick)

**Scenario:** To ensure standardization across the company, you want to prevent technicians from accidentally installing "Windows 11 Home." You will inject a configuration file (`ei.cfg`) into the ISO that forces the installer to select **Windows 11 Pro** automatically.

**Tools Required:** We will use **AnyBurn** (Free) to modify the ISO file structure.

#### Part A - Creating the Config File
1.  Open **Notepad**.
2.  Type the following lines **exactly**:
    ```ini
    [EditionID]
    Pro
    [Channel]
    Retail
    [VL]
    0
    ```
3.  Click **File > Save As**.
4.  Change the "Save as type" dropdown to **All Files**.
5.  Name the file: `ei.cfg`
6.  Save it to your **Desktop**. **Screenshot your Notepad window showing the code before you close it!**

#### Part B - Injecting the File
1.  Download and install the free version of **AnyBurn** (or run the portable version).
2.  Open AnyBurn and select **Edit Image File**.
3.  Click the folder icon to browse and select the **Windows 11 ISO** you downloaded in Activity 1.
4.  Click **Next**. You will see the file structure of the ISO.
5.  In the file list, double-click the **`sources`** folder to enter it.
6.  Click the **Add** button (green plus sign), browse to your Desktop, and select your `ei.cfg` file.
7.  Verify that `ei.cfg` now appears inside the `sources` folder list. **Screenshot the AnyBurn window showing the 'ei.cfg' file inside the sources folder!**
8.  Click **Next**.
9.  **Save as:** Click "Browse" and name the new file `Win11_Pro_Only.iso`. Save it in the same folder as your original ISO.
10. Click **Create Now**. Wait for the process to complete.
11. You now have a custom deployment image.

---

### Activity 3 – Configuring the Hardware (Hyper-V)

Windows 11 has strict hardware requirements (TPM 2.0 and Secure Boot). Standard Virtual Machines will fail the installation unless configured correctly.

1.  Click **Start**, type `Hyper-V Manager`, and press **Enter**.
2.  In the Actions pane on the right, click **New** > **Virtual Machine**.
3.  **Name:** Type `Win11-Final-Lab`. Click **Next**.
4.  **Specify Generation:** **STOP.** You *must* select **Generation 2**.
    * *Why?* Only Generation 2 supports UEFI and TPM, which are required for Windows 11.
    * Select **Generation 2** and click **Next**.
5.  **Assign Memory:** Type `4096` (4GB) or `8192` (8GB) depending on your host RAM. Check **Use Dynamic Memory**. Click **Next**.
6.  **Configure Networking:** Select **Default Switch**. Click **Next**.
7.  **Connect Virtual Hard Disk:** Accept the defaults (Create a virtual hard disk). Click **Next**.
8.  **Installation Options:**
    * Select **Install an operating system from a bootable image file**.
    * Click **Browse** and select your **CUSTOM ISO** (`Win11_Pro_Only.iso`). **Do not select the original download.**
    * Click **Next**, then click **Finish**.
9.  **Security Configuration (CRITICAL STEP):**
    * Do *not* start the VM yet.
    * Right-click your new `Win11-Final-Lab` VM and select **Settings**.
    * Click on the **Security** tab on the left.
    * Ensure **Enable Secure Boot** is checked.
    * Check the box for **Enable Trusted Platform Module (TPM)**.
    * **Screenshot this Security Settings window showing both boxes checked!**
10. Click **OK**.

---

### Activity 4 – The Installation

1.  Right-click your VM and select **Connect**, then click **Start**.
2.  **Immediately** press any key when you see "Press any key to boot from CD or DVD..."
3.  At the Windows Setup screen, select your language and click **Next** > **Install Now**.
4.  **Verify your ISO Customization:**
    * Normally, Windows would ask you to select an Edition (Home, Education, Pro).
    * Because of your `ei.cfg` file, **this screen should be skipped entirely.**
    * If you go straight to the "Activate Windows" or "License Terms" screen, your customization worked!
5.  **Activate Windows:** Click **I don't have a product key**.
6.  **License Terms:** Check the box to accept and click **Next**.
7.  **Installation Type:** Select **Custom: Install Windows only (advanced)**.
8.  Select **Drive 0 Unallocated Space** and