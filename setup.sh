#!/bin/bash

clear

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

# Hide cursor for smooth animation
tput civis

# Banner
echo -e "${CYAN}"
echo "██████╗  █████╗  ██████╗██╗  ██╗███████╗████████╗███████╗██╗   ██╗███████╗"
echo "██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝╚══██╔══╝██╔════╝╚██╗ ██╔╝██╔════╝"
echo "██████╔╝███████║██║     █████╔╝ █████╗     ██║   █████╗   ╚████╔╝ █████╗"
echo "██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══╝     ██║   ██╔══╝    ╚██╔╝  ██╔══╝"
echo "██║     ██║  ██║╚██████╗██║  ██╗███████╗   ██║   ███████╗   ██║   ███████╗"
echo "╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝"
echo -e "${RESET}"

echo -e "${MAGENTA}PacketEye Installer${RESET}"
echo ""

sleep 1

# Progress bar
progress_bar() {

start=$(date +%s)

for ((i=0;i<=100;i++))
do
    filled=$((i/2))
    empty=$((50-filled))

    bar=$(printf "%0.s█" $(seq 1 $filled))
    space=$(printf "%0.s " $(seq 1 $empty))

    now=$(date +%s)
    elapsed=$((now-start))

    printf "\r${CYAN}[%s%s] %3d%% | %ds${RESET}" "$bar" "$space" "$i" "$elapsed"

    sleep 0.02
done

printf "\n"
}

# Install package
install_package() {

pkg=$1

echo -e "${YELLOW}Installing $pkg...${RESET}"

pip install $pkg > /dev/null 2>&1 &

progress_bar

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] $pkg installed successfully${RESET}"
else
    echo -e "${RED}[✘] Failed to install $pkg${RESET}"
fi

echo ""
sleep 1
}

# Python check
echo -e "${CYAN}Checking Python...${RESET}"

python --version > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo -e "${RED}Python not found! Install Python first.${RESET}"
    tput cnorm
    exit
fi

echo -e "${GREEN}Python detected ✔${RESET}"
echo ""

# Install requirements
install_package scapy
install_package rich
install_package mac-vendor-lookup

echo -e "${GREEN}All requirements installed successfully ✔${RESET}"

sleep 2

echo ""
echo -e "${CYAN}Launching PacketEye...${RESET}"

sleep 2

# Show cursor again
tput cnorm

python PacketEye/packeteye.py