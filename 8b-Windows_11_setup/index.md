# OSYS1200: Installing Windows 11 and Preparing a Reference VM

**Class Follow-Along**

Today we will create a virtual machine, install Windows 11, and prepare the installation using Sysprep.

**Follow your instructor and stop at each pause point.**

## Our Scenario

A web studio needs a consistent Windows starting point for new developers. We will prepare a reference installation that could later be captured and deployed.

**Today’s finish line:** A generalized Windows installation inside a powered-off VM. Capturing an image and deploying copies are not part of this walkthrough.

## Know Where You Are Working

| Location | What happens there? |
|---|---|
| **College PC — Host** | Open Hyper-V Manager, configure the VM, and check its power state |
| **New VM — Guest** | Install Windows 11, enter Audit Mode, and run Sysprep |

> **Safety:** Use a new VM named `WebStudio-Reference`. Never reinstall or run Sysprep on the physical college PC or an existing course VM.

---

## Part 1 — Get Ready

**Where: College PC**

1. Open **Start**.
2. Search for **Hyper-V Manager** and open it.
3. Locate the Windows 11 ISO supplied or approved by your instructor.

An **ISO** is a disc-image file. Attaching it to the VM is like inserting an installation DVD.

If you need installation media, follow your instructor’s directions or use the official [Windows 11 download page](https://www.microsoft.com/software-download/windows11).

> If Hyper-V is missing, tell your instructor. Enabling it requires permission, supported hardware and Windows edition, and usually a restart. Do not change the college PC’s firmware settings yourself.

### Pause and Check

- Hyper-V Manager opens.
- You know where the approved ISO is saved.
- Your instructor has confirmed enough memory and disk space are available.

---

## Part 2 — Create the Virtual Machine

**Where: Hyper-V Manager on the college PC**

1. Select the local host computer in Hyper-V Manager.
2. In the **Actions** pane, select **New > Virtual Machine**.
3. Use these settings:

| Setting | Choose |
|---|---|
| Name | `WebStudio-Reference` |
| Storage location | The folder approved by your instructor |
| Generation | **Generation 2** |
| Startup memory | **4096 MB** |
| Dynamic Memory | Leave unchecked for this demonstration |
| Network connection | **Default Switch**, or the switch specified by your instructor |
| Virtual hard disk | Create a **new** disk with a capacity of **64 GB or larger** |
| Installation options | Install from a bootable image file and select the Windows 11 ISO |

4. Review the summary.
5. Select **Finish**.
6. **Do not start the VM yet.**

### What Do These Settings Mean?

- **Generation 2:** Provides modern UEFI firmware.
- **4096 MB:** Gives the VM 4 GB of RAM. The college PC also needs memory for its own work.
- **Virtual hard disk:** A file that acts as the guest’s storage drive.
- **Virtual switch:** Connects the VM to a virtual network.

Dynamic Memory can adjust guest memory allocation. We are leaving it off today to keep the setup straightforward.

> Do not create an External Switch or change the college PC’s network configuration unless instructed.

---

## Part 3 — Check the Virtual Hardware

**Where: VM settings in Hyper-V Manager**

1. Right-click `WebStudio-Reference`.
2. Select **Settings**.
3. Select **Processor**.
4. Set **Number of virtual processors** to **2**.
5. Select **Security**.
6. Confirm:
   - **Enable Secure Boot** is checked.
   - The Secure Boot template is **Microsoft Windows**, where shown.
   - **Enable Trusted Platform Module** is checked.
7. Under the **SCSI Controller**, select **DVD Drive** and confirm the correct ISO is attached.
8. Select **OK**.

### Why Enable These Security Features?

- **Secure Boot** helps verify trusted startup components.
- A **virtual TPM** provides security functionality required for this Windows 11 VM.

### Pause and Check

Before starting, confirm:

- [ ] Generation 2.
- [ ] Two virtual processors.
- [ ] At least 4 GB RAM.
- [ ] Virtual disk capacity of at least 64 GB.
- [ ] Secure Boot enabled.
- [ ] TPM enabled.
- [ ] Correct ISO attached.

**Lab 8B screenshot:** Capture the Security window showing Secure Boot and TPM enabled.

---

## Part 4 — Install Windows 11

**Where: Inside the new VM’s connection window**

1. Right-click `WebStudio-Reference` and select **Connect**.
2. Select **Start**.
3. Click inside the VM window.
4. Press a key when prompted to boot from the DVD.
5. Choose the appropriate language and keyboard settings.
6. Start the Windows installation.
7. Follow your instructor’s product-key and edition instructions:
   - Use the approved Windows edition and licensing arrangements.
   - Choose **I don’t have a product key** only if instructed and available.
8. Accept the applicable licence terms.
9. Choose a clean installation. Some installers label this **Custom: Install Windows only**.
10. Select the **unallocated space on the new VM’s virtual disk**.
11. Continue and allow Windows to install.

> **Stop if the disk layout is unexpected.** Do not delete partitions or choose a different disk to make the installation proceed. Ask your instructor.

Windows will copy files and restart.

**After the first restart, do not press a key to boot from the DVD again.**

Installer screens vary between Windows 11 versions. Follow your instructor’s demonstration if the wording differs.

### Pause at the Country or Region Screen

When Windows asks for your country or region, **stop**.

Do not continue into normal account setup or sign into a personal Microsoft account.

> **While installation runs:** Your instructor may switch to a separate, preinstalled demonstration VM. Watch the remaining steps and complete them on your own VM when instructed. Do not interrupt installation to catch up.

---

## Part 5 — Enter Audit Mode

**Where: Inside the VM, at the country or region screen**

1. Make sure the VM connection window has keyboard focus.
2. Press **Ctrl + Shift + F3**.
   - Some keyboards also require **Fn**.
3. Let Windows restart.
4. Wait for the desktop to appear.
5. Look for the **System Preparation Tool — Sysprep** window.

You are now in **Audit Mode**, using the built-in Administrator account.

### What Is Audit Mode?

Audit Mode is a preparation environment. It lets administrators configure Windows before its normal first-user setup is completed.

For example, an administrator could prepare approved applications before delivering a computer to its user.

We are not installing extra applications today. We are learning the preparation workflow.

- Do not create a separate `LabAdmin` account.
- Do not sign into personal services.
- Do not install or update Microsoft Store apps.
- Do not make unrelated changes.

### Pause and Check

- [ ] The Windows desktop is visible inside `WebStudio-Reference`.
- [ ] The Sysprep window is open.

**Lab 8B screenshot:** Capture the Audit Mode desktop with Sysprep visible.

---

## Part 6 — Understand Sysprep

**Do not click OK yet.**

**Sysprep** means **System Preparation Tool**.

Before reusing a Windows installation for other computers, administrators generalize it to remove machine-specific information.

We will use three settings:

| Setting | What it does |
|---|---|
| **Enter System Out-of-Box Experience — OOBE** | Sets Windows to run first-use setup on the next boot |
| **Generalize** | Removes machine-specific information, including the computer SID |
| **Shutdown** | Powers off the prepared installation when processing finishes |

A **SID** is a security identifier. It is not the computer’s name.

**Generalizing is not a factory reset. Sysprep also does not capture an image by itself.**

### Quick Class Check

Discuss together:

1. Which setting removes machine-specific information?
2. Which setting prepares Windows for first-use setup?
3. Which setting leaves the prepared installation powered off?

---

## Part 7 — Generalize and Shut Down

**Where: Sysprep inside `WebStudio-Reference` only**

### 1. Confirm the Target

Check that the VM connection window is for **WebStudio-Reference**.

**Do not open or run Sysprep on the physical college PC.**

### 2. Select the Settings

In the Sysprep window, choose:

- **System Cleanup Action:** Enter System Out-of-Box Experience (OOBE).
- **Generalize:** Checked.
- **Shutdown Options:** Shutdown.

### Pause Before Clicking OK

Wait while your instructor checks the settings.

**Lab 8B screenshot:** Capture the window showing **OOBE + Generalize + Shutdown**.

### 3. Run Sysprep

1. When instructed, click **OK**.
2. Wait without interrupting processing.
3. If Sysprep completes without reporting an error, the VM should shut down.
4. Return to **Hyper-V Manager**.
5. Confirm `WebStudio-Reference` shows a state of **Off**.
6. **Leave the reference VM off. Do not start it again.**

**Lab 8B screenshot:** Capture Hyper-V Manager showing the VM Off after Sysprep completes without an error.

> If you closed the Sysprep window earlier, tell your instructor. It can be reopened using File Explorer **inside the VM** at:
>
> `C:\Windows\System32\Sysprep\sysprep.exe`

### Why Leave It Off?

Booting the prepared installation starts the next setup stages and changes its prepared state.

A later boot test should use a separate test copy so the reference remains preserved.

> **Important:** The Off state alone does not prove that generalization succeeded. Manually shutting down after an error does not count as successful completion.

---

## If Something Does Not Match

| Problem | What to do |
|---|---|
| Hyper-V is missing | Tell your instructor before proceeding |
| Windows reports unsupported hardware | Stop and ask your instructor to check the VM settings |
| Windows installation starts over after a restart | Do not repeat the installation; ask your instructor to check the boot device |
| The Audit Mode shortcut does not work | Check VM keyboard focus and the Fn key, then ask for help |
| Sysprep displays an error | Capture the exact message and stop for instructor assistance |

For Sysprep errors, your instructor may inspect the logs inside the VM at:

`C:\Windows\System32\Sysprep\Panther`

**Do not:**

- Skip Generalize.
- Disable BitLocker as a generic fix.
- Remove applications without instructions.
- Repeatedly retry without investigating the error.
- Manually shut down and report that Sysprep succeeded.

Record incomplete steps and errors honestly.

---

## Finish Together

You should now be able to explain:

- The difference between the host and guest.
- Why this Windows 11 VM uses Generation 2, Secure Boot, and TPM.
- What Audit Mode is for.
- What OOBE, Generalize, and Shutdown each do.
- Why the reference VM remains powered off.

### Lab 8B Evidence Reminder

If completing Lab 8B, use its submission instructions. The four screenshot points are:

1. Secure Boot and TPM enabled.
2. Audit Mode desktop with Sysprep visible.
3. OOBE, Generalize, and Shutdown selected.
4. VM Off after Sysprep completes without reporting an error.

This walkthrough does not add another submission.

**Retain the VM and its files until your instructor authorizes cleanup.**

## References

- [Microsoft: Windows 11 VM requirements](https://learn.microsoft.com/en-us/windows/whats-new/windows-11-requirements#virtual-machine-support)
- [Microsoft: Boot Windows to Audit Mode or OOBE](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/boot-windows-to-audit-mode-or-oobe?view=windows-11)
- [Microsoft: Generalize a Windows installation](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation?view=windows-11)
