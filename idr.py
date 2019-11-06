import matplotlib.pyplot as plt
import json
from urllib.request import urlopen

data = json.load(urlopen("https://api.exchangeratesapi.io/history?start_at=2019-01-01&end_at=2019-06-01"))

#with open('exrates.json', 'r') as fp:
#    data = json.load(fp)

x = []
y = []

rates = data['rates']

for date in rates:
    fmt = date.split('-')
    x.append("%s/%s/19" %(fmt[2], fmt[1]))
    #for val in rates[date]['IDR']
    for currency in rates[date]:
        if currency == 'IDR':
            y.append(rates[date]['IDR'])

#print("%s -> %d"%(x[0],y[0]))

plt.title('Nilai Mata Uang Rupiah')
#plt.xlabel('Tanggal')
#plt.ylabel('Nilai Rupiah')

plt.margins(x = -0.4)
plt.plot(x, y, linestyle='dashed', color='red', marker='o', markerfacecolor='blue')
plt.xticks(rotation = 45)
plt.show()
