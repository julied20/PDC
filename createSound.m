function soundOutput = createSound() 

Freq11 = '16000.wav';
Freq00 = '16150.wav';
Freq10 = '17000.wav';
Freq01 = '17150.wav';
FreqStart = '18000.wav';

FS = 44100;

Output = 'output.wav';

f11 = audioread(Freq11);
f00 = audioread(Freq00);
f10 = audioread(Freq10);
f01 = audioread(Freq01);
fStart = audioread(FreqStart);
fEnd = audioread(FreqStart);


data = text_to_bits();


soundOutput = [fStart;fStart;fStart]; %synchronisation frequency 3 times
%Read the file and add each frequency to the output file
for i = 1:length(data)
    
   bit = strcat(data(i,1), data(i,2));
   switch bit
       case '00', soundOutput = [soundOutput; f00; f00; f00; f00; f00];
       case '11', soundOutput = [soundOutput; f11; f11; f11; f11; f11];
       case '10', soundOutput = [soundOutput; f10; f10; f10; f10; f10];
       case '01', soundOutput = [soundOutput; f01; f01; f01; f01; f01];    
   end
end

soundOutput = [soundOutput; fEnd; fEnd; fEnd];%We add 3 times the EndFreq

audiowrite(Output,soundOutput,FS);

sound(soundOutput, FS);
end
