import scapy.all as scapy
import socket
import time
import subprocess
from rich.console import Console
from rich.table import Table
from rich.panel import Panel
from rich.tree import Tree
from mac_vendor_lookup import MacLookup

console = Console()
lookup = MacLookup()

def banner():

    console.print(
        Panel.fit(
            "[bold cyan]"
            "██████╗  █████╗  ██████╗██╗  ██╗███████╗████████╗███████╗██╗   ██╗███████╗\n"
            "██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝╚══██╔══╝██╔════╝╚██╗ ██╔╝██╔════╝\n"
            "██████╔╝███████║██║     █████╔╝ █████╗     ██║   █████╗   ╚████╔╝ █████╗  \n"
            "██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══╝     ██║   ██╔══╝    ╚██╔╝  ██╔══╝  \n"
            "██║     ██║  ██║╚██████╗██║  ██╗███████╗   ██║   ███████╗   ██║   ███████╗\n"
            "╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝\n"
            "[/bold cyan]\n"
            "[green]Advanced WiFi Network Monitor[/green]\n"
            "[yellow]Device Scan • Activity • Network Map[/yellow]",
            border_style="cyan"
        )
    )

# def banner2():

#     console.print(
#         Panel.fit(
#             "[bold cyan]Advanced WiFi Network Monitor[/bold cyan]\n"
#             "[green]Device Scan • Activity • Network Map[/green]",
#             border_style="cyan"
#         )
#     )

def get_network():

    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)

    base = ip.rsplit(".",1)[0]

    return base + ".0/24"

def get_hostname(ip):

    try:
        return socket.gethostbyaddr(ip)[0]
    except:
        return "Unknown"

def get_vendor(mac):

    try:
        return lookup.lookup(mac)
    except:
        return "Unknown"

def ping_latency(ip):

    try:

        output = subprocess.check_output(
            ["ping","-n","1",ip],
            stderr=subprocess.DEVNULL
        ).decode()

        if "Average" in output:
            return "Active"

        return "Idle"

    except:
        return "Unknown"

def scan(network):

    arp = scapy.ARP(pdst=network)
    ether = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")

    packet = ether/arp

    result = scapy.srp(packet, timeout=2, verbose=False)[0]

    devices = []

    for sent, received in result:

        ip = received.psrc
        mac = received.hwsrc

        name = get_hostname(ip)
        vendor = get_vendor(mac)

        activity = ping_latency(ip)

        devices.append({
            "ip": ip,
            "mac": mac,
            "name": name,
            "vendor": vendor,
            "activity": activity
        })

    return devices

def show_table(devices):

    table = Table(title="Devices On Your WiFi")

    table.add_column("IP", style="cyan")
    table.add_column("MAC")
    table.add_column("Device Name")
    table.add_column("Vendor")
    table.add_column("Activity")

    for d in devices:

        table.add_row(
            d["ip"],
            d["mac"],
            d["name"],
            d["vendor"],
            d["activity"]
        )

    console.print(table)

def network_map(devices):

    tree = Tree("🌐 Network")

    for d in devices:

        label = f"{d['name']} ({d['ip']})"

        tree.add(label)

    console.print("\n[bold cyan]Live Network Map[/bold cyan]\n")

    console.print(tree)

def monitor(network):

    while True:

        console.clear()

        banner()

        # banner2()

        console.print(f"\nScanning network: [yellow]{network}[/yellow]\n")

        devices = scan(network)

        show_table(devices)

        network_map(devices)

        console.print("\nRefreshing in 10 seconds...\n")

        time.sleep(10)

def main():

    network = get_network()

    monitor(network)

if __name__ == "__main__":
    main()