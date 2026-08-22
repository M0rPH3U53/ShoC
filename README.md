# ShoC
Shodan en ligne de commande basé sur leurs API


## 🚀 Installation

```
┌─[m0rph3u5@parrot]─[~]
└──╼ $sudo apt install curl nmap metasploit-framework miller dasel
```

## 👁️ Demo

```
┌─[m0rph3u5@parrot]─[~/Scripts]
└──╼ $./shodan-cli.sh -help
                                                                
      ::::::::  :::    :::  ::::::::  :::::::::      :::     ::::    :::    
    :+:    :+: :+:    :+: :+:    :+: :+:    :+:   :+: :+:   :+:+:   :+:     
   +:+        +:+    +:+ +:+    +:+ +:+    +:+  +:+   +:+  :+:+:+  +:+      
  +#++:++#++ +#++:++#++ +#+    +:+ +#+    +:+ +#++:++#++: +#+ +:+ +#+       
        +#+ +#+    +#+ +#+    +#+ +#+    +#+ +#+     +#+ +#+  +#+#+#        
#+#    #+# #+#    #+# #+#    #+# #+#    #+# #+#     #+# #+#   #+#+#         
########  ###    ###  ########  #########  ###     ### ###    ####                                                            

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
 
   -ip         Recherche détails du service
   -msf        Utilise module metasploit
   -nmap       Utilise script nmap
   -ping       Ping classique
   -geoping    Ping IP shodan
 
─────────────────────────────────────────────────
                   🌐 Domaine                  
─────────────────────────────────────────────────
 
   -reverse    Recherche DNS inversée
   -resolve    Recherche DNS
   -domain     Recherche sous-domaine
   -dns        DNSlookup classique
   -geodns     Recherche DNS shodan
 
─────────────────────────────────────────────────
                   ℹ️ Info                  
─────────────────────────────────────────────────

   -help       Affiche les commandes
   -myip       Affiche l'IP publique
   -status     Info du compte
   -api-info   Info API
 
─────────────────────────────────────────────────
```
