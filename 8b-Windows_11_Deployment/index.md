# OSYS1200 Lab 8B: Preparing a Windows 11 Reference VM

**Course:** OSYS1200  
**Topic:** Installation, Audit Mode, and Generalization

## Scenario

You work for a small web studio preparing Windows computers for new developers. Instead of configuring every computer from scratch, the studio wants a consistent starting point.

Your task is to install Windows 11 in a new virtual machine and prepare that installation for later deployment.

**This lab ends with a generalized, powered-off reference VM. Capturing an image and testing its deployment are separate tasks and are not required here.**

## Learning Objectives

By completing this lab, you will:

- Configure a Windows 11 VM using Hyper-V.
- Perform a clean installation using official installation media.
- Enter Audit Mode to prepare a reference installation.
- Use Sysprep to generalize Windows and shut down the VM.
- Explain why generalization is required before deployment.

## Before You Begin

You need:

- An instructor-approved college Windows PC with Hyper-V available.
- Permission to create and manage VMs.
- Enough available memory and disk space for the new VM and installation media.
- An official Windows 11 ISO approved by your instructor.

If Hyper-V is missing or virtualization is unavailable, contact your instructor. Enabling Hyper-V may require a restart.

> **Safety:** Perform all installation and Sysprep steps inside the new lab VM only. Do not reinstall or generalize the physical college computer or an existing course VM. Never include passwords, product keys, or recovery keys in screenshots.

## Submission

Use **Snipping Tool** (`Win + Shift + S`) to capture your evidence.

Submit one Word document named:

`YourName_Lab8B.docx`

Include the four screenshots identified below and the two short written responses at the end.

---

## Activity 1 — Prepare the Virtual Machine

### 1. Obtain Windows 11 Installation Media

Use the ISO supplied by your instructor, or download official media from:

