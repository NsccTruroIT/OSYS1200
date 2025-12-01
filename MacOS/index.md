# Worksheet: MacOS Field Trip
**Student Name:** ___________________________

---

### Part 1: System Reconnaissance (System Info)
*Use the "About this Mac" menu and "System Settings > Network" to answer the following.*

1. **Identify the OS:**
   * What is the macOS Version Number? __________________
   * What is the Code Name (e.g., Sonoma, Sequoia)? __________________
   * *Admin Check:* Is the processor an **Intel** chip or **Apple Silicon** (M1/M2/M3)? __________________

2. **Network Identity:**
   * What is the IPv4 Address of this Mac? __________________
   * What is the Router (Gateway) IP Address? __________________
   * Who is the DNS Provider? __________________

3. **Storage Analysis:**
   * Go to **General > Storage**. How much space is currently occupied specifically by **Applications**? __________________

---

### Part 2: Environment Setup (User Preferences)
*Customize the workspace to suit a power user workflow. Check the box once completed.*

- [ ] **Theme:** Enable **Dark Mode** (System Settings > Appearance).
- [ ] **Workspace:** Move the **Dock** to the *Left* side of the screen.
- [ ] **Real Estate:** Set the Dock to **"Automatically hide and show."**
- [ ] **Menu Bar:** Set the top Menu Bar to **"Automatically hide and show"** (on Desktop only).
- [ ] **The "IT Pro" View:** Open **Finder**. Go to Settings > Advanced. Check the box for **"Show all filename extensions."** (*Why? Because `malware.pdf.exe` is a real threat*).

---

### Part 3: Devices & Hardware
*Dig deeper into how the hardware is interacting with the OS.*

1. **The "Mouse Fix":**
   * Go to **Mouse/Trackpad** settings. Locate "Natural Scrolling" and turn it **OFF**.
   * *Question:* Why was it "backwards" by default?
   * *Answer:* __________________________________________________________________
   *(Hint: Think about how you use a smartphone screen vs. a scrollbar).*

2. **File System:**
   * Open **Disk Utility** (`Cmd+Space` > Type "Disk Utility"). Select the "Macintosh HD".
   * What **File System** format is it using? (e.g., NTFS, HFS+, APFS) __________________
   * Is the physical drive listed as a SATA Disk or NVMe/PCI-Express? __________________

3. **Updates:**
   * Are there any pending **Software Updates** (OS patches)? (Yes/No) __________________

4. **Connectivity:**
   * Connect to the **NSCCGuest** WiFi network.
   * *Observation:* Unlike Windows, did a captive portal (webpage) pop up automatically, or did you have to open Safari manually to trigger it? __________________

---

### Part 4: Terminal Challenge
*Open the Terminal app to complete these tasks.*

1. **Connectivity Test:**
   * Run a ping command to Google (`ping 8.8.8.8`).
   * *Challenge:* How do you **STOP** the ping command? (Hint: It’s not Esc). __________________

2. **The Hosts File:**
   * Run the command `cat /etc/hosts`.
   * What is the IP address associated with `localhost`? __________________
