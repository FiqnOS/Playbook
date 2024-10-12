@echo off
CD /d %~dp0

devmanview.exe /disable "PCI Data Acquisition and Signal Processing Controller"
devmanview.exe /disable "PCI Encryption/Decryption Controller"
devmanview.exe /disable "PCI Simple Communications Controller"
devmanview.exe /disable "PCI Memory Controller"
devmanview.exe /disable "PCI standard RAM Controller"
devmanview.exe /disable "AURA LED Controller"
devmanview.exe /disable "Intel SMBus"
devmanview.exe /disable "AMD SMBus"
devmanview.exe /disable "Micosoft GS Wavetable Synth"
devmanview.exe /disable "Microsoft Hyper-V Virtualization Infrastructure Driver"
devmanview.exe /disable "Virtual Disk Enumerator (Microsoft)"
devmanview.exe /disable "Enumerator of virtual network adapters NIC"
devmanview.exe /disable "Remote Desktop Device Redirector Bus"
devmanview.exe /disable "Base System Device"
devmanview.exe /disable "Microsoft Kernel Debug Network Adapter"
devmanview.exe /disable "Numeric Data Processor"
devmanview.exe /disable "System Speaker"
devmanview.exe /disable "Microsoft Radio Device Enumeration Bus"
devmanview.exe /disable "Direct memory access controller"
devmanview.exe /disable "Programmable Interrupt Controller"
devmanview.exe /disable "Microsoft RRAS Root Enumerator"
devmanview.exe /disable "Microsoft Device Association Root Enumerator"
devmanview.exe /uninstall "Composite Bus Enumerator"
devmanview.exe /uninstall "NDIS Virtual Network Adapter Enumerator"
devmanview.exe /uninstall "UMBus Root Bus Enumerator"
devmanview.exe /uninstall "Microsoft Virtual Drive Enumerator Driver"
devmanview.exe /uninstall "File as Volume Driver"
sc delete CompositeBus >nul
sc delete NdisVirtualBus >nul
sc delete umbus >nul
