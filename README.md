![MasterHead](https://media.geeksforgeeks.org/wp-content/uploads/20220906182153/DevOpsEngineerSalary.gif)
<h1 align="center">Hi 👋, I'm Mohammed Affan</h1>
<h3 align="center">Bridging DevOps and the Cloud for Efficiency</h3>
<img align="right" alt="Coding" width="400" src="https://i.pinimg.com/originals/81/17/8b/81178b47a8598f0c81c4799f2cdd4057.gif">

# 💫 About Me:
🔭 I'm currently working on Hands-on with DevOps tools and shaping cloud solutions on Azure and AWS.<br><br>🌱 I'm currently learning Steadily mastering DevOps tools while diving deep into [...]

## 🌐 Socials:
[![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?logo=Instagram&logoColor=white)](https://instagram.com/https://www.instagram.com/affan__raza_2301/) [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://linkedin.com/in/affan-raza-b94b4a288)

# 💻 Tech Stack:
![C](https://img.shields.io/badge/c-%2300599C.svg?style=for-the-badge&logo=c&logoColor=white) ![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white) ![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) ![Bash](https://img.shields.io/badge/bash-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Azure](https://img.shields.io/badge/azure-%230078D4.svg?style=for-the-badge&logo=microsoft-azure&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)

# 📊 GitHub Stats:
![](https://github-readme-stats.vercel.app/api?username=Affan2310&theme=radical&hide_border=false&include_all_commits=true&count_private=true)<br/>
![](https://github-readme-streak-stats.herokuapp.com/?user=Affan2310&theme=radical&hide_border=false)<br/>
![](https://github-readme-stats.vercel.app/api/top-langs/?username=Affan2310&theme=radical&hide_border=false&include_all_commits=true&count_private=true&layout=compact)

## 🏆 GitHub Trophies
![](https://github-profile-trophy.vercel.app/?username=Affan2310&theme=radical&no-frame=false&no-bg=false&margin-w=4)

---

# 🖥️ Projects

## VM Health Check Script 📊

A comprehensive shell script for monitoring and analyzing the health of Ubuntu virtual machines based on CPU, memory, and disk space utilization.

### Quick Overview
- **Purpose**: Monitor VM health with CPU, Memory, and Disk metrics
- **Threshold**: 70% utilization
- **Status**: Healthy (≤70%) or Unhealthy (>70%)
- **Target OS**: Ubuntu 16.04 LTS and later

### Features ✨
- ✅ Real-time CPU, Memory, and Disk monitoring
- ✅ Configurable health thresholds (default: 70%)
- ✅ Color-coded output for easy interpretation
- ✅ `explain` argument for detailed metrics and recommendations
- ✅ Exit code support for automation (0=healthy, 1=unhealthy)
- ✅ Cron-friendly for scheduled monitoring
- ✅ Comprehensive error handling with fallback methods

### Quick Start 🚀

**Installation**:
```bash
# Clone the repository
git clone https://github.com/Affan2310/Affan2310.git
cd Affan2310

# Make script executable
chmod +x vm_health_check.sh

# Run the script
./vm_health_check.sh
```

**Basic Usage**:
```bash
# Quick health check
./vm_health_check.sh

# Detailed health check with recommendations
./vm_health_check.sh explain
```

### Output Examples 📸

**Healthy VM**:
```
✓ VM Health Status: Healthy
```

**Unhealthy VM with Explain**:
```
✗ VM Health Status: Unhealthy

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VM Health Check Details (Threshold: 70%)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CPU Utilization:    45% (NORMAL)
Memory Utilization: 82% (CRITICAL - Above threshold)
Disk Utilization:   91% (CRITICAL - Above threshold)

Recommended Actions:
  • Memory: Review memory-consuming applications...
  • Disk: Clean up unnecessary files...
```

### Scheduling with Cron 🕐

```bash
# Edit crontab
crontab -e

# Run every hour
0 * * * * /path/to/vm_health_check.sh >> /var/log/vm-health.log 2>&1

# Run every 30 minutes with detailed output
*/30 * * * * /path/to/vm_health_check.sh explain >> /var/log/vm-health.log 2>&1
```

### Key Metrics Monitored 📈

| Metric | Method | Threshold | Healthy | Unhealthy |
|--------|--------|-----------|---------|-----------|
| **CPU Usage** | `top -bn1` | ≤70% | ✅ | ❌ |
| **Memory Usage** | `/proc/meminfo` | ≤70% | ✅ | ❌ |
| **Disk Usage** | `df -h /` | ≤70% | ✅ | ❌ |

### Health Status Logic 🔍

```
IF (CPU > 70%) OR (Memory > 70%) OR (Disk > 70%)
    THEN Status = "Unhealthy" ⚠️
ELSE
    Status = "Healthy" ✓
ENDIF
```

### Troubleshooting Issues 🔧

**Permission Denied**:
```bash
chmod +x vm_health_check.sh
```

**Command Not Found** (e.g., top):
```bash
sudo apt update && sudo apt install -y procps
```

**Memory/Disk Issues**:
```bash
free -h              # Check memory
df -h                # Check disk space
du -sh /*            # Find large directories
```

### Integration Examples 🔗

**Email Alert on Unhealthy VM**:
```bash
#!/bin/bash
if ! ./vm_health_check.sh; then
    echo "VM is unhealthy!" | mail -s "Alert" admin@example.com
fi
```

**Check Exit Code**:
```bash
./vm_health_check.sh
if [ $? -eq 0 ]; then
    echo "VM is healthy"
else
    echo "VM needs attention"
fi
```

### Performance 🚀

- **Execution Time**: ~1-1.3 seconds
- **CPU Usage**: <2%
- **Memory Usage**: ~5-10 MB
- **Recommended Frequency**: Every 5-60 minutes

### Full Documentation 📖

For comprehensive documentation, including:
- Detailed setup and installation
- All command-line arguments
- Complete output examples
- Advanced troubleshooting
- Best practices for monitoring
- Integration with monitoring systems
- Performance tracking
- And much more...

👉 **See [VM_HEALTH_CHECK_README.md](./VM_HEALTH_CHECK_README.md)**

---

### ✍️ Random Dev Quote
![](https://quotes-github-readme.vercel.app/api?type=horizontal&theme=radical)

---
[![](https://visitcount.itsvg.in/api?id=Affan2310&icon=0&color=3)](https://visitcount.itsvg.in)

<!-- Proudly created with ❤️ -->
