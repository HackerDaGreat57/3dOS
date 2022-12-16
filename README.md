# 3dOS
This project aims to (eventually) compete with Microsoft Windows. Therefore, I do not trust GitHub, a Microsoft-hosted service, with my code. The repository is located [here](https://gitea.hdg57.eu.org/HackerDaGreat57/3dOS).

## Server Updates (newest to oldest)
**Update 12/15/2022 10:30 PM (PST):** Server down for about 20 minutes to take backup. Will be back shortly. (New update entry will not be added when it's back up.)

-----

**Update 12/12/2022 7:52 PM (PST):** ***Migration of the Gitea server to Raspberry Pi is finished***. Gitea is now being hosted on a shiny new dedicated ARM64 server with double the memory than the old computer did! (The old computer will be used for hosting webpages on my website, surely that can't put too much load on it.)

Sorry for the downtime, but I can assure you this won't happen again for quite a while since I also installed Ubuntu Server 22.04.1 LTS. Let's aim for a month of uptime, at *least* (assuming PG&E is feeling generous).

-----

**Update 12/11/2022 8:58 PM (PST):** I have learned my lesson of always sticking to LTSes on servers. (The arm64 version of postgresql is not available for Kinetic yet.) Gitea will be hosted on older hardware until I finish setting up an older LTS release of Ubuntu (22.04) on my microSD card. Lesson learned, but not the hard way since no data was lost.

Since we'll be using LTSes, server downtime is expected to be minimal from now on. (Excluding power outages. First cluster of donations I get go towards a decent backup battery. You know what, I oughta make a donation map after the first release.)

-----

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
