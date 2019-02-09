clear
%Gayatrii Prabhu and P. M. Shankar
%generates Rayleigh faded signal with 10 multiple paths
%by varying the number of paths, it is possible to get an idea on how many paths are required
%for Rayleigh fading (numpaths)
v=input('MU speed in m/s....5, 10, 15, 20, 25,..>');
numpaths = 10; %number of paths
Fc = 900e6; %carrier frequency
Fs = 4*Fc; %sampling frequency
Ts = 1/Fs; %sampling period
t = [0:Ts:1999*Ts]; %time array
wc = 2*pi*Fc; %radian frequency
%v = 25; %vehicle speed in m/s

   	ray = zeros(1,length(t)); %received signal

	for i = 1:numpaths
    	wd = 2*pi*v*Fc*cos(unifrnd(0,2*pi))/3e8;
		a =  wblrnd(1,3,1,length(t)); 
		ray = ray + a.*cos((wc+wd)*t+unifrnd(0,2*pi,1,length(t)));
   	end;

	[rayi rayq] = demod(ray,Fc,Fs,'qam'); %demodulated signal 
	env_ray = sqrt(rayi.^2+rayq.^2); %envelope of received signal 
%     subplot(2,2,1)
% plot(t*1e9,ray)%plots the rf signal
% title('rf signal')
% xlabel('time ns')
% ylabel('volt')
% xlim([0 20])
% subplot(2,2,2)
% plot(t*1e9,rayi)%plots the inphase component
% xlabel('time ns')
% ylabel('volt')
% xlim([0 20])
% title('inphase component')
% subplot(2,2,3)
% plot(t*1e9,rayq)%plots the quadrature component
% title('quadrature component')
% xlabel('time ns')
% ylabel('volt')
% xlim([0 20])
% subplot(2,2,4)
% plot(t*1e9,env_ray)%plots the envelope
% title('envelope')
% xlabel('time ns')
% ylabel('volt')
% xlim([0 20])

y = sort(env_ray); %unity mean
b = (mean(y)^2)*2/pi; %Rayleigh parameter for unit mean
fyray = (y./b).*exp(-(y.^2/(2*b)));

m=mean(y.^2)^2/mean((y.^2-mean(y.^2)).^2); %Nakagami m parameter
omega=mean(y.^2); %Nakagami parameter
fynaka = (2*m^m*y.^(2*m-1).*exp(-(m*y.^2)./omega))./(gamma(m)*omega^m);

h=18;
x1=hist(y,h);
x1=x1./max(x1);
y=y./max(y);

x2=fyray;
x2=x2./max(x2);
fray=x2;
x3=fynaka;
x3=x3./max(x3);
fynaka=x3;
% figure
% plot(0:1/h:1-1/h,x1,':')
% hold on
% plot(y,fray)
% hold on
% plot(y,fynaka,'--')
% xlabel('Envelope r');
% ylabel('Probability density function f(r)');

%computation of the outage probabilities
power_ray=env_ray.^2;
powerdBm=10*log10(power_ray);
% mean_power=10*log10(mean(env_ray.^2))
MK=length(env_ray);
prevdBm=(powerdBm(1)+powerdBm(2))/2;
count01=0;
count00=0;
count10=0;
count11=0;
for round=3:MK
    powerdBm_curr=(powerdBm(round)+powerdBm(round-1))/2;
    if (powerdBm_curr > 3.25) && (prevdBm < 3.25)
        count01=count01+1;
    elseif (powerdBm_curr < 3.25) && (prevdBm > 3.25)
            count10=count10+1;
    elseif (powerdBm_curr < 3.25) && (prevdBm < 3.25)
            count00=count00+1;
    else
        count11=count11+1;
     end

    prevdBm=powerdBm_curr;
end
p01=count01/(count01+count00);
p00=count00/(count01+count00);
p10=count10/(count10+count11);
p11=count11/(count11+count10);
transition_matrix=[p00,p01;p10,p11];

% for k=1:20
%     pow(k)=mean_power-2*k; %threshold power
%     kps=pow(k);
%     ratio=10^(kps/10)/10^(mean_power/10);
%     poutth(k)=1-exp(-ratio);%theoretical outage
%     count01=0
%     count10=0
%     prev=powerdB(1)
%     for ku=2:MK
%         power_curr=powerdB(ku);%power in dB
%         if (power_curr <= 3.25) && (prev > 3.25)
%             count10=count10+1;
%         else if (power_curr > 3.25) && (prev <= 3.25)
%                 count01=count01+1
%             end
%         end
%         prev=power_curr
%     end
%     p01=count01/MK;
%     p10=count10/MK;
%     transition_matrix=[1-p01, p01; p10, 1-p10];
% %         poutsim(k)=count/MK;%outage probability simulated
%         
% end


