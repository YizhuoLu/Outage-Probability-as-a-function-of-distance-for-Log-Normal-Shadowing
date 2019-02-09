import numpy as np
from scipy.stats import norm
import matplotlib.pyplot as plt
import math

# plot cdf of SNR
# SNR = Pr / N = (Pt + Kref - Eta  * lgd + Psi(0, sigma^2)) / N
# Pt = 30dBm, Kref = -30dB, Eta = 2.5, sigma = 3dB, N = -100dBm, threshold = 10dB
# plot Phi(( (Pt + Kref - Eta  * 10 * lgd) / N  ), (sigma / N)^2
# 1 - Q(x) = Psi(x), I need to convert it to 0,1 standard normal distribution.
# SNR(dBm) = Pr(dBm) - N(dBm)
# x = Pr_min + N - C / sigma
# Pr_min = -90dBm

Pr_min = -90
N = -100
sigma3 = 3
Pt = 30
Kref = -30
theta = 10
Eta1 = 2.3
Eta2 = 2.4
Eta3 = 2.5
Eta4 = 2.7
Eta5 = 3
p1 = []
p2 = []
p3 = []
p4 = []
p5 = []

sigma1=1
sigma2=2
sigma4=4
sigma5=5
p6=[]
p7=[]
p8=[]
p9=[]
p10=[]
for x in np.arange(1, 16000, 100):
    tmp1 = norm.cdf((theta + N - (Pt + Kref - Eta1 * 10 * math.log10(x))) / sigma3)
    p1.append(tmp1)
    tmp2 = norm.cdf((theta + N - (Pt + Kref - Eta2 * 10 * math.log10(x))) / sigma3)
    p2.append(tmp2)
    tmp3 = norm.cdf((theta + N - (Pt + Kref - Eta3 * 10 * math.log10(x))) / sigma3)
    p3.append(tmp3)
    tmp4 = norm.cdf((theta + N - (Pt + Kref - Eta4 * 10 * math.log10(x))) / sigma3)
    p4.append(tmp4)
    tmp5 = norm.cdf((theta + N - (Pt + Kref - Eta5 * 10 * math.log10(x))) / sigma3)
    p5.append(tmp5)

    tmp6 = norm.cdf((theta + N - (Pt + Kref - Eta3 * 10 * math.log10(x))) / sigma1)
    p6.append(tmp6)
    tmp7 = norm.cdf((theta + N - (Pt + Kref - Eta3 * 10 * math.log10(x))) / sigma2)
    p7.append(tmp7)
    tmp8 = norm.cdf((theta + N - (Pt + Kref - Eta3 * 10 * math.log10(x))) / sigma3)
    p8.append(tmp8)
    tmp9 = norm.cdf((theta + N - (Pt + Kref - Eta3 * 10 * math.log10(x))) / sigma4)
    p9.append(tmp9)
    tmp10 = norm.cdf((theta + N - (Pt + Kref - Eta3 * 10 * math.log10(x))) / sigma5)
    p10.append(tmp10)
# p = norm.cdf((theta + N - (Pt + Kref - Eta * 10 * np.log10(d))) / sigma)
d = np.arange(1, 16000, 100)


fig,ax=plt.subplots()
plt.xlabel('distance (m)')
plt.ylabel('outage probability')
plt.title('outage probability and distance with Eta varying')
ax.plot(d, p1, marker='o', markersize='2',linewidth='1', label='Eta=2.3')
ax.plot(d, p2, linestyle='-.', label='Eta=2.4')
ax.plot(d, p3, linestyle='--', label='Eta=2.5')
ax.plot(d, p4, linestyle='-', label='Eta=2.7')
ax.plot(d, p5, linestyle=':', label='Eta=3')
legend=ax.legend(loc='lower right', shadow=True)
# plt.figure(1)

fig2, ax2=plt.subplots()
plt.xlabel('distance (m)')
plt.ylabel('outage probability')
plt.title('outage probability and distance with sigma varying')
ax2.plot(d, p6, linestyle='-.', label='sigma=1')
ax2.plot(d, p7, linestyle='--', label='sigma=2')
ax2.plot(d, p8, linestyle='-', label='sigma=3')
ax2.plot(d, p9, linestyle=':', label='sigma=4')
ax2.plot(d, p10, marker='o', markersize='2',linewidth='1', label='sigma=5')
legend2=ax2.legend(loc='lower right', shadow=True)
# plt.figure(2)
plt.show()