# 🐧 Linux Interview Questions & Answers

> A structured Q&A guide covering Linux fundamentals — OS features, components, shell, filesystem, networking, and process management.

## Q1. Explain the basic features of the Linux OS.

Some **basic features** of Linux are:

- **Free & Easily Available** — Linux is open-source and freely available to everyone.
- **Secure** — It is more secure than other operating systems because it uses **security auditing** and **password authentication** features.
- **Personal Software Repository** — Linux has its own personal software repository for package management.
- **Multi-language Support** — It includes multiple languages throughout the world. Hence Linux supports different language keyboards.
- **CLI and GUI** — It offers both Command Line Interface (CLI) and Graphical User Interface (GUI) to use different commands and applications such as Firefox, VLC, etc.

---

## Q2. Name some Linux Distros

There are various Linux distros but the following are the most commonly used:

| Distro     | Description                              |
|------------|------------------------------------------|
| **Ubuntu** | Beginner-friendly, Debian-based          |
| **Debian**  | Stable and community-driven              |
| **CentOS**  | Enterprise-grade, RHEL-based             |
| **Fedora**  | Cutting-edge features, Red Hat sponsored |
| **RedHat**  | Enterprise-focused, commercial support   |

---

## Q3. Define the basic components of Linux.

Majorly there are **five basic components** of Linux:

| Component              | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| **Kernel**             | Core part of the OS; works as a bridge between hardware and software.       |
| **Shell**              | An interface between the kernel and the user.                               |
| **GUI**                | Graphical User Interface — offers different ways to interact with the system. |
| **Application Programs** | Designed to perform a bundle of tasks through a bundle of functions.      |
| **System Utilities**   | Software functions through which users manage the system.                   |

---

## Q4. What is the Linux Kernel? Is it legal to edit it?

- The Linux Kernel is known as a **low-level software system**.
- The Linux kernel **tracks the resources** and provides a user interface.
- This OS is released under **GPL (General Public License)**.
- Hence every project is released under it. So, **you can edit the Linux kernel legally**. ✅

---

## Q5. What is Shell in Linux?

In Linux, **five Shells** are used:

### 1. `csh` — C Shell
```sh
# C Shell — offers job control and spell checking
# Similar to C syntax
csh
```

### 2. `ksh` — Korn Shell
```sh
# A high-level shell for programming languages
ksh
```

### 3. `zsh` — Z Shell
```sh
# Unique features: closing comments, startup files,
# file name generating, and observing logout/login watching
zsh
```

### 4. `bash` — Bourne Again Shell ⭐ (Default)
```sh
# This is the default shell for Linux
bash

# Check current shell
echo $SHELL
```

### 5. `fish` — Friendly Interactive Shell
```sh
# Provides auto-suggestion, web-based configuration, etc.
fish
```

---

## Q6. How do you mount and unmount filesystems in Linux?

You can use the `mount` and `umount` commands.

### 🔼 For Mounting:

**Step 1 — Identify the partition:**
```sh
# Using fdisk
sudo fdisk -l

# OR using lsblk
lsblk
```

**Step 2 — Create the mount point directory:**
```sh
sudo mkdir /mnt/mountpnt
```

**Step 3 — Mount the partition:**
```sh
sudo mount <partition> <mount_point_directory>

# Example:
sudo mount /dev/sdb1 /mnt/mountpnt
```

### 🔽 For Unmounting:

**Check if the filesystem is in use, then unmount:**
```sh
sudo umount <mount_point_directory>

# Example:
sudo umount /mnt/mountpnt
```

---

## Q7. How do you troubleshoot network connectivity issues in Linux?

There are **multiple ways** to troubleshoot network connectivity.

### 🌐 Step 1 — Check Internet Connectivity
```sh
# Check if internet connection is on and cables are properly connected
ping google.com
```

### 🔧 Step 2 — Verify the Network Configuration
```sh
# Check IP address using ip addr
ip addr

# OR using ifconfig
ifconfig

# Check if default gateway is set properly
ip route

# Verify DNS server configuration
cat /etc/resolv.conf
```

### 🔥 Step 3 — Check the Firewall
```sh
# Sometimes firewall rules block internet connection

# Modify firewall rules using ufw
sudo ufw status
sudo ufw allow <port>

# OR using iptables
sudo iptables -L
```

