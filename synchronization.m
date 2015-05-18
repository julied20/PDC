%function[signal] = synchronization(file)
function [signal] = synchronization()
 
 %To be replaced by the recorder signal
 %[ x, fs] = audioread(file); 
   [ x, fs] = audioread('output.wav'); 
   %frequencies
   StartFreq = 18000;
   TimeFreq = 0.06;
 

   %create the signal wanted for synchronization
   TimeStartFreq = 3*TimeFreq; %duration in seconds
   NumberOfSample = fs * TimeStartFreq %number of samples
   s = (1:NumberOfSample) / fs; %sound data preparation
   signalOfSynchro = sin(2 * pi * StartFreq * s);
   lenghtRecordedSignal = length(x)
   
  %correlation between the signals
  %returns the cross-correlation of two discrete-time sequences, x and y. 
  %Cross-correlation measures the similarity between x and shifted (lagged)
  %copies of y as a function of the lag. If x and y have different lengths,
  %the function appends zeros at the end of the shorter vector so it has 
  %the same length, N, as the other.
   c_begin = xcorr(x,signalOfSynchro);


  lengthCorrelationSignal = length(c_begin);
  %We need the most similar 
  [~,delay] = max(c_begin);
  %Why?????
  delay =  delay - floor(lengthCorrelationSignal/2)
  
  data = lenghtRecordedSignal-delay-NumberOfSample
  %Initialize the signal to analyse
  signal = zeros(lenghtRecordedSignal-delay-NumberOfSample,1);

  for i = 1:(lenghtRecordedSignal-delay-NumberOfSample)
    signal(i,1) = x(i+delay+NumberOfSample,1);
  end
    
end

