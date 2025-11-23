# 🎓 OSYS1200: Hyper-V Crash Course
**Topic:** Virtualization Fundamentals & VM Management

## 1. The Concept: "A Computer Inside a Computer"
Before we click anything, let's understand the layout.
* **The Host:** The physical PC you are sitting in front of.
* **The Guest:** The Virtual Machine (VM) we are about to build.
* **The Hypervisor:** The software (Hyper-V) that lets them run side-by-side.

> **Key Rule:** The Guest VM thinks it is real hardware. It has its own BIOS (UEFI), its own Hard Drive (a `.vhdx` file), and its own Network Cable (Virtual Switch).

---

## 2. Networking: "Plugging in the Cable"
A VM needs a network connection to talk to the internet. Hyper-V uses **Virtual Switches**.

**Follow Along:**
1.  Open **Hyper-V Manager**.
2.  On the right-hand "Actions" pane, click **Virtual Switch Manager**.
3.  Look at the list on the left. You should see **Default Switch**.

### The 3 Types of Switches:
* **Default Switch (NAT):**
    * *What it does:* The VM shares the Host's IP address. It’s like plugging the VM into a router inside your computer.
    * *When to use it:* **Always use this for our labs.** It automatically gives you internet access without complex setup.
* **External Switch (Bridge):**
    * *What it does:* Connects the VM directly to the college network.
    * *Why we avoid it:* The college network might block it because it sees an "Unknown Device."
* **Private Switch:**
    * *What it does:* Connects VMs to each other, but not to the internet or the Host. Good for malware testing or private clusters.

*Close the Virtual Switch Manager.*

---

## 3. Creating a VM: The Critical Decisions
We are going to walk through the "New Virtual Machine" wizard. There are **two specific settings** that will break your Windows 11 lab if you get them wrong.

**Follow Along:**
1.  Click **Action > New > Virtual Machine**.
2.  **Name:** Give it a test name (e.g., `Class-Test`). Click **Next**.
3.  **Generation (CRITICAL):**
    * **Generation 1:** Simulates old BIOS hardware (2008 era). **Does NOT support Windows 11.**
    * **Generation 2:** Simulates modern UEFI hardware. Supports Secure Boot and TPM.
    * **Action:** Select **Generation 2**. Click **Next**.
4.  **Memory:**
    * **Startup Memory:** How much RAM the VM grabs immediately (e.g., 4096 MB).
    * **Dynamic Memory:** **CHECK THIS BOX.** This allows the VM to release RAM back to the host when it isn't using it. If you don't check this, you might run out of RAM if you run multiple VMs.
5.  **Networking:** Select **Default Switch**. Click **Next**.
6.  **Hard Disk:** Note the location! It saves a `.vhdx` file to your drive. Click **Next**.
7.  **Installation Options:** This is where you would select your ISO file. For now, select **Install an OS later** and click **Finish**.

---

## 4. The "Settings" Menu (Under the Hood)
Creating the VM is only Step 1. Now we need to modify the hardware. This is like opening the computer case to add parts.

**Follow Along:**
1.  Right-click your new VM (`Class-Test`) and select **Settings**.

### A. Security (The Windows 11 Gatekeeper)
* Click the **Security** tab on the left.
* **Secure Boot:** Usually enabled by default.
* **Trusted Platform Module (TPM):** Windows 11 **REQUIRES** this.
* **Action:** Check **Enable Trusted Platform Module**. If you miss this, Windows 11 installation will fail immediately.

### B. Processor
* Click the **Processor** tab.
* By default, VMs usually get 1 Core. This makes them slow.
* **Action:** Change "Number of virtual processors" to **2**. This will make your installation much faster.

### C. DVD Drive (The ISO)
* Click the **SCSI Controller > DVD Drive**.
* This is where you "insert the disc."
* **Action:** Click **Image file** and browse to an ISO to mount it. (Don't do this now, just see where it is).

*Click **OK** to save changes.*

---

## 5. Checkpoints: Your "Save Game" Button
This is the most valuable tool for Lab 8 (Sysprep). Sysprep crashes easily. You do NOT want to reinstall Windows from scratch if it fails.

**The Workflow:**
1.  **Before** you do something risky (like running Sysprep), Right-click your VM -> **Checkpoint**.
2.  This creates a snapshot in time.
3.  If your lab fails? Right-click the Checkpoint -> **Apply**.
4.  Boom. You are back in time, ready to try again in seconds.

---

## 6. Pro Tip: Taking Your VM Home (Exporting)
If you want to move your VM to another computer (or a USB drive) to finish the lab at home, **DO NOT just copy the `.vhdx` file.**

* **The Problem:** Windows 11 relies on the specific TPM settings inside the VM *configuration*. If you only copy the hard drive file, you leave the security chip settings behind. Your VM will not boot on the new computer.
* **The Solution:** Use the **Export** feature.

**How to do it:**
1.  Right-click your VM (it must be **Off**).
2.  Select **Export**.
3.  Browse to your USB drive or external folder.
4.  Hyper-V will package the Hard Drive AND the Configuration files together safely.
5.  **To Open it at Home:** Open Hyper-V -> **Action** -> **Import Virtual Machine** and select that folder.

---

## 7. Common "Gotchas" & Troubleshooting

### 🛑 "My mouse is trapped!"
* Sometimes (especially in Linux or Gen 1 VMs) your mouse gets stuck inside the VM window and you can't click back to your desktop.
* **The Magic Keys:** Press **Ctrl + Alt + Left Arrow** to release your mouse.

### 🛑 "The screen is tiny / Connect Box keeps popping up"
* Hyper-V tries to be helpful by using "Enhanced Session Mode" (gives you copy/paste and high resolution). Sometimes it just causes a black screen or login loop.
* **The Fix:** In the VM window toolbar, click **View** and uncheck **Enhanced Session**.

### 🛑 "Windows keeps installing over and over!"
* You installed Windows, it rebooted, and now you are back at the "Install Windows" screen.
* **The Cause:** You didn't "eject" the ISO, and you hit a key when it said "Press any key to boot from CD..."
* **The Fix:**
    1.  Turn off the VM.
    2.  Go to **Settings > DVD Drive**.
    3.  Select **None** (Eject the ISO).
    4.  Turn it back on.

### 🛑 "I deleted the VM but my hard drive is still full!"
* Deleting a VM from the Hyper-V list **does not** delete the virtual hard drive file (`.vhdx`).
* **The Fix:** You must manually go to the folder where you created the VM and delete the `.vhdx` file to reclaim your space.