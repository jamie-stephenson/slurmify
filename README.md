# Slurmify 🐧⏳

Slurmify is a Debian package that automates the configuration of [Slurm](https://slurm.schedmd.com/overview.html) on an HPC cluster. After installation on your master node, you can run a single command (`slurmify`) to configure all nodes.

## Installation

### 📦 Install from release

1. Download the `.deb` file from this repository's [pre-release](https://github.com/jamie-stephenson/slurmify/releases/tag/v0.1.0-test).
```bash
wget https://github.com/jamie-stephenson/slurmify/releases/download/v0.1.0-test/slurmify_0.1.0_amd64.deb
```
2. Install the package with dpkg:
```bash
sudo dpkg -i slurmify_0.1.0_amd64.deb
```
### 🛠️ Build from source
To build the package yourself:

1. Clone this repository:
```bash
git clone https://github.com/jamie-stephenson/slurmify.git
cd slurmify
```
2. Install packaging tools (if not already installed):
```bash
sudo apt update
sudo apt install -y build-essential debhelper devscripts
```
3. Build the .deb package:
```bash
debuild -us -uc
```
4. Install the package with dpkg (It will be in the parent directory):
```bash
cd ..
sudo dpkg -i slurmify_0.1.0_amd64.deb
```
## 🚀 Usage
Once installed and you have populated [<code style="color: blue; text-decoration: underline;">slurmify.conf</code>](#%EF%B8%8F-configuration), run the primary command with root privileges:

```bash
sudo slurmify [SCRIPT]
```
- `SCRIPT` (optional): A script to run on every node after the cluster configuration finishes.
Example: `slurmify my_env_setup.sh`

## ⚙️ Configuration
The main configuration file is located at `/etc/slurmify/slurmify.conf`. It includes a `[filesystem]` section and multiple `[nodeXX]` sections defining individual cluster nodes. The `[key]` section is used to specify which key to use for passwordless ssh access to the other nodes, which the user must configure themselves.

## 🔍 What `slurmify` does

1. Parses `/etc/slurmify/slurmify.conf` to read the cluster configuration.
2. Mounts a shared filesystem (if configured).
3. Installs Slurm and creates the correct configuration files (e.g., slurm.conf, gres.conf) in /etc/slurmify/slurm/ to reflect your cluster setup.
4. Activates the `slurmctld` and `slurmd` daemons. Note: it does not set up Slurm accounting.
5. Configures worker nodes in parallel (using [GNU Parallel](https://www.gnu.org/software/parallel/)):
6. Runs any supplied script (e.g. environment-setup scripts) across all nodes.

After a system restart, you can verify that Slurm is running by checking the status of services:
```bash
systemctl status munge
systemctl status slurmctld
systemctl status slurmd
```
You can check all nodes and partitions are correctly configured and running with:
```bash
sinfo
```
Use can then `srun`, `salloc`, or `sbatch` for running jobs in the usual Slurm manner.