import requests
import json
transaction=int(300)
fees_r = requests.get('https://bitcoinfees.earn.com/api/v1/fees/recommended')
bitcoin_r = requests.get('https://api.coinbase.com/v2/prices/spot?currency=USD')
fees_json=fees_r.text
bitcoin_json=bitcoin_r.text
fees=json.loads(fees_json)
bitcoin=json.loads(bitcoin_json)
#print (fees['fastestFee'])
#print (bitcoin['amount'])
#print ('$' + bitcoin['data']['amount'])
btc=float(bitcoin['data']['amount'])
satUSD=btc/100000000
fastestsat=int(fees['fastestFee'])*transaction
halfHoursat=int(fees['halfHourFee'])*transaction
hoursat=int(fees['hourFee'])*transaction
fastestUSD=float(satUSD*fastestsat)
halfHourUSD=float(satUSD*halfHoursat)
hourUSD=float(satUSD*halfHoursat)
print ("$" + format(btc, '.2f') + " | " + "$" + format(fastestUSD, '.2f') + " | " + "$" + format(halfHourUSD, '.2f') + " | " + "$" + format(hourUSD, '.2f'))