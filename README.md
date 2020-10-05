# Docker for Pentesters
## Project Name: Nightingale
==================================================
## Docker for Pentesters: Pentesting Framework 

### Description
This Docker image contain some usefull tools that are highly required for penetration testing and which is platform independent.

### List of tools use in this framework
- WpScan
- Sqlmap
- Dirb
- nmap
- Metasploit Framework
- Impacket Toolkit for Red Teamers
- more to go.....

## Docker Image build and Run 
- Take a clone of the repository
```
git clone https://github.com/RAJANAGORI/Nightingale.git
```
- Change the Directory
```
cd Nightingale
```
- Now build the Docker Image.
```
docker build -t Nightingale .
```
- After Creating the Docker Image, Login into the image and Happy Hacking.... ;-)
```
docker run -ti Nightingale /bin/bash
```
## Refrence 
- https://github.com/phocean/dockerfile-msf.git
- https://github.com/c0dejump/HawkScan.git
- https://github.com/1N3/Sn1per.git



Please free to contribute 