function frequencies = analyzation(file)


%frequencies we need to recover
Freq11 = 9000;
Freq00 = 10000;
Freq10 = 11000;
Freq01 = 12000;
FreqEnd = 18000;

%sampling frequency
FS = 44100;

%Duration of each frequencies
TimeFreq = 0.06;

x = synchronization(file);


%Number of samples in our signal
NumberOfSamples = size(x,1);
%Number of samples for each characters
NumberOfSamplesByFrequency = TimeFreq*FS;


%Doit trouver un autre nom: Nombre d'elements a analyser
NumberOfSampleByNote = floor( NumberOfSamples/NumberOfSamplesByFrequency);
if ( mod(NumberOfSampleByNote,5) ~= 0)
    NumberOfSampleByNote = NumberOfSampleByNote - (5 + mod(NumberOfSampleByNote,5));
end
halfNumberOfSamplesByFrequency = NumberOfSamplesByFrequency/2;

%Matrix containing each Sample
%We take the samples for the first note and we put them 
%Tu prend les premiers X nombres de samples (qui repr?sentes 1 note) 
%et tu les fous dans la premi?re ligne de A
%Ensuite tu prends les suivant X samples et tu les fous dans la 2?me ligne
SampleMatrix = zeros(NumberOfSamplesByFrequency, NumberOfSampleByNote);
for i = 1:NumberOfSampleByNote
    for j = 1:NumberOfSamplesByFrequency
        SampleMatrix(j,i) = x(j+(i-1)*NumberOfSamplesByFrequency,1);
    end
end


%Matrix containing the fft of Each Sample
FourierMatrix = zeros(NumberOfSamplesByFrequency, NumberOfSampleByNote);

for i = 1:NumberOfSampleByNote
    % fftshift : Shift zero-frequency component to center of spectrum
    FourierMatrix(:,i) = fftshift(fft(SampleMatrix(:,i)));
    
end

%Number of time an event occurs during one period
NumberOfFreq11=Freq11*TimeFreq;
NumberOfFreq00=Freq00*TimeFreq;
NumberOfFreq10=Freq10*TimeFreq;
NumberOfFreq01=Freq01*TimeFreq;
NumberOfFreqEnd = FreqEnd*TimeFreq;

frequencies = [];
%As it's symmetric, we can take the half and add the number of samples
%We take the absolute because it can have negative values
%As we have sent 3 times each frequencies, we need to cover the Matrix 3 by
% 3. Then for each triplet, we look at the number of time each frequency
% appeared, and we choose the one with the maximum number of appearance.
for j = 1:5:NumberOfSampleByNote-4
    nb11 = 0;
    nb00 = 0;
    nb01 = 0;
    nb10 = 0;
    nbend = 0;
    
    for i = j:j+4
        %We look for each frequencies the power of the signal.
        v_a = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreq11 + 1 ,i));
        v_b = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreq00 + 1 ,i));
        v_c = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreq10 + 1 ,i));
        v_d = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreq01 + 1 ,i));
        v_end = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreqEnd + 1,i));
        
        maximum = max([v_a, v_b, v_c, v_d, v_end]);
        if maximum == v_a
            nb11 = nb11 + 1;
        elseif maximum == v_b
            nb00 = nb00 +1;
        elseif maximum == v_c
            nb10 = nb10 +1;
        elseif maximum == v_d
            nb01 = nb01 +1;
        elseif maximum == v_end
            nbend = nbend + 1;
        else
            break;
        end
    end
    
    %We choose which frequency
    maximum = max([nb11, nb00, nb10, nb01, nbend]);
    if maximum == nb11
        frequencies = [frequencies; Freq11];
    elseif maximum == nb00
        frequencies = [frequencies; Freq00];
    elseif maximum == nb10
        frequencies = [frequencies; Freq10];
    elseif maximum == nb01
        frequencies = [frequencies; Freq01];
    elseif maximum == nbend
        break;
    else
    end
end


end