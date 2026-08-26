# <img width="1536" height="1024" alt="Duck-ai-image-2026-08-22-18-57" src="https://github.com/user-attachments/assets/11f8879d-65c7-4768-b5f7-fbcd4b9ee121" />

Shodan en ligne de commande basé sur leurs API


| Outils | URL |
| --- | --- | --- |
| <span style="color: #dddddd;">💥</span> Metasploit | https://www.metasploit.com |
| <span style="color: #dddddd;">👁️</span> Nmap | https://nmap.org |
| <span style="color: #dddddd;">🌐</span> curl | https://github.com/curl/curl |

## 🔌 Shodan API

| APIs | Descriptions |
| --- | --- |
| https://cvedb.shodan.io | Permet de vérifier les infos sur les vulnérabilités d’un service |
| --- | --- |
| https://geonet.shodan.io | Utilise des outils réseau à partir de serveurs mondiale |
| --- | --- |
| https://internetdb.shodan.io | Fournit les ports ouvert et vulnérabilités si disponible |
| --- | --- |
| https://developer.shodan.io/api | API shodan par defaut |
| --- | --- |

## 🚀 Installation

```
┌─[m0rph3u5@parrot]─[~]
└──╼ $sudo apt install curl nmap metasploit-framework dasel jq
```

## ⚙️ Commandes

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -help
                                                                
      ::::::::  :::    :::  ::::::::   :::::::: 
    :+:    :+: :+:    :+: :+:    :+: :+:    :+: 
   +:+        +:+    +:+ +:+    +:+ +:+         
  +#++:++#++ +#++:++#++ +#+    +:+ +#+          
        +#+ +#+    +#+ +#+    +#+ +#+           
#+#    #+# #+#    #+# #+#    #+# #+#    #+#     
########  ###    ###  ########   ########                                                                 

               by M0rPH3U53

 
Usage: ./ShoC COMMAND
 
─────────────────────────────────────────────────
                   💀 CVEs                  
─────────────────────────────────────────────────
 
   -vulns      Ports ouverts et CVE
   -search     Cherche les details de CVEs
   -product    Recherche les CVEs par produit
   -news       Liste des CVE récentes
 
─────────────────────────────────────────────────
                   🏠 Host                  
─────────────────────────────────────────────────
 
   -ip         Recherche détails service
   -host       Recherche details service (no api) 
   -nmap       Utilise script nmap
   -msf        Utilise module metasploit
   -ping       Ping classique
   -geoping    Ping IP (shodan)
 
─────────────────────────────────────────────────
                   🌐 Domaine                  
─────────────────────────────────────────────────
 
   -reverse    Recherche DNS inversée
   -resolve    Recherche DNS
   -domain     Recherche sous-domaine
   -dns        DNSlookup classique
   -geodns     Recherche DNS (shodan)
 
─────────────────────────────────────────────────
                   ℹ️ Info                  
─────────────────────────────────────────────────
 
   -myip       Affiche l'IP publique
   -status     Info du compte
   -api-info   Info API
 
─────────────────────────────────────────────────
```

## 👁️ Demo

### IP

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -ip 9.9.9.9
[+] Info
 
IP: 9.9.9.9
Ports: 443, 8443, 53, 853
 
💾 9.9.9.9 + d'info --> /home/m0rph3u5/Scripts/ShoC/9.9.9.9.json
```

### Nmap

```
┌─[m0rph3u5@parrot]─[~/Scripts/ShoC]
└──╼ $./ShoC.sh -nmap 1.1.1.1
[+] 53/tcp --> 
[+] 53/udp --> 
[+] 80/tcp --> CloudFlare
[+] 161/udp --> ciscoSystems
[+] 443/tcp --> CloudFlare
[+] 2052/tcp --> 
[+] 2082/tcp --> 
[+] 2083/tcp --> 
[+] 2086/tcp --> 
[+] 2087/tcp --> 
[+] 8080/tcp --> CloudFlare
[+] 8443/tcp --> 
 
📋 Rapport --> /home/m0rph3u5/Scripts/ShoC/1.1.1.1.csv
```

