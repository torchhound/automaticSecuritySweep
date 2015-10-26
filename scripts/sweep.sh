#! /bin/sh

echo "Enter IP or hostname:"
read input
if [ls | grep reports = -z "$(ls -lA)"]; then
	mkdir reports
	echo "Creating directory reports"
fi

dig input -b #add error handling in case of IP or host name issues
read input2

nmap -A -oG /reports/nmap$input input 
echo "nmap scan complete"

arachni input --report-save-path=/reports/arachni$input 
echo "arachni scan complete"

./w3af_console -s autosec.w3af
echo "w3af scan complete"

#put all reports together

cd /reports/
touch report$input
date +"%m-%d-%y" >> cat report$input
echo $input >> cat report$input
echo $input2 >> cat report$input
cat nmap$input >> report$input 
cat arachni$input >> report$input 
cat w3af$input.html >> report$input 
sed 's/nmap//g;s/arachni//g;s/w3af//g;s/Nmap//g;s/Arachni//g;s/W3af//g' reports$input
echo "Scan Complete"
