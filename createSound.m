function createSound() %createSound(message)

FREQ1 = 'FREQ1.wav';
FREQ0 = 'FREQ0.wav';
FREQStart = 'FREQStart.wav';
FREQBip = 'FREQBip.wav';

FS = 44100;

Output = 'output.wav';

f1 = audioread(FREQ1);
f0 = audioread(FREQ0);
fStart = audioread(FREQStart);
fBip = audioread(FREQBip);
fEnd = audioread(FREQStart);

%To remove after linking files%
FileID = fopen('test.txt');
%str = '0.41 8.24 3.57 6.24 9.27';
%data = textscan(str,'%f');
data = textscan(FileID, '%1d');
fclose(FileID);
%

sound = [fStart;fBip]; %synchronisation frequency


for i = 1:length(data)-1
   bit = data(i);
   switch bit
       case '0', sound = [sound; f0];
       case '1', sound = [sound; f1];
   end
end

sound = [sound; fEnd];

audiowrite(Output,sound,FS);

end


