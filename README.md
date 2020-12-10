# SubdomainEnum

#############################################################################

                      SubdomainEnum
                    
#############################################################################

Here I have created a bash script to run several tools for discovering 
Subdomains when preforming recon on a target for Bug Bounty. In order for this
script to run you'll first need to install:

Subfinder
Assetfinder
Amass
ShuffleDNS
HttProbe
Httpx
MassDNS

And add them to your $HOME $PATH. I created a requirments.txt file with each tools
URL. 
Also you will need to install SecLists Wordlist:

git clone https://github.com/danielmiessler/SecLists

This command will install the full Seclists wordlist.

After this you will also need to change the source code to match your directory
path and where it stores the results and also looks for resolver.txt

################################################################################

################################################################################
