**Self-Healing Process Guard (Bash**

Small, production-minded Bash watchdog that monitors an application and automatically restarts it if it stops. Ideal for learning Linux automation, process supervision, and logging.

**Demo**

Kill the app → process guard detects crash → restarts the app within a few seconds → timestamped recovery log entry appended to guard.logs.

![process_guard_terminal](https://github.com/user-attachments/assets/60b38136-b2ca-40a0-b3c2-e3adf8a8c180)

![process_guard_terminal](https://github.com/user-attachments/assets/60b38136-b2ca-40a0-b3c2-e3adf8a8c180)

**Features**

· Monitors application process with pgrep -f.
· Automatic restart using nohup bash <app> &.
· Timestamped recovery logs for auditing (guard.logs).
· Lightweight — pure Bash, no dependencies.
· Demonstrates Linux automation, logging, and resilience concepts

**Quick setup / install (local test)**

1. Clone the repo and cd into it.
2. Make scripts executable:
  chmod +x process_guard.sh app.sh
3. Create a simple demo app.sh if not present:

#!/usr/bin/env bash
# app.sh - demo app that runs until killed
while true; do
  echo "App running at $(date)" >> /home/app_output.log
  sleep 2
done
4. Start the guard (background):

nohup /bin/bash ./process_guard.sh >/dev/null 2>&1 &

5. Verify logs:

tail -f guard.logs

Add to crontab so it starts on reboot
Open crontab with crontab -e and add:

@reboot nohup ./process_guard.sh >/dev/null 2>&1 &

**How to demo the auto-heal**

1.Start guard.
2.Confirm guard is running and app is running.
3.Kill the demo app: pkill -f app.sh
4.Watch guard.logs or service logs — you should see:

[WARNING]: APPLICATION STOPPED
[INFO]: APPLICATION RESTARTING
[INFO]: RESTART SUCCESSFUL

5.Verify the demo app output file is being appended to again.

**Logs & troubleshooting**
· guard.logs contains timestamped events for audit: restarts, failures, run-state.
· If restart fails, check file permissions, environment, and executable path.
· Use pgrep -af to see running processes and confirm the app.sh start command is correct.
· Consider adding shellcheck linting for robustness: sudo apt install shellcheck then shellcheck process_guard.sh.

**contact**
Author: Safi Ahmed Shariff — add your [LinkedIn](https://www.linkedin.com/in/safi-ahmed-shariff-b03499264) link here.