### 🔄 Step 4 — Restart Network Interface
```sh
# Bring network interface down
sudo ifdown <interface>

# Bring network interface up
sudo ifup <interface>

# Finally, reboot the system to apply changes
sudo reboot
```

---

## Q8. How do you list all the processes running in Linux?

You can list the currently running processes in Linux through various commands:

### 📋 `ps` Command
```sh
# Display brief information about running processes
ps

# Full-format listing (-f = full format)
ps -f

# Show all processes (-e = every process)
ps -e

# Detailed list of all processes with user info
ps auxf
```

> `-f` option shows the full-format result, and the `-e` option displays all processes.

### 📊 `top` Command
```sh
# Displays real-time details about system processes
# and complete resource usage
top
```

### 📈 `htop` Command ⭐ (Improved version of top)
```sh
# Improved version of top
# Displays a color-coded list with additional features
# such as sorting, filtering, etc.
htop

# Install htop if not available
sudo apt install htop       # Debian/Ubuntu
sudo yum install htop       # CentOS/RedHat
```

---

---

## Q9. You are unable to do ssh to a node, what could be the problem?

Now just by saying ssh is not happening will not say anything about the problem. It is like saying "I have a pain in my body" but where do you have the pain to be precise? headache? stomach pain? or what else? so you have to narrow it down.

So next would be to ask your interviewer on the exact problem or else we have to jump in and analyze it further.

In such scenarios it is always recommended to get a GUI access of the node as that would not require ssh access and you can directly login to the node and check the respective ssh log to understand the problem.

The ssh log location may vary based on the distribution type:

```sh
/var/log/secure
/var/log/sshd
/var/log/messages
/var/log/auth
```

Next check the kind of error you get and then debug the problem accordingly.

**Most possible scenarios:**

1. Host is not allowed to do ssh to the server
2. A direct root login may not be allowed
3. `AllowUsers` and `AllowGroup` is defined for the target node sshd config and hence the login fails
4. Many times a password-less authentication fails due to incorrect permission of the necessary directory and files like `.ssh`, `authorized_keys` etc — so make sure the permission of these files and directories are not world readable or writable.

```sh
# Check SSH service status
sudo systemctl status sshd

# View SSH logs (varies by distro)
sudo tail -f /var/log/secure        # RHEL/CentOS
sudo tail -f /var/log/auth.log      # Debian/Ubuntu

# Check sshd config
sudo cat /etc/ssh/sshd_config | grep -E "AllowUsers|AllowGroups|PermitRootLogin"

# Fix permissions on .ssh directory and files
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

---

## Q10. Suppose you have Linux box with IP "192.168.10.11", and you are able to ssh this node using another Linux box which has IP "192.168.10.12", BUT you are unable to connect to that node from another Windows Box having IP "192.169.10.29", what could be the problem?

These mostly happen because of **IP routing issues**. Here most likely **gateway is missing in 192.168.10.12** as to connect to a node a gateway connectivity is needed while for nodes within the same subnet can still connect to each other. A simple ping test and traceroute can give more hint of the situation.

```sh
# Ping test from Windows Box to Linux node
ping 192.168.10.11

# Traceroute to find where the routing breaks
tracert 192.168.10.11          # Windows
traceroute 192.168.10.11       # Linux

# Check routing table on the Linux box
ip route show

# Check if gateway is set
ip route | grep default
```

> **Note:** The Windows box (192.169.10.29) is on a **different subnet** (192.169.x.x) compared to Linux boxes (192.168.x.x), so a gateway/router is needed to route traffic between subnets.

---

## Q11. By default when I create a user I see that the default shell assigned is /bin/bash and the default home directory which is assigned is under /home. How can I make sure that next time I user "useradd", the default assigned shell is ksh and default home directory of user is /export/home/\<username\>

`useradd` takes default arguments from `/etc/default/useradd`:

```sh
# View current useradd defaults
cat /etc/default/useradd
```

Default file content:
```sh
GROUP=100
HOME=/home
INACTIVE=-1
EXPIRE=
SHELL=/bin/bash
SKEL=/etc/skel
CREATE_MAIL_SPOOL=yes
```

So either you can use additional arguments with `useradd` to make sure your home directory is `/export/home` or else you can modify the above file so that without any additional argument the home directory will be `/export/home`:

```sh
# Option 1 — Pass arguments directly with useradd
sudo useradd -s /bin/ksh -d /export/home/<username> <username>

