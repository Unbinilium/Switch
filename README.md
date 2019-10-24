## A light PowerShell script for you to change DNS on Windows

## Switch Features
- **Automatically** choose DNS and sort DNS by latency
- **Set DNS by Well-Known DNS providers** by just entering their names
- **Set custom DNS manually** by entering its IP Addresses
- Fully **written in PowerShell** and no other dependencies required

## System Requirements
- Windows 10 1709 Professional with PowerShell 3.0 Later

## Notice
- Only IPv4 DNS address family supported, using IPv6 or DNS over TLS/HTTPS may cause error
- Do not input same DNS provider and custom DNS to avoid use one DNS repeatedly
- TEMP file geneated in `~\AppData\Local\Temp\tmp*.tmp` and cleaned up after the operation
- DNS providers number is limited, enter too many would cause error
- Using flexible words match so that make sure DNS provider you entered is standalone to avoid cause error
- Modifying DNS provider also requires each record is standalone

## Start
Please **Download Switch** from the link below directly to your PC and **run Switch using PowerShell by Administrator**, follow the steps displayed on the screen.
```
https://raw.githubusercontent.com/Unbinilium/Switch/master/switch.ps1
```

## Useage
When specializing the DNS provider, you can input mutiple DNS provider's name **spilted by space ' '**, like the example below:
```
Google Cloudflare
```
Also it matches with **no case sensitive** so it's normally ok to input like this(That's not always stable, please review notice):
```
gOoGle ClOuDflAre
gOoGLe 1.1.
Goog 1.0
```
You can input `Custom` as a provider that allows you to set some **customized** DNS servers, you can **only type** `Custom` in DNS providers to use the DNS server only your specialized, or example below means **append** your custom DNS server to DNS provider `Google`:
```
gOoGle Custom
```
**Custom DNS server address should be formatted**, when input multiple address they shoud be divided by ',' like this:
```
9.9.9.9,117.50.22.22
```
If you want to **restore the DNS settings to default** or just use the DNS server form DHCP broadcast, you can type `Default` in DNS providers.

**Modifying DNS provider is not recommended**, it stored with **Base64 encoded** with encoding `UTF-8 CRLF` in the variable named `$DNS_List`. The decoded Base64 will be like this following the **structure** `#DNS provider's name/"DNS provider's address1","DNS provider's address2"`:
```
#114DNS/"114.114.114.114","114.114.115.115"
#Google/"8.8.8.8","8.8.4.4"
#Cloudflare/"1.1.1.1","1.0.0.1"
#Aliyun/"223.5.5.5","223.6.6.6"
#CNNIC/"1.2.4.8","210.2.4.8"
#Baidu/"180.76.76.76"
#Dnspod/"119.29.29.29","182.254.116.116"
#OpenDNS/"208.67.222.222","208.67.220.220"
#Microsoft/"4.2.2.1","4.2.2.2"
#Custom/
#Default/
```
The opration custom and restore to default are generally defined in the end of this file.

## Author & Acknowledge
Switch DNS Modifier Written by <a href="https://github.com/Unbinilium" target="_blank">Unbinilium</a>
