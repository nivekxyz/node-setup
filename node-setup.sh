#!/bin/bash
VERSION="16.14.2"
INSTALL_DIRECTORY="$HOME/.local/nodejs"
NODE="node-v$VERSION-linux-x64"

# Echo Colors
SUCCESS='\033[0;32m'
FAIL='\033[0;31m'
OFF='\033[0m'

# Download $NODE
if wget --quiet https://nodejs.org/dist/v$VERSION/$NODE.tar.xz
then
    echo -e "${SUCCESS}Successfully downloaded Node $VERSION${OFF}"
else
    echo -e "${FAIL}Failed to download Node $VERSION - Make sure wget is installed and you are connected to the internet${OFF}"
    exit 1
fi

# Check Install Directory
if [ -d $INSTALL_DIRECTORY ]
then
    rm -r $INSTALL_DIRECTORY
    mkdir $INSTALL_DIRECTORY
else
    mkdir $INSTALL_DIRECTORY
fi

# Extract $NODE
if tar -xf $NODE.tar.xz
then
    echo -e "${SUCCESS}Successfully extracted Node $VERSION${OFF}"
else
    echo -e "${FAIL}Failed to extract Node $VERSION${OFF}"
    exit 1
fi

# Copy $NODE To $INSTALL_DIRECTORY
if cp -r $NODE/* $INSTALL_DIRECTORY
then
    echo -e "${SUCCESS}Successfully copied Node $VERSION to $INSTALL_DIRECTORY${OFF}"
    # Clean up installation files
    rm -r $NODE
    rm -r $NODE.tar.xz
else
    echo -e "${FAIL}Failed to copy Node $VERSION to $INSTALL_DIRECTORY${OFF}"
    exit 1
fi

# Check .local/bin
if [ ! -d $HOME/.local/bin ]
then
    mkdir $HOME/.local/bin
fi

# Link Binaries
if ln -sf $INSTALL_DIRECTORY/bin/* $HOME/.local/bin/
then
    echo -e "${SUCCESS}Successfully linked Node $VERSION binaries to $HOME/.local/bin${OFF}"
else
    echo -e "${FAIL}Failed to link Node $VERSION binaries to $HOME/.local/bin${OFF}"
fi

# Check PATH
if [[ $PATH == *"$HOME/.local/bin"* || $PATH == *"~/.local/bin"* ]]
then
    echo -e "${SUCCESS}Successfully verified PATH.${OFF}"
else
    if echo PATH=$PATH:$HOME/.local/bin >> ~/.profile
    then
        echo -e "${SUCCESS}Successfully added $HOME/.local/bin to PATH in $HOME/.profile you need to source ~/.profile or restart your shell${OFF}"
    else
        echo -e "${FAIL}Failed to add $HOME/.local/bin to PATH in $HOME/.profile${OFF}"
    fi
fi