# Option 2 — Modify /etc/default/useradd permanently
sudo vi /etc/default/useradd
# Change these two lines:
# HOME=/export/home
# SHELL=/bin/ksh

# Verify the change
useradd -D
```

---

## Q12. I created a password-less authentication between two linux box but still every time I try to ssh, it still prompts me for a password. What wrong could I have done? What should I check?

Assuming private and public key were successfully created:

**1.** Make sure the public key you generated is the same as what is copied to the target node's authorized key file. In such cases always prefer to use `ssh-copy-id` rather than manually copying the public key to the client node.

```sh
# Use ssh-copy-id to copy public key (recommended)
ssh-copy-id user@target-node

# OR manually verify the key matches
cat ~/.ssh/id_rsa.pub
# Compare with target node:
cat ~/.ssh/authorized_keys
```

**2.** The permission of `.ssh` directory, the generated keys and authorized keys must not be world readable, writable or executable:

```sh
# Fix permissions on source machine
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Fix permissions on target machine
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

**3.** Analyse the logs which contain logs for ssh as the error that appears will help debug further:

```sh
sudo tail -f /var/log/sshd
sudo tail -f /var/log/secure
sudo tail -f /var/log/messages
```

---

## Q13. While attempting to do su (switch user) from one user to another user I get an error message "Authentication failure" and the su fails even when I know I am giving the correct password, what could be the possible reason?

In general **"Authentication Failure"** means the password provided is not matching the password stored in `/etc/shadow` for the user. But there can be many other reasons for this error since you know that you are entering the correct password.

Now if you have ssh access with root then well and good as you can go through the logs to understand more about the problem.

But if `su --root` is failing then we may be in a problem, as a root level authentication is needed or another user which has similar privilege. If not then follow the steps to reset the root password.

But assuming you have root level access then you can use `pam_tally2` or `faillock` to see if the user is locked for some reason. If a user is locked due to failed attempts then we need to reset the account:

```sh
# Reset locked user using faillock
faillock --reset --user username

# Reset locked user using pam_tally2
pam_tally2 --reset --user username

# Check user account status
passwd -S username

# Unlock a locked user account
passwd -u username

# Check /etc/shadow for account status
sudo grep username /etc/shadow
```

---

## Q14. You receive a notification that the disk space on your Linux server is critically low. What steps would you take to address this issue?

Firstly, I would identify which directories or files are consuming the most space using commands like `du -sh *` or `df -h`. Then, I would investigate if there are any unnecessary files or logs that can be safely deleted. Additionally, I might consider compressing large files or moving them to another storage location. If needed, I would also resize the disk or add more storage capacity.

```sh
# Check overall disk usage
df -h

# Find top space-consuming directories
du -sh /* 2>/dev/null | sort -rh | head -20

# Find large files
find / -type f -size +100M 2>/dev/null

# Check and clean old logs
sudo journalctl --disk-usage
sudo journalctl --vacuum-size=500M

# Remove unnecessary packages (Debian/Ubuntu)
sudo apt autoremove
sudo apt clean

# Remove unnecessary packages (RHEL/CentOS)
sudo yum autoremove
sudo yum clean all

# Compress large files
gzip largefile.log

# Check inode usage (another cause of "disk full")
df -i
```

---

## Q15. Your Linux server is experiencing high CPU usage, causing performance issues. How would you troubleshoot and mitigate this problem?

I would start by identifying the processes or services consuming the most CPU resources using tools like `top` or `htop`. Once identified, I would assess if these processes are essential or if they can be optimized or terminated. If necessary, I might adjust process priorities, optimize code, or scale resources horizontally by distributing workload across multiple servers using load balancing.

```sh
# Real-time CPU usage monitoring
top

# Interactive, color-coded process monitor
htop

# Check CPU usage per process (snapshot)
ps aux --sort=-%cpu | head -20

# Check system load average
uptime

# Get detailed CPU info
lscpu

# Adjust process priority (nice value: -20 highest, 19 lowest)
renice +10 -p <PID>

# Kill a high-CPU process
kill -9 <PID>

# Check per-core CPU usage
mpstat -P ALL 1

# Monitor CPU usage over time
sar -u 1 10
```

---

## Q16. A critical application hosted on your Linux server is not responding. How would you diagnose and resolve the issue?

