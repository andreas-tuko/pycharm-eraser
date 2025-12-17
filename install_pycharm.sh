#!/usr/bin/env bash
# Automated Installer for PyCharm (.tar.gz) on Zorin OS / Ubuntu
# Usage: sudo ./install_pycharm.sh

set -e # Exit immediately if a command exits with a non-zero status

# --- 1. Locate the Tarball ---
echo "🔍 Looking for PyCharm tar.gz file..."
# Finds the file starting with 'pycharm-' and ending in '.tar.gz' in the current directory
TAR_FILE=$(find . -maxdepth 1 -name "pycharm-*.tar.gz" | head -n 1)

if [ -z "$TAR_FILE" ]; then
    echo "❌ Error: No 'pycharm-*.tar.gz' file found in the current directory."
    echo "   Please place this script in the same folder as your download."
    exit 1
fi

echo "✅ Found: $TAR_FILE"

# --- 2. Extract to /opt ---
INSTALL_DIR="/opt"
echo "📦 Extracting to $INSTALL_DIR (requires sudo password)..."

# Create /opt if it doesn't exist (rare, but safe)
if [ ! -d "$INSTALL_DIR" ]; then
    sudo mkdir -p "$INSTALL_DIR"
fi

# Extract the archive
sudo tar -xzf "$TAR_FILE" -C "$INSTALL_DIR"

# Identify the newly created directory name (e.g., pycharm-2025.2.4)
# We sort by time to get the most recently created folder in /opt matching 'pycharm-*'
EXTRACTED_FOLDER=$(ls -td "$INSTALL_DIR"/pycharm-* | head -n 1)

if [ -z "$EXTRACTED_FOLDER" ]; then
    echo "❌ Error: Could not determine the extracted folder path."
    exit 1
fi

echo "✅ Extracted to: $EXTRACTED_FOLDER"

# --- 3. Setup Native Launcher ---
BIN_DIR="$EXTRACTED_FOLDER/bin"
# Check for the native binary 'pycharm' first, fallback to 'pycharm.sh' if missing
if [ -f "$BIN_DIR/pycharm" ]; then
    EXEC_PATH="$BIN_DIR/pycharm"
else
    EXEC_PATH="$BIN_DIR/pycharm.sh"
fi

# Locate the icon
ICON_PATH=$(find "$BIN_DIR" -name "pycharm.svg" -o -name "pycharm.png" | head -n 1)

echo "   > Executable: $EXEC_PATH"
echo "   > Icon: $ICON_PATH"

# --- 4. Create Desktop Entry ---
DESKTOP_FILE="/usr/share/applications/jetbrains-pycharm.desktop"
echo "📝 Creating Desktop Entry at $DESKTOP_FILE..."

# Write the .desktop file content
sudo bash -c "cat > $DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm
Icon=$ICON_PATH
Exec="$EXEC_PATH" %f
Comment=The Python IDE for Professional Developers
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm
EOF

# Update permissions
sudo chmod 644 $DESKTOP_FILE

echo "-------------------------------------------------------"
echo "🎉 Installation Complete!"
echo "   You can now launch PyCharm from your Zorin OS menu."
echo "-------------------------------------------------------"
