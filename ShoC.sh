#!/bin/bash

# Banniere
ban() {
     cat <<"EOF"
                                                                
      ::::::::  :::    :::  ::::::::   :::::::: 
    :+:    :+: :+:    :+: :+:    :+: :+:    :+: 
   +:+        +:+    +:+ +:+    +:+ +:+         
  +#++:++#++ +#++:++#++ +#+    +:+ +#+          
        +#+ +#+    +#+ +#+    +#+ +#+           
#+#    #+# #+#    #+# #+#    #+# #+#    #+#     
########  ###    ###  ########   ########                                                                 

               by M0rPH3U53

EOF
}

if [[ "$*" == "-help" ]]; then
     ban
     echo " "
     echo "Usage: ./ShoC.sh COMMAND"
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
     echo "   -ip         Recherche info services"
     echo "   -host       Recherche info services (no api)"
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

     no_info=(*"No information available"*)
     cve="$2"
     cve_db=$(curl https://cvedb.shodan.io/cve/${cve} 2>/dev/null)
     
     if [[ ${cve_db} == ${no_info} ]]; then
          echo "[-] No found ${cve} !"
     else
          echo "${cve_db}" | jq -r '"CVE ID: \(.cve_id)", "CVSS: \(.cvss)", "", "Description:", .euvd.description, "", "References:", (.euvd.references[] | "- \(.)")'
     fi
fi

# Liste des CVE les plus recente
if [[ "$*" == "-news" ]]; then
     curl https://cvedb.shodan.io/cves >${PWD}/list-cves.json 2>/dev/null
     echo "💾 CVEs récentes --> ${PWD}/list-cves.json"
fi

# CVEs par produit
if [[ "$*" == "-product"* ]]; then

     no_info=(*"No information available"*)
     produit="$2"
     pruduct_cve=$(curl https://cvedb.shodan.io/cves?product=${produit} > ${PWD}/${produit}-cves.json 2>/dev/null)

     if [[ ${pruduct_cve} == ${no_info} ]]; then
          echo "[-] No found ${produit} !"
     else
          echo "[+] CVE found !"
          echo "💾 CVEs ${produit} --> ${PWD}/${produit}.json"
     fi
fi

#---------------------------------------------------------- Host ----------------------------------------------------------#

# Détails de service (api)
if [[ "$*" == "-ip"* ]]; then

     error=(*'"error"'*)
     ipaddres="$2"
     hostn=$(curl -X GET https://api.shodan.io/shodan/host/${ipaddres}?key=${api_key} 2>/dev/null)

     if [[ ${hostn} == ${error} ]]; then
          echo "[-] No data ${ipaddres} !"
     else
          echo "[+] Info"
          echo " "
          echo "${hostn}" | jq -r '"IP: \(.ip_str)\nDomains: \(.domains | join(", "))\nHostnames: \(.hostnames | join(", "))\nPorts: \(.ports | join(", "))"'
          echo " "
          echo "[+] ${ipaddres} + d'info --> ${PWD}/${ipaddres}.json"
          echo "${hostn}" > "${PWD}/${ipaddres}.json"

     fi
fi

# Détails de service (no api)
if [[ "$*" == "-host"* ]]; then

     user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.2277.83"
     ip_pub="$2"
     url=$(curl -A "${user_agent}" https://www.shodan.io/host/${ip_pub} 2>/dev/null)
     no_info=$(echo "${url}" | grep "No information")

     if [[ -n "${no_info}" ]]; then
          echo "[-] No data ${ip_pub} !"
     else
          echo "💾 ${ip_pub} info --> ${PWD}/${ip_pub}.html"
          echo "${url}" >"${PWD}/${ip_pub}-host.html"

     fi
fi

# Script nmap
if [[ "$*" == "-nmap"* ]]; then
     ipadd="$2"
     nmap_ports=$(nmap --script shodan-api --script-args shodan-api.target=${ipadd},shodan-api.apikey=${api_key},shodan-api.outfile=${ipadd}.csv 2>/dev/null)
     clean=$(echo "${nmap_ports}" | grep "^|" | grep -Ev "Shodan|shodan|PORT.*PROTO|_" | sed 's/^| //' | awk '{print "[+] " $1 "/" $2 " --> "$3 $4}')
     echo "🌐 Port & services"
     echo " "
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

# Ping IP (avec les sonde shodan)
if [[ "$*" == "-geoping"* ]]; then
     ping_ip="$2"
     geoping_result=$(curl https://geonet.shodan.io/api/geoping/${ping_ip} 2>/dev/null)
     echo "${geoping_result}" | jq -r '(["IP","Ville","Pays","Alive","Min RTT","Avg RTT","Max RTT","Envoyés","Reçus","Perdu"], (.[] | [.ip,.from_loc.city,.from_loc.country,(.is_alive|tostring),(.min_rtt|tostring)+" ms",(.avg_rtt|tostring)+" ms",(.max_rtt|tostring)+" ms",(.packets_sent|tostring),(.packets_received|tostring),(.packet_loss|tostring)+"%"])) | @tsv' | column -t -s $'\t'
fi

# Ping classique
if [[ "$*" == "-ping"* ]]; then
     ping="$2"
     pingg=$(curl https://geonet.shodan.io/api/ping/${ping} 2>/dev/null)
     echo "${pingg}" | jq -r '(["IP","Ville","Pays","Alive","Min RTT","Avg RTT","Max RTT","Envoyés","Reçus","Perdu"], [.ip,.from_loc.city,.from_loc.country,(.is_alive|tostring),(.min_rtt|tostring)+" ms",(.avg_rtt|tostring)+" ms",(.max_rtt|tostring)+" ms",(.packets_sent|tostring),(.packets_received|tostring),(.packet_loss|tostring)+"%"]) | @tsv' | column -t -s $'\t'
fi

#---------------------------------------------------------- Info ----------------------------------------------------------#

# Info api
if [[ "$*" == "-api-info" ]]; then
     api_info=$(curl -X GET https://api.shodan.io/api-info?key=${api_key}  2>/dev/null)
     echo "${api_info}" | jq -r '"Plan : \(.plan)", "Crédits scan : \(.scan_credits)", "Crédits requête : \(.query_credits)", "IPs surveillées : \(.monitored_ips)", "HTTPS : \(.https)", "Telnet : \(.telnet)", "Déverrouillé : \(.unlocked)"'
fi

# Info profile
if [[ "$*" == "-status" ]]; then
     info_compte=$(curl -X GET https://api.shodan.io/account/profile?key=${api_key} 2>/dev/null)
     echo "${info_compte}" | jq -r '"Membre : \(.member)", "Credits : \(.credits)", "User : \(.username)", "Display name : \(.display_name)", "Créé : \(.created)"'
fi

# Recupere ip publique
if [[ "$*" == "-myip" ]]; then
     my_ip=$(curl -X GET https://api.shodan.io/tools/myip?key=${api_key} 2>/dev/null)
     echo "${my_ip}" | jq -r '.'
fi

#---------------------------------------------------------- Domaine ----------------------------------------------------------#

# Details domaine
if [[ "$*" == "-domain"* ]]; then

     error=(*'"error"'*)
     dns="$2"
     domaine=$(curl -X GET https://api.shodan.io/dns/domain/${dns}?key=${api_key} 2>/dev/null)

     if [[ ${domaine} == ${error} ]]; then
          echo "[-] No domain found !"
     else
          echo "${domaine}" | jq -r '.domain as $domain | (["SUBDOMAIN","TYPE","TTL","IP","LAST_SEEN"], (.data[] | [((.subdomain + "." + $domain) | ltrimstr(".")),.type,.options.ttl,.value,.last_seen])) | @tsv' | column -t -s $'\t'
     fi
fi

# Reverse DNS
if [[ "$*" == "-reverse"* ]]; then

     error=(*'"error"'*)
     dns_reverse="$2"
     domaine_reverse=$(curl -X GET "https://api.shodan.io/dns/reverse?ips=${dns_reverse}&key=${api_key}" 2>/dev/null)

     if [[ ${domaine_reverse} == ${error} ]]; then
          echo "[-] No reverse ${dns_reverse} !"
     else
          echo "${domaine_reverse}" | jq -r 'to_entries[] | .value[] as $dns | "\(.key): \($dns)"'
     fi
fi

# DNS resolve
if [[ "$*" == "-resolve"* ]]; then

     error=(*'"error"'*)
     dns_resolve="$2"
     domaine_resolve=$(curl -X GET "https://api.shodan.io/dns/resolve?hostnames=${dns_resolve}&key=${api_key}" 2>/dev/null)

     if [[ ${domaine_resolve} == ${error} ]]; then
          echo "[-] No resolve ${dns_resolve} !"
     else
          echo "${domaine_resolve}" | jq -r 'to_entries[] | "\(.key): \(.value)"'

     fi
fi

# Info dns
if [[ "$*" == "-dns"* ]]; then
     dns="$2"
     result=$(curl https://geonet.shodan.io/api/dns/${dns} 2>/dev/null)
     echo "${result}" | jq -r '.answers[] | "\(.type): \(.value)"'
fi

# Recherche DNS (avec les sonde shodan)
if [[ "$*" == "-geodns"* ]]; then
     ip_dns="$2"
     res=$(curl https://geonet.shodan.io/api/geodns/${ip_dns} 2>/dev/null)
     echo "${res}" | jq -r '.[] | .answers[] as $answer | "\($answer.type) \($answer.value) \(.from_loc.city), \(.from_loc.country) (\(.from_loc.latlon))"'

fi
