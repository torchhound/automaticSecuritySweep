#! /bin/sh

echo "Enter IP or hostname:"
read input

dig input -b #add error handling in case of IP or host name issues
read input2

nmap -A -oG "/reports/nmap"$input input 

arachni input --report-save-path=/reports/arachni$input 

./w3af_console -s autosec.w3af

#put all reports together

cd /reports/
touch "report"$input
date +"%m-%d-%y" >> cat "report"$input
echo $input >> cat "report"$input
echo $input2 >> cat "report"$input
cat "nmap"$input >> "report"$input 
cat "arachni"$input >> "report"$input 
cat "w3af"$input.html >> "report"$input 
