function soundOutput = createSound() %createSound(message)

Freq1 = '16000.wav';
Freq0 = '16150.wav';
FreqStart = '18000.wav';
Freqtest = '14000.wav';
%FREQBip = '20000.wav';

FS = 44100;

Output = 'output.wav';

f1 = audioread(Freq1);
f0 = audioread(Freq0);
fStart = audioread(FreqStart);
%fBip = audioread(FREQBip);
fEnd = audioread(FreqStart);
fTest = audioread(Freqtest);


data = extractor();

data = cell2mat(data);


soundOutput = [fStart;fStart;fStart]; %synchronisation frequency 3 times

%Read the file and add each frequency to the output file
for i = 1:length(data)-1
   bit = data(i);
   switch bit
       case 0, soundOutput = [soundOutput; f0; f0; f0];
       case 1, soundOutput = [soundOutput; f1; f1; f1];
   end
end

%We add a Frequency to avoid the lost of information during the Analization
soundOutput = [soundOutput; fTest; fTest; fTest];
soundOutput = [soundOutput; fEnd; fEnd; fEnd];%We add 3 times the EndFreq

audiowrite(Output,soundOutput,FS);

sound(soundOutput, FS);
end


