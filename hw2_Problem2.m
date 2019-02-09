clear
Pt=23;
K=-10;
N=-90;
Eta1=2;
Eta2=4;

SNR=[0:5:30];
d1=10.^((Pt+K-SNR-N)./(10*Eta1));
d2=10.^((Pt+K-SNR-N)./(10*Eta2));
format shortG