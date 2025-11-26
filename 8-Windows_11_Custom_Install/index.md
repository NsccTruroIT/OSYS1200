# OSYS1200 Lab 8: Deployment & Generalization
**Course:** OSYS1200
**Status:** Lab 8

## 🎯 Lab Objectives
In this lab, you will simulate the role of a System Administrator creating a "Reference Image" for deployment. You are required to:
1.  Obtain official Windows 11 installation media.
2.  Configure a Hyper-V VM with **TPM and Secure Boot** (Critical for Windows 11).
3.  Perform a clean installation.
4.  Bypass the Microsoft Account requirement using the OOBE Bypass method.
5.  **Generalize** the installation using **Sysprep** so it is ready for cloning.

> 💡 **Submission:** Use the **Snipping Tool** (`Win + Shift + S`) to capture proof of your work. Paste these into a Word document labeled `YourName_Lab8.docx`.

---

### Activity 1 – Obtaining Media and VM Prep

**Scenario:** You need to prepare a virtual machine to build your reference disk image. Unlike Windows 10, Windows 11 requires specific security hardware (TPM) to be present, even in a virtual environment.

1.  **Download the ISO:**
    * Remember, as an alternative to the official MS Download method, you may choose to use the Azure Education Hub.
    * Open a browser and visit the [Download Windows 11](https://www.microsoft.com/software-download/windows11) page.
    * Scroll to **Download Windows 11 Disk Image (ISO)**.
    * Select **Windows 11 (multi-edition ISO)** -> **Download Now**.
    * Select **English** -> **Confirm** -> **64-bit Download**.
    * Save this file to your `Downloads` folder.

2.  **Launch Hyper-V:**
    * Click Start, type `Hyper-V`, and press **Enter**.
    * In the Actions pane, click **New > Virtual Machine**.

3.  **Configure the VM:**
    * **Name:** `Win11-Reference`. Click **Next**.
    * **Generation:** Select **Generation 2** (Required for UEFI/TPM). Click **Next**.
        > **📝 Note:** Generation 1 emulates older BIOS hardware. Windows 11 requires modern UEFI firmware, which is only available in Generation 2.
    * **Memory:** `4096` MB (4GB). Check **Use Dynamic Memory**. Click **Next**.
        > **📝 Note:** "Dynamic Memory" allows the VM to release unused RAM back to your physical computer. If you don't check this, the VM locks the full 4GB, which might slow down your PC.
    * **Network:** Select **Default Switch**. Click **Next**.
    * **Hard Disk:** Accept defaults (Create a virtual hard disk). Click **Next**.
    * **Installation Options:** Select **Install an OS from a bootable image file**. Browse to the Windows 11 ISO you just downloaded. Click **Next** -> **Finish**.

4.  **The Critical Security Step (TPM):**
    * *Do not start the VM yet.*
    * Right-click your new `Win11-Reference` VM and select **Settings**.
    * Click **Security** on the left.
    * **Check** `Enable Secure Boot`.
    * **Check** `Enable Trusted Platform Module`.
    * **Screenshot this Security Settings window showing both boxes checked!**
    * Click **OK**.
        > **📝 Why is this required?** The Trusted Platform Module (TPM) is a specialized chip used for encryption (like BitLocker) and security verification. The Windows 11 installer checks for this hardware immediately. If you skip this step, the installation will fail with the error: *"This PC can't run Windows 11."*

---

### Activity 2 – The Clean Install

1.  Right-click your VM, click **Connect**, then click **Start**.
2.  **Immediately** press a key when prompted to boot from DVD.
3.  Select your Language and click **Next** -> **Install Now**.
4.  **Activate Windows:** Click **I don't have a product key**.
5.  **OS Selection:** Select **Windows 11 Pro** (Education is also fine, but Pro is standard). Click **Next**.
6.  Accept the License Terms and click **Next**.
7.  **Installation Type:** Click **Custom: Install Windows Only (Advanced)**.
8.  Verify **Drive 0 Unallocated Space** is selected and click **Next**.
9.  Wait for the files to copy. The VM will reboot several times.

---

### Activity 3 – The OOBE Bypass (Local Account)

**Scenario:** Windows 11 setup (OOBE) tries to force you to sign in with a Microsoft Account. For a "Reference Image," we want a local administrator account. We will use a command-line trick to bypass the network requirement.

1.  **The Region Screen:** When the installation finishes, you will see the "Is this the right country or region?" screen. **STOP.**
2.  Press **Shift + F10** on your keyboard. A black Command Prompt window will open.
    > If this doesn't work, check to see if you have a fn key (Laptop User?) try fn+Shift+f10
3.  Type the following command and press **Enter**:
    `OOBE\BYPASSNRO`
    > **📝 What does this do?** `BYPASSNRO` stands for "Bypass Network Requirement Option." This command modifies the Windows Registry to re-enable the hidden "I don't have internet" button, allowing IT professionals to set up machines without forcing a Microsoft account link.
4.  **Screenshot the command prompt with this command typed in!**
5.  The system will reboot immediately.
6.  When it returns to the Region screen, select your Region (Canada/US) and click **Yes**.
7.  Select your Keyboard layout and click **Yes** -> **Skip**.
8. Choose a name for your new install and click next. (hold on for the reboot)
8. You may be asked how you'd like to set Windows up... choose Personal and click next.
8.  **The Network Screen:** You will now see a button that says **I don't have internet**. Click it.
    > * **Can't find it?** 
    > * Even with BYPASSNRO run, if Windows 11 detects a live internet connection, it often forces the update check and hides or ignores the "I don't have internet" flow, forcing you back into the Microsoft Account login loop.
    > * **The Fix**: Just disconnect the Network Adapter in Hyper-V settings and reboot
9.  Click **Continue with limited setup**.
10. **Who's going to use this device?** Type `LabAdmin`. Click **Next**.
11. **Password:** Leave it blank (for this lab) and click **Next**.
12. **Privacy:** Uncheck all toggles and click **Accept**.
13. Wait for the desktop to load.

---

### Activity 4 – Generalizing with Sysprep

**Scenario:** You have installed Windows, but it has a specific Computer Name (SID) and hardware drivers attached to it. Before we can deploy this image to 100 other computers, we must **"Generalize"** it. This strips out the unique identifiers and resets the OOBE so the next user feels like they are unboxing a new PC.

1.  On your VM desktop, open **File Explorer**.
2.  Navigate to `C:\Windows\System32\sysprep`.
3.  Double-click `sysprep.exe`.
4.  **Configure Sysprep:**
    * **System Cleanup Action:** Select `Enter System Out-of-Box Experience (OOBE)`.
    * **Generalize:** **CHECK THIS BOX.** (Critical).
        > **📝 Why Generalize?** Every Windows installation has a unique "Security ID" (SID). If you simply copied this VM without checking "Generalize," all the new computers would have the *same* SID. This causes massive conflicts on a network domain. Generalizing removes the SID so the new computer can generate its own unique one.
    * **Shutdown Options:** Select `Reboot` (so we can verify it worked).
    * **Screenshot the Sysprep window with these settings selected!**
5.  Click **OK**.
    * *Note:* Sysprep will work for a moment, "Processing generalise phase," and then the VM will reboot.

> **🔥 Troubleshooting:** If Sysprep fails with an error, it is usually because Windows auto-updated an "Appx" package in the background.
> * **Fix:** If it fails, reboot the VM, wait 5 minutes, and try running Sysprep again.

6.  **Verification:**
    * Watch the VM reboot.
    * It should load back into the **"Is this the right country or region?"** screen.
    * This proves that the system was successfully "Generalised" and reset to factory OOBE status.
    * **Final Screenshot: Take a screenshot of the Region screen appearing for the second time.**

7.  You can now shut down the VM. You have successfully created a deployment-ready Windows 11 image!