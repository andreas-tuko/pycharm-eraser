#!/usr/bin/env bash
# NUCLEAR OPTION: Complete PyCharm Removal + Trial Reset
# This removes EVERYTHING including hidden tracking data

echo "════════════════════════════════════════════════════════"
echo "⚠️  COMPLETE PYCHARM WIPE - NUCLEAR OPTION"
echo "════════════════════════════════════════════════════════"
echo "This will remove:"
echo "  • All PyCharm installations"
echo "  • All configuration files"
echo "  • All cache and logs"
echo "  • JetBrains device/trial tracking data"
echo "  • Evaluation keys and license records"
echo "  • ALL hidden tracking mechanisms"
echo ""
read -p "⚠️  Proceed with COMPLETE wipe? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "🧹 Starting complete removal..."

# 1. Remove Installation Files
echo "→ Removing PyCharm binaries..."
sudo rm -rf /opt/pycharm* 2>/dev/null
sudo rm -rf /opt/PyCharm* 2>/dev/null
sudo rm -rf /usr/local/pycharm* 2>/dev/null

# 2. Remove ALL Desktop Entries
echo "→ Removing desktop shortcuts..."
rm -f ~/.local/share/applications/jetbrains-pycharm*.desktop 2>/dev/null
rm -f ~/.local/share/applications/pycharm*.desktop 2>/dev/null
rm -f ~/.gnome/apps/jetbrains-pycharm*.desktop 2>/dev/null
sudo rm -f /usr/share/applications/jetbrains-pycharm*.desktop 2>/dev/null
sudo rm -f /usr/share/applications/pycharm*.desktop 2>/dev/null

# 3. Remove Config, Cache, and Data
echo "→ Removing configuration and cache..."
rm -rf ~/.config/JetBrains/PyCharm* 2>/dev/null
rm -rf ~/.cache/JetBrains/PyCharm* 2>/dev/null
rm -rf ~/.local/share/JetBrains/PyCharm* 2>/dev/null
rm -rf ~/Library/Application\ Support/JetBrains/PyCharm* 2>/dev/null  # Just in case

# 4. Remove ALL JetBrains shared data
echo "→ Removing JetBrains shared data..."
rm -rf ~/.config/JetBrains/consentOptions 2>/dev/null
rm -rf ~/.local/share/JetBrains/consentOptions 2>/dev/null
rm -rf ~/.cache/JetBrains 2>/dev/null

# 5. CRITICAL: Remove Java Preferences (Device ID)
echo "→ Removing Java UserPrefs (Device/Machine ID)..."
rm -rf ~/.java/.userPrefs/jetbrains 2>/dev/null
rm -rf ~/.java/.userPrefs/prefs.xml 2>/dev/null

# 6. Remove evaluation/license tracking files
echo "→ Removing evaluation keys and license data..."
rm -f ~/.config/JetBrains/PermanentUserId 2>/dev/null
rm -f ~/.config/JetBrains/PermanentDeviceId 2>/dev/null
rm -rf ~/.local/share/JetBrains/PermanentUserId 2>/dev/null
rm -rf ~/.local/share/JetBrains/PermanentDeviceId 2>/dev/null

# 7. Remove systemd and other service files
echo "→ Removing systemd services..."
rm -f ~/.config/systemd/user/pycharm*.service 2>/dev/null
systemctl --user daemon-reload 2>/dev/null

# 8. Remove logs
echo "→ Removing logs..."
rm -rf ~/.local/share/JetBrains/*/log 2>/dev/null
rm -rf /tmp/pycharm* 2>/dev/null
rm -rf /var/tmp/pycharm* 2>/dev/null

# 9. Clean project .idea folders
echo "→ Cleaning .idea folders from projects..."
find ~/ -maxdepth 4 -name ".idea" -type d -exec rm -rf {} + 2>/dev/null

# 10. Remove any PyCharm-related environment variables from shell configs
echo "→ Checking shell configs for PyCharm variables..."
for config in ~/.bashrc ~/.bash_profile ~/.zshrc ~/.profile; do
    if [ -f "$config" ]; then
        sed -i.bak '/PYCHARM/d' "$config" 2>/dev/null
        sed -i.bak '/pycharm/d' "$config" 2>/dev/null
    fi
done

# 11. Clear any snap installations (if using snap)
if command -v snap &> /dev/null; then
    echo "→ Checking for snap installations..."
    snap list 2>/dev/null | grep -i pycharm && sudo snap remove pycharm --purge 2>/dev/null
fi

# 12. Clear any flatpak installations
if command -v flatpak &> /dev/null; then
    echo "→ Checking for flatpak installations..."
    flatpak list 2>/dev/null | grep -i pycharm && flatpak uninstall --delete-data -y com.jetbrains.PyCharm 2>/dev/null
fi

# 13. Remove recent files references
echo "→ Clearing recent files..."
rm -f ~/.local/share/recently-used.xbel.bak 2>/dev/null
if [ -f ~/.local/share/recently-used.xbel ]; then
    sed -i.bak '/pycharm/Id' ~/.local/share/recently-used.xbel 2>/dev/null
fi

# 14. Clear XDG menu cache
echo "→ Updating menu cache..."
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database ~/.local/share/applications 2>/dev/null
    sudo update-desktop-database /usr/share/applications 2>/dev/null
fi

# 15. Remove any remaining JetBrains tracking in tmp
echo "→ Cleaning temporary files..."
sudo rm -rf /tmp/.java_pid* 2>/dev/null
sudo rm -rf /tmp/hsperfdata_* 2>/dev/null

echo ""
echo "════════════════════════════════════════════════════════"
echo "✅ COMPLETE WIPE FINISHED"
echo "════════════════════════════════════════════════════════"
echo "All PyCharm data has been removed."
echo "Your next installation will appear as a fresh machine."
echo ""
echo "💡 TIP: For maximum effectiveness, you may want to:"
echo "   1. Reboot your system"
echo "   2. Clear browser cookies for jetbrains.com"
echo "   3. Install with a different username (if applicable)"
echo "════════════════════════════════════════════════════════"
