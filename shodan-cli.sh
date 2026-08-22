#!/bin/bash

# Banniere
ban() {
     cat <<"EOF"
                                                                
      ::::::::  :::    :::  ::::::::  :::::::::      :::     ::::    :::    
    :+:    :+: :+:    :+: :+:    :+: :+:    :+:   :+: :+:   :+:+:   :+:     
   +:+        +:+    +:+ +:+    +:+ +:+    +:+  +:+   +:+  :+:+:+  +:+      
  +#++:++#++ +#++:++#++ +#+    +:+ +#+    +:+ +#++:++#++: +#+ +:+ +#+       
        +#+ +#+    +#+ +#+    +#+ +#+    +#+ +#+     +#+ +#+  +#+#+#        
#+#    #+# #+#    #+# #+#    #+# #+#    #+# #+#     #+# #+#   #+#+#         
########  ###    ###  ########  #########  ###     ### ###    ####                                                            

                         by M0rPH3U53

EOF
}

if [[ "$*" == "-help" ]]; then
     ban
     echo " "
     echo "Usage: ./shodan-cli.sh COMMAND"
     echo " "
     echo "─────────────────────────────────────────────────"
     echo "                   💀 CVEs                  "
     echo "─────────────────────────────────────────────────"
     echo " "
     echo "   -vulns      Ports ouverts et CVE"
     echo "   -search     Cherche les details de CVEs"
     echo "   -product    Recherche les CVEs par produit"
     echo "   -news       Liste des CVE récentes"
     echo " "
     echo "─────────────────────────────────────────────────"
     echo "                   🏠 Host                  "
     echo "─────────────────────────────────────────────────"
     echo " "
     echo "   -ip         Recherche détails du service"
     echo "   -msf        Utilise module metasploit"
     echo "   -nmap       Utilise script nmap"
     echo "   -ping       Ping classique"
     echo "   -geoping    Ping IP mondiale"
     echo " "
     echo "─────────────────────────────────────────────────"
     echo "                   🌐 Domaine                  "
     echo "─────────────────────────────────────────────────"
     echo " "
     echo "   -reverse    Recherche DNS inversée"
     echo "   -resolve    Recherche DNS"
     echo "   -domain     Recherche sous-domaine"
     echo "   -dns        DNSlookup classique"
     echo "   -geodns     Recherche DNS mondiale"
     echo " "
     echo "─────────────────────────────────────────────────"
     echo "                   ℹ️  Info                  "
     echo "─────────────────────────────────────────────────"
     echo " "
     echo "   -help       Affiche les commandes"
     echo "   -myip       Affiche l'IP publique"
     echo "   -status     Info du compte"
     echo "   -api-info   Info API"
     echo " "
     echo "─────────────────────────────────────────────────"
     exit 0
fi

#---------------------------------------------------------- CVE ----------------------------------------------------------#
api_key="YOUR_API"

# Port ouverts & vulenerabilité
if [[ "$*" == "-vulns"* ]]; then
     ipas="$2"
     curl https://internetdb.shodan.io/${ipas} > ${PWD}/${ipas}-vulns.json 2>/dev/null
     echo "💾 Vulns ${ipas} --> ${PWD}/${ipas}-vulns.json"
     dasel -f ${PWD}/${ipas}-vulns.json -r json -w csv | sed 's/\[//g; s/\]//g; s/ /;/g' >"${PWD}/${ipas}-vulns.csv"
fi

# Cherche les cve dans la base shodan
if [[ "$*" == "-search"* ]]; then
     cve="$2"
     curl https://cvedb.shodan.io/cve/${cve} >${PWD}/${cve}.json 2>/dev/null
     echo "[+] CVE found !"
     echo "💾 Info ${cve} --> ${PWD}/${cve}.json"
fi

# Recupere la liste des CVE les plus recente
if [[ "$*" == "-news" ]]; then
     curl https://cvedb.shodan.io/cves >${PWD}/list-cves.json 2>/dev/null
     echo "💾 CVEs récentes --> ${PWD}/list-cves.json"
fi

# Recupere les CVEs par produit
if [[ "$*" == "-product"* ]]; then
     produit="$2"
     curl https://cvedb.shodan.io/cves?product=${produit} >${PWD}/${produit}.json 2>/dev/null
     echo "[+] CVE found !"
     echo "💾 CVEs ${produit} --> ${PWD}/${produit}.json"
fi

#---------------------------------------------------------- Host ----------------------------------------------------------#

