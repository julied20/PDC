 %function[signal] = synchronization(file)
 function [signal] = synchronization()
 
 %To be replaced by the recorder signal
 %[ x, fs] = audioread(file); 
   [ x, fs] = audioread('output.wav'); 
   %frequencies
   StartFreq = 18000;
   TimeFreq = 0.06;
   %TimeStartFreq1 = fs * 3 * 0.06;
 

   %create the signal wanted for synchronization
   TimeStartFreq = 3*TimeFreq; %duration in seconds
   SamplesByFrequency = fs * TimeStartFreq; %number of samples
   s = (1:SamplesByFrequency) / fs; %sound data preparation
   sig_synchro = sin(2 * pi * StartFreq * s);
   lenghtRecordedSignal = length(x);
   
%   %correlation between the signals
%   %returns the cross-correlation of two discrete-time sequences, x and y. 
%   %Cross-correlation measures the similarity between x and shifted (lagged)
%   %copies of y as a function of the lag. If x and y have different lengths,
%   %the function appends zeros at the end of the shorter vector so it has 
%   %the same length, N, as the other.
   c_begin = xcorr(x,sig_synchro);


  lengthCorrelationSignal = length(c_begin);
  [~,delay_begin] = max(c_begin);
  delay_begin =  delay_begin - floor(lengthCorrelationSignal/2);
  
  %create the signal to analyse
  signal = zeros(lenghtRecordedSignal-delay_begin-SamplesByFrequency,1);

  for i = 1:(lenghtRecordedSignal-delay_begin-SamplesByFrequency)
    signal(i,1) = x(i+delay_begin+SamplesByFrequency,1);
  end
    
end

