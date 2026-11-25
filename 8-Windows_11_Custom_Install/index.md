# OSYS1200 Lab 8: Booting, Installation, Sysprep & DISM

**Course:** OSYS1200  
**Environment:** Hyper-V on your local Room 312 lab workstation  
**Lecture Slides:** [Booting, Installation, Sysprep & DISM Slides](https://nscctruroit.github.io/OSYS1200/8-Windows_11_Custom_Install/Booting_Installation_Sysprep_DISM_Slides.html)

## Lab Objectives
In this lab, you will build a Windows 11 **Reference VM** in Hyper-V, inspect its UEFI boot chain and installation image with **DISM**, and generalize the installation with **Sysprep** so it is ready for enterprise deployment:
1. Obtain official Windows 11 installation media.
2. Configure a **Generation 2** Hyper-V VM with **Secure Boot** and **TPM 2.0**.
3. Perform a clean installation and enter **Audit Mode** (`Ctrl + Shift + F3`).
4. Inspect the Windows boot chain (`bcdedit`) and installation media / component store using **DISM**.
5. **Generalize** the installation using **Sysprep** (`OOBE + Generalize + Shutdown`) and leave the reference VM powered off.

> **Safety:** Perform all installation, DISM, and Sysprep steps **inside your new `Win11-Reference` VM only**. Never reinstall or run Sysprep on the physical lab workstation.

> **Submission:** Use the **Snipping Tool** (`Win + Shift + S`) to capture the **6 screenshots** marked below and answer the **3 short reflection questions** at the end in one Word document named `YourName_Lab8.docx`.

---

### Activity 1 – Installation Media & Hyper-V VM Prep

**Scenario:** Windows 11 requires UEFI firmware (Generation 2), Secure Boot, and a Trusted Platform Module (TPM 2.0). You will prepare a clean Hyper-V virtual machine before booting the installer.

1. **Obtain the Windows 11 ISO:**
   * Check with your instructor for a locally cached Windows 11 ISO on the lab machine, or download it from [Microsoft: Download Windows 11](https://www.microsoft.com/software-download/windows11) (**Windows 11 (multi-edition ISO)** → **English** → **64-bit Download**).
2. **Launch Hyper-V Manager:**
   * Click **Start**, type `Hyper-V Manager`, and open it.
   * In the **Actions** pane on the right, click **New > Virtual Machine**.
3. **Configure the VM:**
   * **Name:** `Win11-Reference`
   * **Generation:** **Generation 2** *(required for UEFI, Secure Boot, and TPM)*
   * **Memory:** `4096` MB (4 GB)
   * **Network:** **Default Switch**
   * **Virtual Hard Disk:** Create a new virtual hard disk (**64 GB or larger**)
   * **Installation Options:** **Install an image file (.iso)** → browse to your Windows 11 ISO → **Finish**
4. **Enable Secure Boot & TPM (Critical Step):**
   * *Do not start the VM yet.*
   * Right-click `Win11-Reference` → **Settings**.
   * Under **Processor**, set **Number of virtual processors** to `2`.
   * Under **Security**:
     * Check **Enable Secure Boot** (Template: *Microsoft Windows*).
     * Check **Enable Trusted Platform Module**.
   * **Screenshot 1:** Capture the **Security** settings window showing both **Secure Boot** and **Trusted Platform Module** checked.
   * Click **OK**.

---

### Activity 2 – Clean Install & Entering Audit Mode

1. Right-click `Win11-Reference` → **Connect**, then click **Start**.
2. **Immediately** click inside the VM window and press a key when prompted (`Press any key to boot from CD or DVD...`).
3. Select your language/keyboard → **Next** → **Install Windows** (or **Install now**).
4. **Product Key / Edition:** Click **I don't have a product key** (if prompted), then select **Windows 11 Pro** (or **Education**).
5. Accept the license terms, choose **Custom: Install Windows only (advanced)** if shown, select **Drive 0 Unallocated Space**, and click **Next**.
6. Wait for Windows to install and reboot. *(Do not press a key to boot from DVD after the reboot!)*
7. **STOP at the "Is this the right country or region?" screen.** Do not sign into a Microsoft account or create a user.
8. Press **`Ctrl + Shift + F3`** inside the VM window *(some keyboards require `Fn + Ctrl + Shift + F3`)*.
   * The VM will reboot into **Audit Mode** using the built-in Administrator account, and the **System Preparation Tool (Sysprep)** window will open automatically.
9. **Screenshot 2:** Capture the Audit Mode desktop with the **Sysprep** window visible. *(Do **not** click OK in Sysprep yet!)*

> **Note:** In a standalone lab where you want a normal local user instead of Audit Mode, you can press `Shift + F10` at the region screen and run `OOBE\BYPASSNRO` (with the virtual NIC disconnected if needed). For a **reference image**, **Audit Mode** is preferred because it avoids creating user profiles or triggering background Store updates.

---

### Activity 3 – Boot Chain Verification & DISM Servicing

Now that you are in Audit Mode with elevated Administrator privileges, inspect the UEFI boot chain and practice both **offline** and **online** `DISM` commands.

1. Right-click **Start** and open **Terminal (Admin)** or **Windows PowerShell (Admin)**.
2. **Verify the UEFI Boot Chain (`bcdedit`):**
   ```powershell
   bcdedit /enum
   ```
   Confirm the Windows Boot Manager points to `\EFI\Microsoft\Boot\bootmgfw.efi` and the Windows Boot Loader points to `\WINDOWS\system32\winload.efi`.
3. **Inspect the Windows 11 ISO Image with DISM (Offline Image):**
   Check which drive letter your attached ISO has (typically `D:` or `E:`), then inspect its `install.wim` or `install.esd`:
   ```powershell
   # Try install.wim first; if not found, use install.esd
   dism /Get-WimInfo /WimFile:D:\sources\install.wim
   ```
   *(If `D:\sources\install.wim` does not exist, run `Get-ChildItem D:\sources\install.*` to check whether the ISO uses `install.esd` and re-run `/Get-WimInfo` against that file.)*
4. **Screenshot 3:** Capture the `dism /Get-WimInfo` output showing the Windows 11 edition indexes inside the ISO.
5. **Check Component Store Health with DISM (Online Servicing):**
   ```powershell
   dism /Online /Cleanup-Image /CheckHealth
   dism /Online /Cleanup-Image /ScanHealth
   ```
6. **Screenshot 4:** Capture the `dism /Online /Cleanup-Image /ScanHealth` result (`No component store corruption detected`).

---

### Activity 4 – Generalizing with Sysprep

**Scenario:** Before a reference VM can be captured with `dism /Capture-Image` or cloned, **Sysprep** must remove machine-specific identifiers (including the computer **SID**) and reset the system to OOBE.

1. Return to the **System Preparation Tool (Sysprep)** window *(if you closed it, open `C:\Windows\System32\Sysprep\sysprep.exe`)*.
2. Configure the following settings:
   * **System Cleanup Action:** `Enter System Out-of-Box Experience (OOBE)`
   * **Generalize:** **Checked**
   * **Shutdown Options:** `Shutdown`
3. **Screenshot 5:** Capture the Sysprep window showing **OOBE**, **Generalize checked**, and **Shutdown** selected.
4. Click **OK** and wait for Sysprep to finish without interrupting it. The VM will power off automatically.
   * **If Sysprep fails:** Check `C:\Windows\System32\Sysprep\Panther\setuperr.log` and note the exact error for your instructor. Do not manually shut down and report it as successful.
5. **Screenshot 6:** Capture **Hyper-V Manager** showing `Win11-Reference` in the **Off** state.
6. **Leave `Win11-Reference` powered off.** Do not boot it again (booting starts the Specialize/OOBE passes and undoes the prepared state).

---

### Short Reflection Questions
Answer each in 2–3 sentences inside `YourName_Lab8.docx`:
1. **Why must a Windows reference installation be generalized with Sysprep before it is cloned or captured for deployment?**
2. **Why should you leave the `Win11-Reference` VM powered off after Sysprep finishes?**
3. **What is the difference between running `dism /Get-WimInfo` on an ISO image versus running `dism /Online /Cleanup-Image /ScanHealth`?**