# Recupere les info de l'ip
if [[ "$*" == "-ip"* ]]; then

     error=(*'"error"'*)
     ipaddres="$2"
     hostn=$(curl -X GET https://api.shodan.io/shodan/host/${ipaddres}?key=${api_key} 2>/dev/null)

     if [[ ${hostn} == ${error} ]]; then
          echo "[-] No data ${ipaddres} !"
     else
          echo "💾 ${ipaddres} info --> ${PWD}/${ipaddres}.json"
          echo "${hostn}" >"${PWD}/${ipaddres}.json"

     fi
fi

# Script nmap
if [[ "$*" == "-nmap"* ]]; then
     ipadd="$2"
     nmap_ports=$(nmap --script shodan-api --script-args shodan-api.target=${ipadd},shodan-api.apikey=${api_key},shodan-api.outfile=${ipadd}.csv 2>/dev/null)
     clean=$(echo "${nmap_ports}" | grep "^|" | grep -Ev "Shodan|shodan|PORT.*PROTO|_" | sed 's/^| //' | awk '{print "[+] " $1 "/" $2 " --> "$3 $4}')
     echo "${clean}"
     echo " "
     echo "📋 Rapport --> ${PWD}/${ipadd}.csv" 
fi

# Module metasploit
if [[ "$*" == "-msf"* ]]; then
     hote="$2"
     msf_ports=$(msfconsole -q -x "use auxiliary/gather/shodan_host; set RHOSTS ${hote}; set verbose true; set SHODAN_APIKEY ${api_key}; run; exit")
     echo "${msf_ports}" | grep '[+]'
fi

# Ping IP à partir de plusieurs emplacements dans le monde
if [[ "$*" == "-geoping"* ]]; then
     ping_ip="$2"
     curl https://geonet.shodan.io/api/geoping/${ping_ip} >${PWD}/${ping_ip}-geoping.json 2>/dev/null
     mlr --ijson --ocsv cat ${PWD}/${ping_ip}-geoping.json >${PWD}/${ping_ip}-geoping.csv
fi

# Ping classique
if [[ "$*" == "-ping"* ]]; then
     ping="$2"
     curl https://geonet.shodan.io/api/ping/${ping} >${PWD}/${ping}-ping.json 2>/dev/null
     mlr --ijson --ocsv cat ${PWD}/${ping}-ping.json >${PWD}/${ping}-ping.csv
fi

# Recuepre ip publique
if [[ "$*" == "-myip" ]]; then
     my_ip=$(curl -X GET https://api.shodan.io/tools/myip?key=${api_key} 2>/dev/null)
     echo "[+] IP: ${my_ip}"
fi

#---------------------------------------------------------- Info ----------------------------------------------------------#

# Info api
if [[ "$*" == "-api-info" ]]; then
     curl -X GET https://api.shodan.io/api-info?key=${api_key} >${PWD}/api-info.json 2>/dev/null
     mlr --ijson --ocsv cat ${PWD}/api-info.json >${PWD}/api-info.csv
     echo "💾 ${ip_dns} --> ${PWD}/api-info.csv"
fi

# Info profile
if [[ "$*" == "-status" ]]; then
     curl -X GET https://api.shodan.io/account/profile?key=${api_key} >${PWD}/status.json 2>/dev/null
     mlr --ijson --ocsv cat ${PWD}/status.json > ${PWD}/status.csv
     echo "💾 ${ip_dns} --> ${PWD}/status.csv"
fi

#---------------------------------------------------------- Domaine ----------------------------------------------------------#

# Info Domaine
if [[ "$*" == "-domain"* ]]; then
     dns="$2"
     domaine=$(curl -X GET https://api.shodan.io/dns/domain/${dns}?key=${api_key} 2>/dev/null)
     echo "💾 ${dns} info --> ${PWD}/${dns}.json"
     echo "${domaine}" >"${PWD}/${dns}.json"
fi

# Reverse DNS
if [[ "$*" == "-reverse"* ]]; then

     error=(*'"error"'*)
     dns_reverse="$2"
     domaine_reverse=$(curl -X GET "https://api.shodan.io/dns/reverse?ips=${dns_reverse}&key=${api_key}" 2>/dev/null)

     if [[ ${domaine_reverse} == ${error} ]]; then
          echo "[-] No reverse ${dns_reverse} !"
     else
          echo "💾 ${dns_reverse} info --> ${PWD}/${dns_reverse}-dns-reverse.json"
          echo "${domaine_reverse}" >"${PWD}/${dns_reverse}-dns-reverse.json"
     fi
fi

# DNS resolve
if [[ "$*" == "-resolve"* ]]; then

     error=(*'"error"'*)
     dns_resolve="$2"
     domaine_resolve=$(curl -X GET "https://api.shodan.io/dns/resolve?hostnames=${dns_resolve}&key=${api_key}" 2>/dev/null)

     if [[ ${domaine_resolve} == ${error} ]]; then
          echo "[-] No resolve ${dns_reverse} !"
     else
          echo "💾 ${dns_resolve} info --> ${PWD}/${dns_resolve}-dns-resolve.json"
          echo "${domaine_resolve}" >"${PWD}/${dns_resolve}-dns-resolve.json"
     fi
fi

# Info dns
if [[ "$*" == "-dns"* ]]; then
     dns="$2"
     curl https://geonet.shodan.io/api/dns/${dns} >${PWD}/${dns}-dns.json 2>/dev/null
     mlr --ijson --ocsv cat ${PWD}/${dns}-dns.json >${PWD}/${dns}-dns.csv
fi

# Recherche DNS à partir de plusieurs emplacements dans le monde
if [[ "$*" == "-geodns"* ]]; then
     ip_dns="$2"
     curl https://geonet.shodan.io/api/geodns/${ip_dns} > ${PWD}/${ip_dns}-geodns.json 2>/dev/null
     echo "💾 ${ip_dns} --> ${PWD}/${ip_dns}-geodns.json"
fi
