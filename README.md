# **Self-Healing Process Guard (Bash + systemd)**

A lightweight, production-minded Bash watchdog that monitors an application and **automatically restarts it if it stops or crashes**.  
Ideal for learning **Linux automation, service supervision, systemd, logging, and resiliency engineering**.

---

## 🚀 **How It Works**
1. Your application (`app.sh`) runs in the background.  
2. `process_guard.sh` checks every 5 seconds using `pgrep -f`.  
3. If the app dies → the guard restarts it instantly.  
4. All events are logged with timestamps into `guard.logs`.  
5. A systemd service (`process_guard.service`) can run this guard as a real Linux daemon.

---

## 📸 **Demo Screenshots**

### **1️⃣ systemd service file**
![process_guard_terminal](https://github.com/user-attachments/assets/60b38136-b2ca-40a0-b3c2-e3adf8a8c180)

### **2️⃣ Auto-Restart After Manual Kill**
![logs](https://github.com/user-attachments/assets/5c084ea4-ada0-40e5-aae9-a8c967cd5fb3)

### **3️⃣ Service Status Output**
![ststus](https://github.com/user-attachments/assets/eb2b523a-1802-41f2-b2bc-88d2ca86b40c)


---

## ✨ **Features**
- ✔ Monitors an application using `pgrep -f`  
- ✔ Auto-restores the app using `nohup bash app.sh &`  
- ✔ Timestamped logs for auditing (`guard.logs`)  
- ✔ Lightweight — **pure Bash**, no dependencies  
- ✔ systemd service support  
- ✔ Demonstrates real DevOps/SRE concepts:
  - self-healing  
  - service supervision  
  - logging & monitoring  


---

## ⚙️ **Quick Setup (Local Testing)**

### **1. Clone the repo**  
git clone https://github.com/Safi-Ahmed-Shariff/Application_monitoring.git  
cd Application_monitoring  
2. Make scripts executable:  
  chmod +x process_guard.sh app.sh  
3. Create a simple demo app.sh if not present:  

#!/usr/bin/env bash  
app.sh - demo app that runs until killed  
while true; do  
  echo "App running at $(date)" >> /home/app_output.log  
  sleep 2  
done  
4. Start the guard (background):  

nohup /bin/bash ./process_guard.sh >/dev/null 2>&1 &
![background jobs](https://github.com/user-attachments/assets/03d3270d-f6a0-4b46-b45b-5b6a317fd95f)

5. Verify logs:  

tail -f guard.logs  

## ⭐ **Running as a systemd Service (Recommended)**  

Systemd gives production-grade behavior:  
Starts on boot  
Auto-restarts on failure  
Log management via journalctl  
Runs as a real Linux daemon  
Service File (included in repository)  
systemd/process_guard.service:  

[Unit]  
Description=Process Guard For Demo Application  
After=network.target  

[Service]  
Type=simple  
ExecStart=/usr/bin/bash /home/safi/cloud/practice/app/process_guard.sh  
Restart=always  
RestartSec=5  
User=safi  
StandardOutput=journal  
StandardError=journal  

[Install]  
WantedBy=multi-user.target  

## 🔧 **Update ExecStart path & username before installing.**

Install the service  
sudo cp systemd/process_guard.service /etc/systemd/system/  
sudo systemctl daemon-reload  
sudo systemctl start process_guard.service  
sudo systemctl enable process_guard.service  

Check status  
systemctl status process_guard.service  

View live logs  
journalctl -u process_guard -f 

## 🧪 **How to Demo the Auto-Heal**

1. Start the process guard (via systemd or nohup)  
2. Confirm both guard + app are running:   
pgrep -af app.sh  
pgrep -af process_guard.sh  
3. Kill the demo app:  
pkill -f app.sh  
4. Watch logs:  
[WARNING]: APPLICATION STOPPED  
[INFO]: APPLICATION RESTARTING  
[INFO]: RESTART SUCCESSFUL
5. Check app output file again — it should be writing new timestamps.

## 🛠️ **Troubleshooting**
Check permissions if restarts fail  
Use pgrep -af to inspect running processes  
Run with verbose mode for debugging: bash -x process_guard.sh  
Use shellcheck to improve script quality:  
sudo apt install shellcheck
shellcheck process_guard.sh

**Contact**  
Author: Safi Ahmed Shariff — [LinkedIn](https://www.linkedin.com/in/safi-ahmed-shariff-b03499264)
