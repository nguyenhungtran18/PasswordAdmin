# PasswordAdmin (Enterprise Credential Vault & Smart Password Generator) <sup>v2.2.0</sup>

🌐 Bản tiếng Việt: [README.md](README.md)

---

**Account database manager & high-security password tool (Local Encryption & CSPRNG).**  
**Create and manage credentials with a disciplined flow — fully local, no cloud, no data leaves your device.**

**Local-First by Design (client-side encryption)**: Unlike traditional password managers that store data on third-party clouds, **PasswordAdmin** runs entirely on your machine. Secrets never leave your device. All key derivation, key wrapping/unwrapping and vault decryption happen in your browser — **no cloud, no accounts, no data sent anywhere**. The main Web UI (`PasswordAdmin WebUI/`) additionally uses a **local loopback server** (`crypto_bridge_server.exe` at `http://127.0.0.1:8765`) only to read/write the vault file (as ciphertext) and generate random passwords internally; no traffic ever leaves `127.0.0.1`.

*Terminology note: the app does **not** use zero-knowledge proofs. Security relies on standard authenticated encryption **AES-256-GCM + PBKDF2-HMAC-SHA256 600,000 iterations**. Anywhere older docs/versions say "Zero-Knowledge", read it as "local encryption, no server".*

---

[![GitHub Repo](https://img.shields.io/badge/GitHub-nguyenhungtran18%2FPasswordAdmin-181717?style=flat-square&logo=github)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Architecture](https://img.shields.io/badge/Architecture-Web_UI-0284c7?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Encryption](https://img.shields.io/badge/Security-AES--256--GCM_PBKDF2--600k-059669?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Interface](https://img.shields.io/badge/Theme-Modern_Light_Mode-0f172a?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![License: MIT](https://img.shields.io/badge/License-MIT-amber?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)

---

## ⚠️ Important Notice (Security Disclaimer)

**By using this software, you understand and agree to the following core security principles:**

* **Recovery via Recovery Key (no more "lose it and it's gone"):** The v2 vault uses a data-encryption key (DEK) wrapped in two independent layers — by the Master Password **and** by a 24-word Recovery Key. Forgot your password? Use the Recovery Key to set a new one (see step 6 below). **Whoever holds the Recovery Key owns the vault** — that is the definition of "vault owner" in a local-only model (no accounts, no authentication server). Lose **both** (password + Recovery Key) and no one — not even the author — can recover your data.
* **Full Data Sovereignty:** The entire database lives on your local machine (`PasswordAdmin WebUI/PasswordVault.vault.json`, AES-256-GCM encrypted JSON) or in backup JSON files you manage yourself.
* **Provided "AS IS":** Please store your Master Password safely and back up your data regularly.

---

## 🎯 Operating Principles (Core Principles)

- **Strict Mandatory Pre-Declaration:** You must declare (1) the Application/Service name and (2) the Username/Email before creating or saving a password.
- **Self-Destructing Clipboard (Auto-Purge 10s):** A copied password is wiped from the clipboard automatically after 10 seconds to defeat clipboard-hijacking malware.
- **Hybrid CSPRNG (Bridge + Fallback):** The Web UI prefers the loopback server `GET http://127.0.0.1:8765/generate?length=N` (the server generates passwords internally and **always returns a fixed 20 characters** regardless of the requested `length`); the bridge is only called when both special characters + digits are enabled, otherwise it falls back to the browser's `window.crypto.getRandomValues`.
- **Dual-Field Realtime Search:** Search independently or combined by App name and Username in realtime (linear filtering, matched literally as typed).
- **Change Master Password (Re-wrap DEK):** Change your login/vault password right in the Web UI (key button on the header): the old password is verified by trial-unwrapping the DEK → the DEK is re-wrapped with the new password (new salt) → DB overwritten. The Recovery Key stays valid.
- **24-word Recovery Key (BIP39):** A spare key for when you forget your password — randomly generated, shown exactly once, activated by re-typing 3 words. Write it on paper, store offline.
- **Rate-limit + Security Audit Log:** More than 5 wrong password/key attempts locks logins for 60 seconds; every event (unlock, password change, recovery, temporary lockout) is written to a local log, viewable in the "Recovery & Security" modal.
- **Web UI Only:** Only the modern Web UI is supported (light theme, high contrast, runs right in the browser). Note: the main Web UI **requires the local loopback server** via `Open_PasswordAdmin_Web.bat` — it is not fully "zero-server".

---

## 💎 What You Can Do

1. **Guided Password Creation:** Enter App & User info first, then generate a CSPRNG password with 1 click.
2. **Length & Complexity Tuning:** Length slider from 10 to 64 characters (only effective when one option checkbox is off or the server is down — the default bridge path always returns a fixed 20 characters), toggle special characters and digits. *No option to exclude look-alike characters (`l`, `1`, `I`, `0`, `O`) yet.*
3. **Realtime Entropy Meter:** Mathematical entropy ($E = L \times \log_2(N)$) plus brute-force time estimates. Ratings also account for minimum lengths (8/12/16 characters).
4. **Tabular Database Management (CRUD):** List view, show/hide passwords as `••••••••`, edit and delete records in a visual DataTable.
5. **Backup & Migrate (Backup & Restore):** Export the whole **AES-256-GCM encrypted** vault to JSON (`PasswordVault_Backup_YYYY-MM-DD.json`) or import a backup file (requires the matching Master Password/salt) in 1 step.
6. **Master Vault Protection:** Lock the whole app when you leave the computer, instantly decrypt again with the Master Password.
7. **Change Login Password:** Change the Master Password right in the Web UI without losing data — the DEK is re-wrapped with a new salt and the default DB overwritten (Recovery Key unchanged).
8. **Create a Recovery Key & Self-Recover a Forgotten Password:** Create the 24-word key once (`PasswordAdmin-Recovery-Key.txt` auto-downloads on activation; rotating downloads a new same-named file over the old one), then type the words or **load the Emergency Kit (.txt)** on the lock screen to set a new password yourself — no data loss, and the app never deletes your vault.
9. **Help Button in the Dashboard:** Press `?` on the header anytime to open a popup with a quick usage guide (login, key creation, copy, recovery, backup, the 3 things never to forget).

---

## 🔬 Technical Foundation

### Specs & Components:

| Component | Technical Spec | Purpose & Benefit |
|:---|:---|:---|
| **Search Engine** | Linear filter by App + User ($O(N)$) | Fast enough at a few thousand records, realtime search |
| **CSPRNG Engine** | loopback server `crypto_bridge_server.exe` (port 8765, always returns 20 characters; only called when both special characters + digits are enabled), fallback `crypto.getRandomValues` | Prefer the internal server, auto-fallback when the server is off or an option is unchecked |
| **Vault Encryption** | Vault **v2 (envelope)**: random 256-bit DEK encrypts records (AES-256-GCM); DEK independently double-wrapped with KEK = PBKDF2-HMAC-SHA256 600,000 iterations from (a) Master Password, (b) 24-word Recovery Key. Legacy v1 vaults auto-migrate on unlock. | Client-side encryption: Master Password and Recovery Key never leave the browser; the vault file holds only ciphertext. Sole exception: bridge-generated passwords travel over loopback HTTP (`127.0.0.1:8765`) as plaintext — only inside your machine, though other local processes could theoretically read them |
| **Recovery Key** | 24 BIP39 English words (2048 words, ~264-bit entropy) + PBKDF2-600k; shown once, 3-word confirmation, Emergency Kit `.txt` download support | Self-recover a forgotten password, no one else needed |
| **Brute-force Protection** | More than 5 failures → 60s lockout (stored in localStorage) + 100-event log | Stops casual guessing with borrowed machine access |
| **Web Presentation** | HTML5 + Tailwind CSS + Lucide Icons | Light Mode, high contrast; the main Web UI needs loopback server `127.0.0.1:8765` |
| **Auto-Purge Timer** | 10,000 ms (10 seconds) | Clipboard auto-wiped after copy |

### Standard Character Set (Google & Enterprise Compatible):
```text
abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?
```

### Password Strength Scale (matches Web UI code):
- **Very strong (rating 4, "Cực Mạnh (Safe)" badge):** $\ge 85\text{ bits}$ entropy **and** length $\ge 16$.
- **Good (rating 3):** $65 - 84\text{ bits}$ entropy **or** length 12–15.
- **Average (rating 2):** $40 - 64\text{ bits}$ entropy **or** length 8–11.
- **Weak (rating 1):** $< 40\text{ bits}$ entropy **or** length $< 8$.

---

## 📥 Download & Setup

### 1. Download the Pre-built Package
Get the official pre-built package from GitHub:

📦 **Direct Download Link:** 👉 **[PasswordAdmin V2.2.0](https://github.com/nguyenhungtran18/PasswordAdmin/compare/v2.2.0)**

---

### 2. Extraction Guide
1. After downloading `PasswordAdmin.zip`, right-click it and choose **Extract All...** (or use 7-Zip / WinRAR → **Extract to PasswordAdmin**).
2. Pick a convenient folder on your computer (e.g. `D:\PasswordAdmin` or `C:\Tools\PasswordAdmin`).
3. Open the extracted folder; you will see: `PasswordAdmin WebUI/index.html`, `Open_PasswordAdmin_Web.bat`, `crypto_bridge_server.exe`, `README.md`, etc. (the root `index.html` is a File System Access API variant, not the main entry-point).

---

### 3. First-Time Setup

1. **Launch the app (the .bat file is mandatory):**
   - Double-click **`Open_PasswordAdmin_Web.bat`**. It does 2 things: starts `crypto_bridge_server.exe --server 8765`, then opens `PasswordAdmin WebUI/index.html`.
   - ⚠️ Do not double-click `index.html` directly via `file://` — the Web UI needs the loopback server `127.0.0.1:8765` to read/write the vault and generate passwords; opening it bare reports "Cannot read DB" / "Crypto server not running". Keep the server window open. Use the latest Google Chrome or Microsoft Edge.

2. **First login — the default password is `123456`:**
   - In the **Password Vault** dialog, type `123456` into the *Master Password* box.
   - Press **"Mở Khóa Cơ Sở Dữ Liệu" (Unlock Database)** to enter the main dashboard (the bundled DB already contains 3 demo records; legacy v1 vaults auto-upgrade to v2 on unlock).
   - 💡 *Important:* Because the system encrypts client-side, the Master Password is used to **derive the DEK-wrapping key via PBKDF2-HMAC-SHA256 600,000 iterations with a 16-byte salt** (never stored anywhere). **Change the default password immediately** (step 5), then **create a Recovery Key** (step 6) — a yellow banner in the app reminds you until done! Lost? Press `?` on the header for a quick guide popup.
   - Empty-DB case (vault file deleted / root build): whatever password you enter on first unlock becomes the new vault's Master Password (fresh DEK, v2 format).

3. **Create your first account & password:**
   - Press **"Tạo Key Mới" (Create New Key)** (blue button, top right).
   - **Step 1 (mandatory):** enter the *Application / Service name* (e.g. `Google`, `GitHub`, `Binance`...) and *Username / Email* (e.g. `security_admin@gmail.com`).
   - **Step 2 (create the key):** press **"Tạo Ngẫu Nhiên (CSPRNG)" (Generate Random)** and the app generates a 20-character *Very Strong* password, or type your own.
   - Press **"Lưu Vào Database" (Save to Database)** to finish your first record!

4. **Safe copying with Auto-Purge Clipboard:**
   - On the saved account row, press the **Copy** icon.
   - The password is copied to the clipboard and **permanently erased after 10 seconds** for safety.

5. **Change the Master Password in-app (mandatory after first login):**
   - After unlocking with `123456`, press the **key icon 🔑** on the header bar (next to Lock) to open **"Đổi Master Password" (Change Master Password)**.
   - Enter the *current password* (`123456`) → enter the *new password* (minimum 8 characters, 12–16 recommended, with a strength meter) → *confirm* → press **"Đổi Mật Khẩu" (Change Password)**.
   - The app verifies the old password by trial-unwrapping the DEK, then re-wraps the DEK with the new password (new 16-byte salt) and **overwrites the default DB**. The Recovery Key (if created) stays valid. Use the new password from the next login on.

6. **Create a Recovery Key + recover a forgotten password:**
   - **Create the key:** press the **life-buoy icon 🛟** on the header → **"Tạo Recovery Key (24 từ)" (Create Recovery Key)** → the key is shown **exactly once**: write it on paper / store offline, then type back the 3 requested words to activate. On activation the file `PasswordAdmin-Recovery-Key.txt` **auto-downloads** (no need to press download manually). To change the key, **"Xoay Recovery Key" (Rotate)** — a new same-named `.txt` auto-downloads over the old file (if the browser saves it as a separate `(1)` file, delete the old one manually); the old key is void immediately.
   - **Forgot your password (2 ways, no typing needed):** on the lock screen press **"Quên mật khẩu? Khôi phục bằng Recovery Key" (Forgot password? Recover with Recovery Key)** → either (a) type all 24 words (commas/semicolons/newlines accepted), or (b) press **"Nạp file Emergency Kit (.txt)" (Load Emergency Kit file)** to auto-fill → Verify → set a new Master Password → the vault reopens with data intact, Recovery Key unchanged.
   - **Lost both:** The app **has and will never have a vault-delete button** — your data stays intact in the vault file, just temporarily unopenable by anyone (including the author). Find your saved key sheet / Emergency Kit file; that is why key creation requires the 3-word confirmation.
   - **Who owns the vault?** The app has no accounts/servers, so there is no ID-style identity check — **whoever holds the Recovery Key (or remembers the password) owns the vault**. So: store the key like a house key. More than 5 wrong attempts lock logins for 60s; every event goes to the **Security Audit Log** (see the 🛟 modal) to spot unauthorized access.

---

## 📁 Project Structure

```text
PasswordAdmin/
├── PasswordAdmin WebUI/         # Main entry-point: index.html + PasswordVault.vault.json + Open_PasswordAdmin_Web.bat
│   ├── index.html               # Main Web UI (reads/writes vault via loopback server 127.0.0.1:8765)
│   ├── PasswordVault.vault.json # Default Web UI DB (AES-256-GCM encrypted JSON)
│   ├── crypto_bridge_server.exe # Local loopback server (vault + password generation)
│   └── Open_PasswordAdmin_Web.bat # 1-click: runs the server then opens the Web UI (note: fix the extra `"` at the end of the start line)
├── index.html                   # Web UI variant using the File System Access API (showSaveFilePicker, Chrome/Edge)
├── Open_PasswordAdmin_Web.bat   # 1-click opener for the main Web UI + server (target already switched to PasswordAdmin WebUI/)
├── crypto_bridge.py / .exe                # HTTP bridge: vault read/write + password generation (always returns 20 characters)
├── LICENSE                      # MIT License
└── README.md                    # Vietnamese usage docs & technical spec (v2.2.0)
```

---

## 🛡️ Recommended Security Practices

### Master Password Rules:
- The app enforces a minimum of 8 characters when changing/unlocking; **12 to 16+ characters recommended**.
- Combine uppercase, lowercase, digits and special characters.
- Never share or store the Master Password as plaintext on the computer. Back up `PasswordVault.vault.json` regularly.
- **Recovery Key: print on paper, keep away from the computer** (safe/filing cabinet). No screenshots, no cloud/email/chat storage. Losing both password and Recovery Key means data loss — no exceptions.

```text
✅ Strong password examples:
    • "Tr0ngV3ct0r#Vault@2026!Sec"
    • "K3tSat#BaoMat$DoiThuong&99"

❌ Passwords to avoid:
    • "12345678", "password", "admin"
    • Guessable personal names or birthdays
```

---

## 📜 Version History

| Version | Platform | Status | Main Changes |
|:---|:---|:---|:---|
| **v2.0.0** | **Web UI** | 📦 Older | Light-theme Web UI with full UI components, standardized App/User-first key flow, dual search bar, 10s Auto-Purge Clipboard countdown. |
| **v2.1.0** | **Web UI + Bridge** | 📦 Older | **Change Master Password**, loopback server `127.0.0.1:8765` for vault read/write + native password generation, fixed copy of special-character passwords, clarified AES-256-GCM/PBKDF2-600k spec. |
| **v2.2.0** | **Web UI + Recovery** | 🚀 **Current** | Vault **v2 envelope** (DEK + dual password/recovery wrap), **24-word BIP39 Recovery Key** (create/rotate/recover by typing or loading a `.txt` file, **auto-export on activation**), **5-fails/60s rate-limit + security audit log**, auto v1→v2 migration on unlock, **no vault-delete function**, **Help** button with an in-dashboard guide. (Planned: Windows Hello unlock, cancellable recovery delay.) |

---

## 📄 License

Distributed under the **[MIT License](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)**.

Copyright (©) 2026 **nguyenhungtran18**.

---

## 🤝 Contributing & Support

* **Bug reports & feature requests:** [GitHub Issues](https://github.com/nguyenhungtran18/PasswordAdmin/issues)
* **Author:** [nguyenhungtran18](https://github.com/nguyenhungtran18)
