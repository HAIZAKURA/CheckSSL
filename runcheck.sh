mkdir ./tmp -p

curl https://${1} -k -v -s -o /dev/null 2> ./tmp/ca.info

cat ./tmp/ca.info | grep 'start date: ' > ./tmp/${1}.info
cat ./tmp/ca.info | grep 'expire date: ' >> ./tmp/${1}.info
cat ./tmp/ca.info | grep 'issuer: ' >> ./tmp/${1}.info
cat ./tmp/ca.info | grep 'SSL certificate verify' >> ./tmp/${1}.info
cat ./tmp/ca.info | grep 'subject: ' >> ./tmp/${1}.info

sed -i 's|\* [\t]* start date: ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* expire date: ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* issuer: ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* SSL certificate verify ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* subject: ||g' ./tmp/${1}.info

start=$(sed -n '1p' ./tmp/${1}.info)
expire=$(sed -n '2p' ./tmp/${1}.info)
issuer=$(sed -n '3p' ./tmp/${1}.info)
status=$(sed -n '4p' ./tmp/${1}.info)
subject=$(sed -n '5p' ./tmp/${1}.info)

rm -f ./tmp/ca.info
rm -f ./tmp/${1}.info

DATE="$(echo $(date '+%Y-%m-%d %H:%M:%S %Z'))"

nowstamp="$(date -d "$DATE" +%s)"
expirestamp="$(date -d "$expire" +%s)"
expireday=`expr $[expirestamp-nowstamp] / 86400`

echo '{' > tmp/${1}.json
echo -e '\t"domain": "'${1}'",' >> ./tmp/${1}.json
echo -e '\t"subject": "'$subject'",' >> ./tmp/${1}.json
echo -e '\t"start": "'$start'",' >> ./tmp/${1}.json
echo -e '\t"expire": "'$expire'",' >> ./tmp/${1}.json
echo -e '\t"issuer": "'$issuer'",' >> ./tmp/${1}.json

if [ $expirestamp \< $nowstamp ]; then
    echo -e '\t"status": "Expired",' >> ./tmp/${1}.json
    echo -e '\t"statuscolor": "error",' >> ./tmp/${1}.json
elif [ $expireday \< 10 ]; then
    echo -e '\t"status": "Soon Expired",' >> ./tmp/${1}.json
    echo -e '\t"statuscolor": "warning",' >> ./tmp/${1}.json
elif [ $status = "ok." ]; then
    echo -e '\t"status": "Valid",' >> ./tmp/${1}.json
    echo -e '\t"statuscolor": "success",' >> ./tmp/${1}.json
else
    echo -e '\t"status": "Invalid",' >> ./tmp/${1}.json
    echo -e '\t"statuscolor": "error",' >> ./tmp/${1}.json
fi

echo -e '\t"check": "'$DATE'",' >> ./tmp/${1}.json
echo -e '\t"remain": "'$expireday'"' >> ./tmp/${1}.json
echo '}' >> ./tmp/${1}.json

cp -rf ./tmp/${1}.json ./results/${1}.json
rm -rf ./tmp