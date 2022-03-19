# Node Setup
Install Node.js or quickly change versions for the local user.

# Installation
Clone this repo and run the node-setup.sh script to install version 16.14.2.

## Change Version
Set the `$VERSION` variable to your desired node version and run the script again.

# Troubleshooting
Having issues? Check the script's output for clues and see below.

## PATH
Since this script installs Node.js locally, it links the binaries to `$HOME/.local/bin`. If that directory wasn't in the PATH the script will add `PATH=$PATH:$HOME/.local/bin` to `$HOME/.profile`.

You will need to restart your terminal emulator or source that file.

`source ~/.profile`