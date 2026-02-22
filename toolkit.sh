#!/bin/bash

clear_screen() {
    clear
    tput clear
    printf "\033c"
    printf "\e[3J"
}

get_local() {
    ip -brief addr show | grep -v "127.0.0.1"
}

get_public() {
    curl -s --max-time 3 https://ifconfig.me
    echo ""
}

run_ping() {
    read -p "Target: " target
    ping -c 4 "$target"
}

run_trace() {
    read -p "Target: " target
    traceroute "$target"
}

run_scan() {
    read -p "IP: " target
    for port in 22 80 443 8080; do
        (timeout 1 bash -c "echo >/dev/tcp/$target/$port") >/dev/null 2>&1 && \
        echo -e "\e[32m[+] $port: OPEN\e[0m" || echo -e "\e[31m[-] $port: CLOSED\e[0m"
    done
}

run_dns() {
    read -p "Domain: " domain
    nslookup "$domain"
}

while true; do
    clear_screen
    echo "===================================="
    echo "      NETWORK TOOLKIT (2026)        "
    echo "===================================="
    echo "1) Local IP"
    echo "2) Public IP"
    echo "3) Ping"
    echo "4) Trace Route"
    echo "5) Port Scan"
    echo "6) DNS Lookup"
    echo "7) Exit"
    echo "===================================="
    read -p "Choice [1-7]: " ch

    case $ch in
        1) clear_screen; get_local ;;
        2) clear_screen; get_public ;;
        3) clear_screen; run_ping ;;
        4) clear_screen; run_trace ;;
        5) clear_screen; run_scan ;;
        6) clear_screen; run_dns ;;
        7) clear_screen; exit 0 ;;
    esac

    echo -e "\nPress Enter..."
    read
done