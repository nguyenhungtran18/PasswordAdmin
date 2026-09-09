# PasswordAdmin (Enterprise Credential Vault & Smart Password Generator) v2.0.0
[English](README.md) | [Tiếng Việt](README.vi.md)

A high-security, local-first credential management vault and smart password generation utility engineered with the **TokenVector** core language. It enforces strict declaration workflows, zero-knowledge isolation, hardware entropy generation, and automated clipboard hygiene.

[![GitHub Repo](https://img.shields.io/badge/GitHub-nguyenhungtran18%2FPasswordAdmin-181717?style=flat-square&logo=github)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Core Language](https://img.shields.io/badge/Core_Engine-TokenVector-blueviolet?style=flat-square&logo=codeforces)](https://github.com/nguyenhungtran18/TokenVector)
[![Architecture](https://img.shields.io/badge/Architecture-Native_AOT_+_Web_UI-0284c7?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Encryption](https://img.shields.io/badge/Security-Zero--Knowledge_SHA--256-059669?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![Interface](https://img.shields.io/badge/Theme-Modern_Light_Mode-0f172a?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin)
[![License: MIT](https://img.shields.io/badge/License-MIT-amber?style=flat-square)](https://github.com/nguyenhungtran18/PasswordAdmin/blob/main/LICENSE)
---

## ⚡ Local-First & Zero-Knowledge by Design

Unlike conventional cloud-based password managers that transmit ciphertext or credentials over third-party infrastructure, **PasswordAdmin** operates entirely on your local machine:
* **Zero Outbound Telemetry:** Keys, digests, and credential sets never leave your device.
* **Master Vault Key Isolation:** Master passwords are processed directly on bare metal using cryptographic hashing (SHA-256 / PBKDF2). No authentication server exists to decrypt or leak your credentials.
* **Full Data Sovereignty:** Your vault database (`vault.tkvdb`) remains exclusively under your local operating system ownership.

## ⚠️ Important Security Disclaimer

By using this software, you acknowledge and agree to the following zero-knowledge constraints:
* **No "Forgot Password" Mechanism:** The Master Password is the single cryptographic anchor used to encrypt and decrypt the repository. If you lose your Master Password, **your data is permanently irretrievable**.
* **Self-Managed Backups:** Always retain copies of your `vault.tkvdb` database file or exported encrypted JSON backups.
* **Provided "AS IS":** The software is provided under the MIT License without warranty of any kind.
---

## 🚀 Core Pillar: TokenVector Core Engine

The internal cryptographic processing engine and high-throughput search indexing system are implemented in the [TokenVector](https://github.com/nguyenhungtran18/TokenVector) programming language:

* **$O(1)$ Inverted Index Lookup:** Tokenizes search targets by application identifiers and usernames, enabling constant-time queries across dense local datasets without requiring $O(N)$ sequential table scans.
* **Memory Safety:** Leverages native TokenVector memory safety invariants to prevent memory leaks, buffer overruns, and wild pointers.
* **Standalone AOT Native Compilation:** Compiles directly via `tkvc.exe` into a compact ~30 KB native PE binary (`PasswordAdmin.exe`) with near-zero cold-start latency and zero external runtime dependencies.

---

## 🎯 Key Architectural Principles

* **Mandatory Pre-Declaration:** Enforces systematic credential management by requiring both (1) *Application / Service Name* and (2) *Username / Email* to be defined prior to key generation or commitment.
* **10-Second Auto-Purge Clipboard:** Any credential copied to the system clipboard is automatically overwritten and erased after 10,000 ms to mitigate clipboard-hijacking malware and background scrapers.
* **Hardware-Backed CSPRNG:** Generates cryptographic-grade pseudo-random passwords populated from OS hardware entropy pools (`crypto.getRandomValues`).
* **Dual-Field Real-Time Filtering:** Provides dynamic concurrent filtering across both Application and Username fields simultaneously.
* **Dual Interface Architecture:** Supports both an ultra-clean, high-contrast Web UI (Light Mode) and a headless native CLI executable for scripts and terminals.

---

## 🔬 Technical Specifications

| Component | Specification | Technical Objective |
| :--- | :--- | :--- |
| **Core Language** | [TokenVector](https://github.com/nguyenhungtran18/TokenVector) (`.tkv`) | High-efficiency native execution, memory safety, compact footprint |
| **Search Engine** | $O(1)$ Inverted Index Engine | Sub-millisecond lookup by service name and user handle |
| **CSPRNG Source** | OS Hardware Entropy Pool | Unpredictable, non-repeating character distribution |
| **Vault Security** | SHA-256 Digest / PBKDF2 | Zero-knowledge master authentication and vault locking |
| **UI Presentation** | HTML5 / Tailwind CSS / Lucide | High-contrast presentation with zero backend server overhead |
| **Clipboard Guard** | 10,000 ms Hard Timer | Automatic clipboard memory cleanup |

### Standard Character Set:
```text
abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?

```

### Password Strength & Entropy Scale:

* **Unbreakable ($\ge 85$ bits):** Immune to distributed brute-force clusters.
* **Safe ($65 - 84$ bits):** Enterprise-grade security against specialized cracking hardware.
* **Medium ($40 - 64$ bits):** Standard complexity; length extension recommended.
* **Weak ($< 40$ bits):** Vulnerable to dictionary and hybrid mask attacks.

---

## 📥 Installation & Getting Started

### 1. Download Pre-Built Release

Grab the latest release package directly:

* 📦 **Direct Download:** [PasswordAdmin.zip (v2.0.0)](https://github.com/nguyenhungtran18/PasswordAdmin/releases)

### 2. Extraction

Extract the compressed archive to your preferred local directory:

```bash
# Example extraction target:
C:\Tools\PasswordAdmin\

```

### 3. First-Time Setup

1. **Launch the Application:**
* Double-click `Open_PasswordAdmin_Web.bat` (or open `index.html` directly in any modern browser).


2. **Initialize Master Key:**
* When prompted with the **Vault Dialog**, define your Master Password.
* This password initializes the cryptographic hash (`vault.tkvdb`). Memorize this key.


3. **Register New Credential:**
* Select **Create Key** (top right).
* Complete the required declaration: **Application Name** and **Username / Email**.
* Click **Generate CSPRNG** to generate a randomized high-entropy key, then select **Save to Database**.


4. **Secure Clipboard Usage:**
* Click the **Copy** icon next to any credential. The key copies to your clipboard and permanently wipes after 10 seconds.



---

## 💻 TokenVector Native CLI Execution

For headless workflows, command-line environments, or custom compilation:

```powershell
# Ahead-Of-Time (AOT) compilation via TokenVector SDK:
tkvc.exe PasswordAdmin.tkv -o PasswordAdmin.exe

# Execute native console binary:
.\PasswordAdmin.exe

```

---

## 📁 Repository Structure

```text
PasswordAdmin/
├── index.html                   # High-contrast Web UI application
├── Open_PasswordAdmin_Web.bat   # 1-click Windows quick launcher
├── PasswordAdmin.tkv            # Main TokenVector orchestration entry point
├── crypto_engine.tkv            # Cryptographic & CSPRNG module
├── token_vector_engine.tkv      # O(1) Inverted index search engine
├── vault_repository.tkv         # Vault persistence & database layer
├── models.tkv                   # Data models (Credential, Category, Vault)
├── ui_desktop.tkv               # Native desktop & CLI interface engine
├── PasswordAdmin.exe            # 30 KB compiled AOT native executable
├── vault.tkvdb                  # Local encrypted vault database
├── LICENSE                      # MIT License terms
└── README.md                    # Project documentation

```
PasswordAmin Samples screenshots:

## 1. CLI: 
<img width="818" height="435" alt="PasswordAdmin_CLI" src="https://github.com/user-attachments/assets/b5010ffe-1ceb-4d49-9644-c160e4dd0a6a" />
<img width="964" height="476" alt="PasswordAdmin_CLI_1" src="https://github.com/user-attachments/assets/88e4dd87-31bb-499b-86d5-5b5ab98368c4" />
<img width="966" height="475" alt="PasswordAdmin_CLI_2" src="https://github.com/user-attachments/assets/bf9160c5-a511-44bd-9d5c-90803cbf4a27" />

## 2.Web UI:
<img width="446" height="434" alt="Master_Key" src="https://github.com/user-attachments/assets/6161f8b9-4398-4b9a-9d18-e1bc77569741" />
<img width="1220" height="561" alt="DashBoard" src="https://github.com/user-attachments/assets/119b2aa7-d241-459e-bc6e-017d299098b1" />
<img width="509" height="749" alt="Generate_Key" src="https://github.com/user-attachments/assets/58701a74-29f3-4309-aa66-0fb93b9a4f94" />

---

## 📜 Version History

| Version | Core Engine | Status | Description |
| --- | --- | --- | --- |
| **v1.0.0** | TokenVector CLI | 📦 Legacy | Baseline native terminal application with AOT compilation. |
| **v2.0.0** | TokenVector + Web UI | 🚀 Current | Added high-contrast Web UI, pre-declaration flow, dual search index, and 10s auto-purge clipboard security. |

---

## 📄 License

Distributed under the [MIT License](https://www.google.com/search?q=LICENSE).

Copyright (c) 2026 **nguyenhungtran18**.