[Microsoft: Download Windows 11](https://www.microsoft.com/software-download/windows11)

Select the Windows 11 disk image matching the classroom computer's architecture and your instructor's directions. Use the approved edition and licensing arrangements.

### 2. Create the VM

Open **Hyper-V Manager** and select **New > Virtual Machine**.

Use these settings:

| Setting | Required configuration |
|---|---|
| Name | `WebStudio-Reference` |
| Generation | **Generation 2** |
| Startup memory | **4096 MB minimum** |
| Network | **Default Switch**, or the switch specified by your instructor |
| Virtual hard disk | Create a **new** disk with a capacity of **at least 64 GB** |
| Installation media | Select the approved Windows 11 ISO |

Record where the VM and its virtual disk are stored.

Do not create an External Switch or change the college PC's network configuration unless instructed.

### 3. Check Settings Before Starting

Right-click the new VM and select **Settings**.

- Under **Processor**, set **Number of virtual processors** to **2**.
- Under **Security**, enable **Secure Boot** and select the **Microsoft Windows** template where shown.
- Enable **Trusted Platform Module**.
- Confirm the Windows 11 ISO is attached to the virtual DVD drive.
- Click **OK**.

> **Why these settings?** Generation 2 provides UEFI firmware. Secure Boot helps verify trusted startup components, and the virtual TPM provides security functionality required for this Windows 11 VM.

### Screenshot 1

Capture the VM's **Security** settings showing both:

- Secure Boot enabled.
- Trusted Platform Module enabled.

---

## Activity 2 — Install Windows 11

1. Right-click `WebStudio-Reference` and select **Connect**.
2. Start the VM.
3. When prompted, press a key to boot from the installation media.
4. Choose the appropriate language and keyboard settings.
5. Start the Windows installation.
6. If prompted for a product key, follow your instructor's licensing directions. Select **I don't have a product key** only if instructed and that option is available.
7. Select the Windows 11 edition approved by your instructor.
8. Accept the applicable licence terms.
9. Choose the clean-install option. Depending on the installer, this may be labelled **Custom: Install Windows only**.
10. Select the **unallocated space on the new VM's virtual disk** and continue.

> **Stop if the disk layout is unexpected.** Do not delete partitions or select another disk to make the installation proceed. Ask your instructor.

Windows will copy files and restart. After the first restart, do not press a key to boot from the ISO again.

When you reach the first Windows setup screen asking for your country or region, **stop and continue to Activity 3**.

> Installer screens vary between Windows 11 versions. If the options differ substantially, ask your instructor rather than guessing.

---

## Activity 3 — Enter Audit Mode

Audit Mode lets administrators prepare a Windows installation before its normal first-user setup is completed.

1. At the country or region screen, press **Ctrl + Shift + F3**.
   - Some keyboards also require the **Fn** key.
   - Make sure the VM connection window has keyboard focus.
2. Windows should restart into **Audit Mode** using its built-in Administrator account.
3. Wait for the desktop and **System Preparation Tool (Sysprep)** window to appear.
4. Do not create a personal Microsoft account or a separate `LabAdmin` account for this activity.

If the shortcut does not work, contact your instructor.

### Screenshot 2

Capture the Audit Mode desktop with the **Sysprep** window visible.

> Audit Mode is a preparation environment, not the normal everyday account setup for a developer. Do not sign into personal services or install/update Microsoft Store apps during this lab.

---

## Activity 4 — Generalize and Shut Down

Each Windows installation contains machine-specific information. Before reusing an installation for deployment, administrators generalize it with Sysprep.

Generalization removes machine-specific information, including the computer SID. A computer name and SID are different things. Generalization is not a factory reset.

### 1. Configure Sysprep

In the Sysprep window, select:

| Setting | Selection |
|---|---|
| System Cleanup Action | **Enter System Out-of-Box Experience (OOBE)** |
| Generalize | **Checked** |
| Shutdown Options | **Shutdown** |

If you closed the window, reopen:

`C:\Windows\System32\Sysprep\sysprep.exe`

### Screenshot 3

Before clicking **OK**, capture the Sysprep window showing:

- **OOBE**
- **Generalize checked**
- **Shutdown**

### 2. Run Sysprep

1. Click **OK**.
2. Allow Sysprep to finish without interrupting it.
3. The VM should shut down when processing completes.
4. **Leave the reference VM powered off. Do not restart it to check the region screen.**

Starting the reference installation again begins the next setup stages and changes its prepared state. A later boot test should use a separate test copy.

### Screenshot 4

Capture **Hyper-V Manager** showing `WebStudio-Reference` in the **Off** state after Sysprep completes without reporting an error.

> The settings screenshot and Off state document your procedure. The Off state alone does not prove that generalization succeeded or that a deployment image has been captured and tested.

### If Sysprep Fails

- Capture the exact error message.
- Record what you were doing when it appeared.
- Contact your instructor.
- Relevant logs are located in:
  `C:\Windows\System32\Sysprep\Panther`

**Do not:**

- Skip the Generalize option.
- Repeatedly retry without investigating the error.
- Remove apps or disable BitLocker as a generic fix.
- Manually shut down the VM and report that as successful Sysprep completion.

If you cannot complete generalization, submit the available evidence and the error details. Clearly identify the activity as incomplete.

---

## Short Written Responses

Include these in your Word document. Answer each in approximately two or three sentences.

1. **Why must a Windows reference installation be generalized before it is reused for other computers?**
2. **Why should the reference VM remain powered off after Sysprep finishes?**

## Submission Checklist

- [ ] Screenshot 1: Secure Boot and TPM enabled.
- [ ] Screenshot 2: Audit Mode desktop with Sysprep visible.
- [ ] Screenshot 3: OOBE, Generalize, and Shutdown selected.
- [ ] Screenshot 4: Reference VM Off after successful Sysprep processing.
- [ ] Both written responses completed.
- [ ] Any errors or incomplete steps clearly documented.
- [ ] No passwords, product keys, or recovery keys included.
- [ ] Document saved as `YourName_Lab8B.docx`.

**Leave your reference VM powered off and retain its files until your instructor authorizes cleanup.**
