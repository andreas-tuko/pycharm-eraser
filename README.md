# pycharm-eraser

A comprehensive automation toolkit for managing PyCharm installations and completely removing all traces of PyCharm from your system, including trial/evaluation data and JetBrains tracking mechanisms.

## Overview

This project provides two essential bash scripts for PyCharm management on Linux systems:

- **`install_pycharm.sh`** - Automates the installation of PyCharm from a `.tar.gz` archive
- **`remove_pycharm.sh`** - Performs a complete removal of PyCharm and all associated data

## Features

### Installation Script (`install_pycharm.sh`)
- ✅ Automated extraction of PyCharm archives to `/opt`
- ✅ Intelligent detection of PyCharm executables
- ✅ Desktop entry creation for system integration
- ✅ Desktop shortcut creation for quick access
- ✅ Proper permission handling with sudo
- ✅ Works with any PyCharm version in `.tar.gz` format

### Removal Script (`remove_pycharm.sh`)
- 🧹 Complete removal of PyCharm installations from `/opt`, `/usr/local`
- 🧹 Deletion of all desktop shortcuts and entries
- 🧹 Purge of configuration files (~/.config/JetBrains)
- 🧹 Removal of cache and temporary files (~/.cache/JetBrains)
- 🧹 Complete trial/evaluation reset
- 🧹 Removal of license records and device tracking data
- 🧹 Comprehensive cleanup of all JetBrains hidden data

## System Requirements

### Tested & Verified On:
- **Operating System**: Zorin OS (Latest Version) / Ubuntu 20.04+
- **PyCharm Version**: pycharm-2025.2.5.tar.gz
- **Architecture**: Linux x86_64
- **Privileges**: Root/sudo access required

### Prerequisites:
- Bash shell
- `tar` command-line utility
- `find` and `ls` utilities
- Sudo privileges for installation/removal

## Installation

### Step 1: Download PyCharm

1. Visit [JetBrains PyCharm Download Page](https://www.jetbrains.com/pycharm/download/)
2. Download the Linux `.tar.gz` version (not the snap/flatpak versions)
3. Save it to a working directory

### Step 2: Prepare the Installation Script

```bash
cd /path/to/your/downloads
# Place install_pycharm.sh in the same directory as pycharm-*.tar.gz
```

### Step 3: Run the Installation

```bash
# Make the script executable
chmod +x install_pycharm.sh

# Run with sudo (required for /opt access)
sudo ./install_pycharm.sh
```

The script will:
1. Locate the `pycharm-*.tar.gz` file automatically
2. Extract it to `/opt`
3. Create desktop entries for system integration
4. Create desktop shortcuts in your home directory

### Step 4: Launch PyCharm

After successful installation, PyCharm will be available:
- Via desktop shortcut
- From your application menu
- Command line: `/opt/pycharm-<version>/bin/pycharm`

## Removal

### Complete Uninstallation

```bash
# Make the script executable
chmod +x remove_pycharm.sh

# Run the removal script
./remove_pycharm.sh
```

### What Gets Removed:
- All PyCharm installations in `/opt` and `/usr/local`
- Desktop shortcuts and application entries
- Configuration: `~/.config/JetBrains/PyCharm*`
- Cache: `~/.cache/JetBrains/PyCharm*`
- User data: `~/.local/share/JetBrains/PyCharm*`
- Trial/evaluation records
- JetBrains device tracking data
- License files and consent records

## Usage Examples

### Install PyCharm Community Edition

```bash
# Download pycharm-2025.2.5.tar.gz
# Then in the download directory:
cd ~/Downloads
sudo ./install_pycharm.sh
```

### Install PyCharm Professional Edition

```bash
# Download pycharm-professional-2025.2.5.tar.gz
# Then in the download directory:
cd ~/Downloads
sudo ./install_pycharm.sh
```

### Perform Complete Cleanup

```bash
./remove_pycharm.sh
# When prompted, type 'yes' to confirm complete removal
```

## Technical Details

### Installation Directory Structure

After installation, PyCharm is organized as:
```
/opt/pycharm-<version>/
├── bin/
│   ├── pycharm (native binary)
│   ├── pycharm.sh (fallback shell script)
│   └── ...
├── lib/
├── plugins/
└── ...
```

### Configuration Locations

- **User Config**: `~/.config/JetBrains/PyCharm<version>`
- **Cache**: `~/.cache/JetBrains/PyCharm<version>`
- **User Data**: `~/.local/share/JetBrains/PyCharm<version>`
- **Desktop Entries**: `~/.local/share/applications/jetbrains-pycharm*.desktop`

## Troubleshooting

### Installation Issues

**"No pycharm-*.tar.gz file found"**
- Ensure the `.tar.gz` file is in the same directory as `install_pycharm.sh`
- Verify the filename starts with `pycharm-` and ends with `.tar.gz`

**"Permission denied"**
- Use `sudo` when running the installation script
- Ensure you have sudo privileges on your system

**"Could not determine extracted folder"**
- Check `/opt` directory permissions
- Ensure sudo was used during installation

### Removal Issues

**"PyCharm still appears in applications menu"**
- Run the removal script again
- Manually delete remaining desktop entries: `rm ~/.local/share/applications/jetbrains-pycharm*.desktop`

**"Configuration files remain after removal"**
- These are typically safe to delete manually
- User-created project settings will be preserved if needed

## Compatibility

| Component | Version | Status |
|-----------|---------|--------|
| Zorin OS | Latest | ✅ Tested |
| PyCharm | 2025.2.5 | ✅ Tested |
| Ubuntu | 20.04+ | ✅ Compatible |
| Bash | 4.0+ | ✅ Required |

## Security & Privacy

The removal script ensures complete privacy by:
- Removing JetBrains tracking data
- Deleting device ID files
- Clearing evaluation/trial records
- Removing all consent tracking files
- Purging license information

## License

See [LICENSE](LICENSE) file for details.

## Contributing

Contributions, bug reports, and feature requests are welcome!

## Support

For issues or questions:
1. Check the Troubleshooting section above
2. Review the script comments for technical details
3. Ensure you're using the latest version from this repository