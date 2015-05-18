function createFreq(freqOutput, TimeFreq, Freq)

   Fs = 44100;

   NumberOfSample = Fs * TimeFreq; %number of samples
   s = (1:NumberOfSample) / Fs; %sound data preparation
   freq = sin(2 * pi * Freq * s);
   
   audiowrite(freqOutput,freq,Fs);

   sound(freq, Fs);
    
end

