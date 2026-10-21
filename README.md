# 🚀 KTUTIL — Kirfi Tech System Utility v1.0

> **Maintainer:** Ukasha M. I. Kirfi | IoT & AI Systems Developer  
> **Repository:** [github.com/kirfi02/ktutil](https://github.com/kirfi02/ktutil)

`KTUTIL` is an advanced, lightweight Windows debloat, maintenance, and environment provisioning utility. It replicates 100% of Chris Titus Tech's `winutil` functionality while introducing a specialized **Beyond Layer** built specifically for **Local AI Engineers** and **Embedded Hardware/IoT Developers**.

---

## ⚡ Quick Start (One-Line Web Bootstrapper)

Open **PowerShell as Administrator** and execute:

```powershell
irm https://raw.githubusercontent.com/kirfi02/ktutil/main/setup.ps1 | iex
```

---

## 🛠️ Key Features

### 1. CTT Feature Parity
- **Application Installation:** Automated silent installation of popular browsers, utilities, and developer environments via `winget`.
- **Windows Debloat & Privacy:** Telemetry removal (`DiagTrack`), disabling Cortana web search, Copilot disabling, and Xbox Game Bar removal.
- **System Repair & Maintenance:** Built-in SFC & DISM repair wrappers, network stack resets (`netsh`), DNS flushing, and legacy Control Panel shortcuts.
- **Windows Update Management:** Policy controls for Default, Security-Only (feature deferral), and Total Pause modes.

### 2. The "Beyond" Layer (Kirfi Tech Specialized Modules)
- **Local AI Runtime Engine:** Auto-provisioning Ollama, background service management, model pulling (`DeepSeek-R1`, `Qwen2.5-Coder`), and Docker host setup.
- **Embedded & IoT Developer Toolkit:** Auto-installing Arduino IDE 2.x, ESP-IDF, PlatformIO, Wireshark, PuTTY, and USB-to-Serial drivers (`CH340`, `CP210x`, `FTDI`) with COM port optimization.
- **Declarative State Engine:** JSON-backed registry and configuration snapshots for auditing and rollback.

---

## 📁 Repository Structure

```text
ktutil/
├── setup.ps1             # One-line web launcher
├── ktutil.ps1            # Main WPF UI, ASCII banner & execution engine
├── README.md             # Documentation & instructions
└── config/
    ├── apps.json         # Winget IDs for General Apps, AI Stack & IoT Tools
    └── tweaks.json       # Registry paths, service configs & debloat flags
```

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
