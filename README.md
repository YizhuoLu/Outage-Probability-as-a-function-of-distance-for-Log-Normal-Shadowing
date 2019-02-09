# Outage-Probability-as-a-function-of-distance-for-Log-Normal-Shadowing
plus Rate Adaptation and Rayleigh Fading


Specification:

1. Outage Probability as a function of distance for Log-Normal Shadowing
  For the simple path loss with log-normal shadowing model, plot the outage probability as a function of distance, assuming Pt = 30dBm, the path loss at a reference distance of 1m is −30dB, the path loss exponent is 2.5, the standard deviation of the log-normal fading is 3dB, the noise level is −100dBm, and the SNR threshold for acceptable error rate is deemed to be 10dB. Now vary the path loss exponent and the standard deviation of the log-normal fading to different values. Plot and comment on how they affect the outage probability as a function of distance

2. Rayleigh Fading

  Browse through the following paper: Simulation Of Flat Fading Using MATLAB For Classroom Instruction by Prabhu and Shankar. Now download and play with the matlab code for Rayleigh fading (raygen.m) provided at this link.
For each choice of mobile speed from [0,5,10,15,20,25], generate the power_ray series. Use a threshold size of pow(3) (corresponding to about 3.25dBm) to discretize this series into two channel states (1 if above threshold, 0 if below). Model the corresponding series as a two-state Markov chain and estimate the parameters p01 and p10 for each case.