### Metasploit

```
┌─[m0rph3u5@parrot]─[~/Scripts/ShoC]
└──╼ $./ShoC.sh -msf 9.9.9.9
[+] 9.9.9.9:443
[+] 9.9.9.9:8443
[+] 9.9.9.9:53
[+] 9.9.9.9:853
```

### Geoping

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -geoping 8.8.8.8
IP       Ville              Pays  Alive  Min RTT   Avg RTT   Max RTT   Envoyés  Reçus  Perdu
8.8.8.8  Clifton            US    true   0.993 ms  1.344 ms  2.004 ms  3        3      0.0%
8.8.8.8  Amsterdam          NL    true   0.382 ms  0.836 ms  1.705 ms  3        3      0.0%
8.8.8.8  London             GB    true   1.574 ms  1.932 ms  2.643 ms  3        3      0.0%
8.8.8.8  Frankfurt am Main  DE    true   0.967 ms  1.351 ms  2.014 ms  3        3      0.0%
8.8.8.8  Singapore          SG    true   0.972 ms  1.392 ms  2.21 ms   3        3      0.0%
```

### Ping

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -ping 1.1.1.1
IP       Ville        Pays  Alive  Min RTT   Avg RTT   Max RTT   Envoyés  Reçus  Perdu
1.1.1.1  Santa Clara  US    true   1.223 ms  1.737 ms  2.342 ms  3        3      0.0%
```
### API info

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -api-info
Plan : oss
Crédits scan : 0
Crédits requête : 0
IPs surveillées : 0
HTTPS : false
Telnet : false
Déverrouillé : false
```

### Status

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -status
Menbre : false
Credits : 0
User : test
Display name : null
Créé : 2020-07-02T09:32:24.088000
```

### Myip

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -myip
185.191.239.248
```
### Domain

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -domain google.com
SUBDOMAIN                                                    TYPE  TTL  IP               LAST_SEEN
google.com                                                   A     300  142.250.101.100  2026-08-24T22:49:59.098000
google.com                                                   A     300  142.250.101.101  2026-08-24T22:49:59.098000
google.com                                                   A     300  142.250.101.102  2026-08-24T22:49:59.098000
google.com                                                   A     300  142.250.101.113  2026-08-24T22:49:59.098000
0-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.111.95   2026-07-27T00:57:28.372000
0-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.2.95     2026-08-20T22:23:52.459000
0-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.210.138  2026-08-14T15:54:07.313000
0-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.214.106  2026-08-20T01:09:37.426000
0.client-channel.google.com                                  A     300  142.250.141.189  2026-08-25T10:29:49.304000
0.client-channel.google.com                                  A     300  142.250.142.189  2026-08-24T19:03:02.493000
0.client-channel.google.com                                  A     300  142.251.188.189  2026-08-07T22:04:03.168000
0.client-channel.google.com                                  A     300  142.251.2.189    2026-08-24T22:16:24.962000
preprod-dynamite-gamma-us-signaler-pa.clients6.google.com    A     300  142.251.218.138  2026-08-24T02:49:04.724000
1-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.218.170  2026-08-25T07:05:29.241000
1-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.218.202  2026-08-21T13:18:17.714000
1-preprod-dynamite-gamma-us-signaler-pa.clients6.google.com  A     300  142.251.218.234  2026-08-24T04:15:15.853000
00jhl9.feedproxy.ghs.google.com                              A     300  142.251.41.19    2026-08-18T04:23:28.873000
100jhl9.feedproxy.ghs.google.com                             A     300  142.251.45.19    2026-08-23T01:08:03.625000
100jhl9.feedproxy.ghs.google.com                             A     300  172.253.62.121   2026-08-16T22:15:09.717000
100jhl9.feedproxy.ghs.google.com                             A     300  192.178.142.121  2026-08-24T21:07:12.178000
100jhl9.feedproxy.ghs.google.com                             A     300  74.125.137.121   2026-08-25T01:06:34.634000

```

### Reverse DNS

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./ShoC.sh -reverse 8.8.8.8
8.8.8.8: dns.google
```
