# Packaging & Installing Software in Windows 11
**OSYS1200 • Module 8: Tools, Software and Applications**

---

## Slide 1: Packaging & Installing Software in Windows 11
* From legacy `Setup.exe` wizards to silent `.msi` deployments, containerized `MSIX`/`AppX` packages, and modern CLI automation with `winget`.
* **Goal:** Understand what happens under the hood when software installs on Windows—and how administrators deploy, audit, and remove apps without clicking *Next → Next → Finish*.

---

## Slide 2: What Does an Installer *Actually* Do?
Installing software is rarely just copying files. A standard Windows installer touches four layers of the OS:
1. **Filesystem:** Extracts binaries to `C:\Program Files` (64-bit) or `Program Files (x86)`, plus shared runtime DLLs.
2. **Registry:** Writes app settings, file associations (`HKCR`), and **Uninstall metadata** in `HKLM`.
3. **Services & Drivers:** Registers background Windows services (e.g., updaters), scheduled tasks, or kernel drivers.
4. **Shell & PATH:** Creates Start Menu shortcuts, Desktop icons, and adds CLI tools to the system `PATH`.

> **Why "Just Deleting the Folder" Breaks Windows:** Deleting `C:\Program Files\App` leaves orphaned Registry keys, broken background services, and phantom entries in *Installed apps*.

---

## Slide 3: How Does Settings Know What's Installed?
Every traditional installer writes an entry into the Windows Registry Uninstall keys:
* `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`
* `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall`

**Key Values Written:**
* `DisplayName` → App name shown in Settings
* `DisplayVersion` → Version number for patching audits
* `Publisher` → Vendor name
* `UninstallString` → Exact command Windows runs when you click **Uninstall**

---

## Slide 4: The 4 Windows Packaging Formats
1. **Traditional `Setup.exe`:** Compiled executable running a custom installer engine (NSIS, Inno Setup, InstallShield); vendor-specific CLI switches.
2. **Windows Installer (`.msi`):** A structured **relational database** interpreted by Windows (`msiexec.exe`), built for enterprise standardization and clean rollbacks.
3. **UWP / `AppX`:** Sandboxed Universal Windows Platform package (Microsoft Store apps like Calculator, Whiteboard) with isolated filesystem & registry virtualization.
4. **Modern `MSIX`:** Microsoft's modern unified container format for **Win32, .NET, and UWP** apps—supporting delta updates, mandatory digital signing, and 100% clean uninstalls.

---

## Slide 5: Legacy `Setup.exe` (The Wild West)
* **Strengths:** Total flexibility for custom UIs, prerequisite checks (.NET, C++ redistributables), and pre/post scripts.
* **Admin Headaches:**
  * No universal silent flag (`/S`, `/silent`, `/verysilent`, `/qn`?).
  * Often leaves orphaned files and Registry entries after uninstall.
  * Harder to automate without wrapping.

---

## Slide 6: Windows Installer (`.msi`) & `msiexec.exe`
* **Standardized Flags:**
  * `/i` → Install package
  * `/x` → Uninstall package
  * `/quiet` (or `/qn`) → Zero UI / unattended
  * `/norestart` → Prevent surprise reboots
  * `/l*v install.log` → Verbose logging
* **Enterprise Superpowers:** Transactional rollback on failure + Transform files (`.mst`) to customize installs without altering the signed `.msi`.

---

## Slide 7: `AppX` & `MSIX` (Containerized Apps)
* Apps write files to protected folders under `C:\Program Files\WindowsApps`.
* Registry writes go into an isolated virtual registry hive—not shared `HKLM`.
* **Mandatory Digital Signature:** Unsigned `MSIX` packages are blocked unless explicitly trusted.
* **Block-based Updates:** Only changed 64KB blocks download during updates.

---

## Slide 8: Format Comparison Matrix

| Format | Silent Install Standard | Clean Uninstall | Sandboxed | Primary Delivery |
| :--- | :--- | :--- | :--- | :--- |
| `Setup.exe` | Varies by vendor (`/S`, `/silent`) | Often leaves residue | No | Web downloads, wrapped in Intune/PSADT |
| `.msi` | Uniform (`msiexec /i ... /quiet`) | High (tracked database) | No | GPO, Intune, SCCM, enterprise scripts |
| `AppX (UWP)` | `Add-AppPackage` / Store | Complete (zero residue) | Yes | Microsoft Store, PowerShell |
| `MSIX` | `Add-AppPackage` / `winget` | Complete (zero residue) | Yes | MS Store, Intune, modern Win32 packaging |

---

## Slide 9: How Admins Deploy Software Today
* **Package Managers (CLI):** `winget` (native Windows 11 CLI) and **Chocolatey**.
* **MDM & Enterprise Toolkits:** **Microsoft Intune / Company Portal** (cloud push + self-service catalog) and **PSAppDeployToolkit (PSADT)** for scripted pre-install checks and logging.

---

## Slide 10: `winget` (Lab 6 Activity 4)
```powershell
winget search PowerToys
winget install Microsoft.PowerToys --source winget
winget list
winget upgrade --all
```
* *Tip:* If PowerToys was already installed in Lab 5, run `winget upgrade Microsoft.PowerToys` or `winget list Microsoft.PowerToys`.

---

## Slide 11: Silent `.msi` Deployment with `msiexec` (Lab 6 Activity 6)
```cmd
msiexec.exe /i 7z2409-x64.msi /quiet
msiexec.exe /x 7z2409-x64.msi /quiet
```
* Use **Command Prompt (Admin)** so PowerShell doesn't misinterpret mixed slash flags passed to legacy Win32 tools.

---

## Slide 12: Managing Store / UWP Apps in PowerShell (Lab 6 Activity 7)
```powershell
Get-AppPackage
Get-AppPackage -Name *Todos*
Get-AppPackage -Name *Todos* | Remove-AppPackage
```
* Sysadmins use this exact pipeline pattern to audit and de-bloat consumer apps from enterprise Windows 11 images.

---

## Slide 13: Key Takeaways
1. Installers touch **Files, Registry, Services, and PATH**—never "uninstall" by deleting folders.
2. **`.msi`** gives admins uniform silent control (`/i`, `/x`, `/quiet`) and safe transactional rollbacks.
3. **`AppX` / `MSIX`** isolate apps in containers so uninstalls leave zero Registry clutter.
4. **`winget` & PowerShell** turn multi-step GUI clicks into repeatable one-liners.
