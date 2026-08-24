# <img width="1536" height="1024" alt="Duck-ai-image-2026-08-22-18-57" src="https://github.com/user-attachments/assets/11f8879d-65c7-4768-b5f7-fbcd4b9ee121" />

Shodan en ligne de commande basé sur leurs API


## 🚀 Installation

```
┌─[m0rph3u5@parrot]─[~]
└──╼ $sudo apt install curl nmap metasploit-framework dasel jq
```

## ⚙️ Commande

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./shodan-cli.sh -help
                                                                
      ::::::::  :::    :::  ::::::::   :::::::: 
    :+:    :+: :+:    :+: :+:    :+: :+:    :+: 
   +:+        +:+    +:+ +:+    +:+ +:+         
  +#++:++#++ +#++:++#++ +#+    +:+ +#+          
        +#+ +#+    +#+ +#+    +#+ +#+           
#+#    #+# #+#    #+# #+#    #+# #+#    #+#     
########  ###    ###  ########   ########                                                                 

               by M0rPH3U53

 
Usage: ./shodan-cli.sh COMMAND
 
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
                   ℹ️  Info                  
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
└──╼ $/shodan-cli.sh -ip 9.9.9.9
[+] Info
 
IP: 9.9.9.9
Ports: 443, 8443, 53, 853
 
💾 9.9.9.9 + d'info --> /home/m0rph3u5/Scripts/ShoC/9.9.9.9.json
```

### Nmap

```
┌─[m0rph3u5@parrot]─[~/Scripts/ShoC]
└──╼ $./shodan-cli.sh -nmap 1.1.1.1
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
└──╼ $./shodan-cli.sh -msf 9.9.9.9
[+] 9.9.9.9:443
[+] 9.9.9.9:8443
[+] 9.9.9.9:53
[+] 9.9.9.9:853
```

### Geoping

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./shodan-cli.sh -geoping 8.8.8.8
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
└──╼ $./shodan-cli.sh -ping 1.1.1.1
IP       Ville        Pays  Alive  Min RTT   Avg RTT   Max RTT   Envoyés  Reçus  Perdu
1.1.1.1  Santa Clara  US    true   1.223 ms  1.737 ms  2.342 ms  3        3      0.0%
```
