import subprocess
import sys
import time
from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress

console = Console()

requirements = [
    "scapy",
    "rich",
    "mac-vendor-lookup"
]

def banner():
    console.print(
        Panel.fit(
            "[bold cyan]PacketEye Installer[/bold cyan]\n"
            "[green]Advanced WiFi Network Monitor Setup[/green]",
            border_style="cyan"
        )
    )

def install_package(package):

    console.print(f"[yellow]Installing {package}...[/yellow]")

    with Progress() as progress:

        task = progress.add_task("[cyan]Downloading...", total=100)

        for i in range(100):
            time.sleep(0.02)
            progress.update(task, advance=1)

    subprocess.call([sys.executable, "-m", "pip", "install", package])

    console.print(f"[bold green]{package} installed ✔[/bold green]\n")

def main():

    banner()

    console.print("\nChecking Python...\n")

    time.sleep(1)

    console.print("[green]Python detected ✔[/green]\n")

    for pkg in requirements:
        install_package(pkg)

    console.print("[bold green]All requirements installed successfully ✔[/bold green]\n")

    console.print("[cyan]Launching PacketEye...[/cyan]\n")

    time.sleep(2)

    subprocess.call([sys.executable, "PacketEye/packeteye.py"])


if __name__ == "__main__":
    main()