#!/usr/bin/bash

domain=$1
wordlist="/home/oryx/GitHub/Bounty/Wordlists/SecLists/Discovery/DNS/deepmagic.com-prefixes-top500.txt"
resolvers="/home/oryx/GitHub/Bounty/Recon/resolvers.txt"
resolve_domain="/usr/local/bin/massdns -r /home/oryx/GitHub/Bounty/massdns/lists/resolvers.txt -t A -o S -w"

domain_enum(){
    mkdir -p $domain $domain/subdomains $domain/recon $domain/recon/nuclei
    subfinder -d $domain -o $domain/subdomains/subfinder.txt
    assetfinder -subs-only $domain | tee $domain/subdomains/assetfinder.txt
    amass enum -d $domain -o $domain/subdomains/amass.txt
    shuffledns -d $domain -w $wordlist -r $resolvers -o $domain/subdomains/shuffledns.txt
    cat $domain/subdomains/*.txt > $domain/subdomains/all.txt 
}
domain_enum
resolving_domains(){
    shuffledns -d $domain -list $domain/subdomains/all.txt -r $resolvers -o $domain/domains.txt
}
resolving_domains

httproble(){
    cat $domain/subdomains/all.txt | httpx -threads 200 -o $domain/recon.txt
}
httprobe

scanner(){
    cat $domain/recon.txt | nuclei -t /home/oryx/GitHub/Bounty/nuclei-templates/cves/ -c 50 -o $domain/recon/nuclei/cve.txt
    cat $domain/recon.txt | nuclei -t /home/oryx/GitHub/Bounty/nuclei-templates/vulnerabilities/ -c 50 -o $domain/recon/nuclei/vulnerabilities.txt
    cat $domain/recon.txt | nuclei -t /home/oryx/GitHub/Bounty/nuclei-templates/files/ -c 50 -o $domain/recon/nuclei/files.txt
}
scanner