Firstly, I would check the application logs and system logs (`/var/log/`) to identify any errors or warnings. Then, I would verify if the necessary services (e.g., web server, database) are running using commands like `systemctl status`. If the issue persists, I would check network connectivity, firewall rules, and port availability. Additionally, I might restart the application service or perform a graceful shutdown and startup.

```sh
# Check application and system logs
sudo tail -f /var/log/syslog          # Debian/Ubuntu
sudo tail -f /var/log/messages        # RHEL/CentOS
ls /var/log/                          # List all log files

# Check if required services are running
sudo systemctl status nginx           # Web server
sudo systemctl status mysql           # Database
sudo systemctl status <app-service>   # Application service

# Restart a service
sudo systemctl restart <service-name>

# Graceful shutdown and startup
sudo systemctl stop <service-name>
sudo systemctl start <service-name>

# Check network connectivity
ping <hostname-or-ip>
curl -I http://localhost:<port>

# Check if port is open and listening
sudo ss -tlnp | grep <port>
sudo netstat -tulnp | grep <port>

# Check firewall rules
sudo ufw status
sudo iptables -L -n

# Check for OOM (Out of Memory) kills in logs
sudo dmesg | grep -i "killed process"
```

---

## Q17. Your Linux server is vulnerable to a known security exploit. How would you apply patches and ensure the server's security?

I would first identify the specific vulnerability and check if there are any available patches or updates from the Linux distribution's package manager (`apt`, `yum`, `zypper`, etc.). Then, I would schedule a maintenance window to apply the patches, ensuring minimal disruption to services. Before applying the patches, I would take a backup of critical data and configurations. After applying the patches, I would verify the system's integrity and perform security assessments to ensure that the vulnerability has been addressed effectively.

```sh
# ----------- Debian / Ubuntu -----------
# Check for available updates
sudo apt update
sudo apt list --upgradable

# Apply security patches only
sudo apt-get upgrade

# Apply all updates
sudo apt-get dist-upgrade

# ----------- RHEL / CentOS -----------
# Check for available updates
sudo yum check-update

# Apply security patches only
sudo yum update --security

# Apply all updates
sudo yum update

# ----------- openSUSE / SLES -----------
sudo zypper refresh
sudo zypper patch

# ----------- Backup before patching -----------
# Backup config files
sudo tar -czvf /backup/etc_backup_$(date +%F).tar.gz /etc

# Create EBS/disk snapshot (AWS/cloud) before patching

# ----------- Post-patch verification -----------
# Verify patch applied
rpm -q --changelog <package-name>     # RHEL/CentOS
dpkg -l | grep <package-name>         # Debian/Ubuntu

# Run security audit
sudo lynis audit system

# Check for open vulnerabilities
sudo openscap
```

---

## 📌 Quick Reference Cheat Sheet

| Topic                        | Command / Tool                                      |
|------------------------------|-----------------------------------------------------|
| Check shell                  | `echo $SHELL`                                       |
| List partitions              | `sudo fdisk -l` / `lsblk`                          |
| Mount filesystem             | `sudo mount <partition> <mountpoint>`               |
| Unmount filesystem           | `sudo umount <mountpoint>`                          |
| Check IP                     | `ip addr` / `ifconfig`                             |
| Check routing                | `ip route`                                          |
| DNS config                   | `cat /etc/resolv.conf`                              |
| Firewall rules               | `ufw status` / `iptables -L`                       |
| List processes               | `ps auxf` / `top` / `htop`                         |
| SSH logs                     | `/var/log/secure` / `/var/log/auth.log`            |
| Fix SSH permissions          | `chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys` |
| Copy SSH key                 | `ssh-copy-id user@host`                            |
| Check disk usage             | `df -h` / `du -sh *`                               |
| Reset locked user            | `faillock --reset --user <username>`                |
| useradd defaults             | `cat /etc/default/useradd`                         |
| Check service status         | `systemctl status <service>`                        |
| Restart service              | `systemctl restart <service>`                       |
| Check open ports             | `ss -tlnp` / `netstat -tulnp`                      |
| Apply security patches       | `apt-get upgrade` / `yum update --security`         |
| Adjust process priority      | `renice +10 -p <PID>`                              |
| Traceroute (network debug)   | `traceroute <ip>` / `tracert <ip>` (Windows)       |

---

> 📝 *Notes compiled from Linux interview preparation resources.*