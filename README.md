# 3dOS
This project aims to (eventually) compete with Microsoft Windows. Therefore, I do not trust GitHub, a Microsoft-hosted service, with my code. ~~The repository is located [here](https://gitea.hdg57.eu.org/HackerDaGreat57/3dOS).~~

## Server Updates (newest to oldest)
**Update 12/11/2022 8:58 PM (PST):** I have learned my lesson of always sticking to LTSes. The server will be offline until Ubuntu gets postgresql support for kinetic on arm64. Next time an LTS rolls around I'll be staying at that for a while.

**Update 12/10/2022 1:06 PM (PST):** Gitea is now running on a different but still old server. I got a free domain on https://nic.eu.org/ and connected it to Cloudflare, and now I'm hosting my server without port forwarding via a Cloudflare Tunnel. *Security above all else!*

Gitea will be fully migrated to a local Raspberry Pi 4 8GB (connected to GbE) sitting on my desk by Wednesday, if not by Monday night. (SD card shipments take time, OK?!) Apparently Scythe had trouble setting up a sandbox on their server 😕

-----

**Update 12/9/2022 11:15 AM (PST):** The new server is nearly ready... probably will be up by 10 PM today. Upgrades list:  
1. 512GB HDD --> ~450GB SSD (space reduction is payback for the speed)  
2. 4GB DDR4 --> 16GB DDR5  
3. Intel Core i3-2120 --> *Unknown CPU but definitely better*  
4. ngrok --> port forwarded :)  
(this one's hosted by another person who wants to help this project progress. Thanks Scythe! The old server is now working as a [SheepIt render node](https://www.sheepit-renderfarm.com/user/HackerDaGreat57/profile).)

-----

**Update 12/2/2022 3:56 PM (PST):** Since there was a power outage anyway, the server has temporarily gone down for maintenence. I am also working on making it properly port-forwarded instead of using ngrok. *All server data is safe and uncorrupted.*
