# PacketEye Usage Guide

This guide explains how to install and run **PacketEye** on Windows, Linux, and macOS.

---

# 1. Clone the Repository

First download the project from GitHub.

```bash
git clone https://github.com/yourusername/PacketEye.git
cd PacketEye
```

---

# 2. Install Requirements

Install the required Python packages.

```bash
pip install -r requirements.txt
```

---

# 3. Running PacketEye

## Windows Setup

### Step 1

Open **PowerShell** or **Command Prompt**.

Navigate to the project folder:

```bash
cd PacketEye
```

### Step 2

Run the Windows setup installer:

```bash
python setup.py
```

This will:

* Check Python installation
* Install required packages
* Launch PacketEye automatically

You can also run the tool directly:

```bash
python packeteye.py
```

---

# Linux Setup

PacketEye includes a Linux installer script.

### Step 1

Give execution permission:

```bash
chmod +x setup.sh
```

### Step 2

Run the installer:

```bash
bash setup.sh
```

The installer will:

* Check Python installation
* Install required dependencies
* Start PacketEye automatically

If required, run with sudo:

```bash
sudo python packeteye.py
```

---

# macOS Setup

Create a macOS setup script called **setup_mac.sh**.

Example file structure:

```
PacketEye/
│
├── packeteye.py
├── setup_mac.sh
├── requirements.txt
```

### setup_mac.sh

```bash
#!/bin/bash

echo "Starting PacketEye setup..."

python3 -m pip install -r requirements.txt

echo "Setup complete."

python3 packeteye.py
```

### Run macOS Setup

Make the script executable:

```bash
chmod +x setup_mac.sh
```

Run the installer:

```bash
./setup_mac.sh
```

---

# 4. What PacketEye Does

PacketEye scans your local network and identifies connected devices.

It collects information such as:

* IP Address
* MAC Address
* Device Name
* Vendor Information
* Activity Status

---

# 6. Troubleshooting

### ModuleNotFoundError

Install requirements again:

```bash
pip install -r requirements.txt
```

### Permission Error (Linux/macOS)

Run the tool with elevated privileges:

```bash
sudo python packeteye.py
```

---

# 7. Security Notice

Use PacketEye only on networks you own or have permission to scan.