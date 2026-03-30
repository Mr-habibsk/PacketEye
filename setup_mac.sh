#!/bin/bash

clear

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

# Hide cursor
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

echo -e "${MAGENTA}PacketEye macOS Installer${RESET}"
echo ""

sleep 1

# Progress bar
progress_bar() {

for ((i=0;i<=100;i++))
do
    filled=$((i/2))
    empty=$((50-filled))

    bar=$(printf "%0.s█" $(seq 1 $filled))
    space=$(printf "%0.s " $(seq 1 $empty))

    printf "\r${CYAN}[%s%s] %3d%%${RESET}" "$bar" "$space" "$i"

    sleep 0.02
done

printf "\n"
}

# Check Python
echo -e "${CYAN}Checking Python3...${RESET}"

if ! command -v python3 &> /dev/null
then
    echo -e "${RED}Python3 not found! Please install Python first.${RESET}"
    tput cnorm
    exit
fi

echo -e "${GREEN}Python3 detected ✔${RESET}"
echo ""

sleep 1

# Update pip
echo -e "${YELLOW}Updating pip...${RESET}"

python3 -m pip install --upgrade pip > /dev/null 2>&1 &

progress_bar

echo -e "${GREEN}pip updated ✔${RESET}"
echo ""

sleep 1

# Install requirements
echo -e "${YELLOW}Installing dependencies...${RESET}"

python3 -m pip install -r requirements.txt > /dev/null 2>&1 &

progress_bar

if [ $? -eq 0 ]; then
    echo -e "${GREEN}All dependencies installed successfully ✔${RESET}"
else
    echo -e "${RED}Dependency installation failed${RESET}"
    tput cnorm
    exit
fi

sleep 1

echo ""
echo -e "${CYAN}Launching PacketEye...${RESET}"

sleep 2

# Show cursor again
tput cnorm

python3 PacketEye/packeteye.py