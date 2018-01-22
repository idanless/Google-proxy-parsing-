while true 
do

#remove log file
rm -f google.txt
echo "test"
sleep 3
#Dowload the Page
curl -s -o test.html https://free-proxy-list.net/
#parsing data usnig linux tools and pup bin form github
cat test.html  | pup 'td' | grep -v class | grep  -v '<' | grep -v ago |grep  '[0-9]'>iplist.txt 
cat iplist.txt | awk 'NR%2{printf "%s ",$0;next;}1' | cut -d ' ' -f2,4 |tr ' ' ':' >listc.txt
#take 50 ip in random
 cat listc.txt | sort -R|head -n 100 | while read ip;
do
echo 100 >google.log
#check response + google
test=$(curl -s --max-time 10 -o google.log -i  http://maps.googleapis.com/maps/api/geocode/json?latlng=34.007834,35.649314 --proxy $ip;cat google.log|grep HTTP|cut -d ' ' -f2| head -n1)
res=$(curl -m 11 -s http://maps.googleapis.com/maps/api/geocode/json?latlng=34.007834,35.649314  --proxy $ip  -w %{time_total}\\n -o /dev/null |cut -d '.' -f1)
if [ "$test" = "200" ]
then
   echo "ok found 200"
    if [ "$res" -lt 10 ]
    then
       echo "response ok"
       echo $ip >>google.txt
    else
        echo "google not work"
    fi
 

else
    echo "google not work"
fi


done
sleep 600

done