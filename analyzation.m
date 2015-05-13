%function frequencies = analyzation(file)

function frequencies = analyzation()
  
  %frequency
  Freq1 = 16000;
  Freq0 = 16150;
  FreqEnd = 18000;  
  
  FS = 44100;
  
  %time
  TimeFreq = 0.06;

%Change once we use 2 computers
%x = synchronization(file);
x = synchronization();


%Number of samples in x
NumberOfSamples = size(x,1)
%Number of samples for each bip
NumberOfSamplesByFrequency = TimeFreq*FS
%Length of a sample
%LengthOfaSample = TimeFreq/NumberOfSamplesByFrequency
NumberOfFrequencies = NumberOfSamples/NumberOfSamplesByFrequency
%To avoid problem in the end of the synchro
NumberOfFrequencies-floor(NumberOfFrequencies)
lengthLastSample = NumberOfSamplesByFrequency*(NumberOfFrequencies-floor(NumberOfFrequencies))
% Transform in integer
NumberOfFrequencies = floor(NumberOfFrequencies)
halfNumberOfSamplesByFrequency = NumberOfSamplesByFrequency/2

%Matrix containing each Sample
SampleMatrix = zeros(NumberOfSamplesByFrequency, NumberOfFrequencies);
for i = 1:NumberOfFrequencies
    for j = 1:NumberOfSamplesByFrequency
        SampleMatrix(j,i) = x(j+(i-1)*NumberOfSamplesByFrequency,1);
    end
end

SampleMatrixEnd = zeros(floor(lengthLastSample), 1);

for i = 1:lengthLastSample
        SampleMatrixEnd(i,1) = x(NumberOfFrequencies+i,1);
end

%Matrix containing the fft of Each Sample
FourierMatrix = zeros(NumberOfSamplesByFrequency, NumberOfFrequencies);
 
for i = 1:NumberOfFrequencies
    % fftshift : Shift zero-frequency component to center of spectrum
    FourierMatrix(:,i) = fftshift(fft(SampleMatrix(:,i)));

end

FourierMatrixEnd = fftshift(fft(SampleMatrixEnd(:,1)));

%Initialization of the result
frequencies = zeros(NumberOfFrequencies+1,1);

%Number of time an event occurs during one period
NumberOfFreq1=Freq1*TimeFreq;
NumberOfFreq0=Freq0*TimeFreq;
NumberOfFreqEnd = FreqEnd*TimeFreq;

%As it's symmetric, we can take the half and add the number of samples
%We take the absolute because it can have negative values
for j = 1:NumberOfFrequencies
    
    v_a = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreq1 + 1 ,j));
    v_b = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreq0 + 1 ,j));
    v_end = abs(FourierMatrix(halfNumberOfSamplesByFrequency + NumberOfFreqEnd + 1,j));
    
maximum = max([v_a, v_b, v_end]);
    if maximum == v_a
        frequencies(j,1) = Freq1;
    elseif maximum == v_b
        frequencies(j,1) = Freq0;
    else
        break;
    
    end
end

NumberOfFreq1= floor(NumberOfFreq1/lengthLastSample);
NumberOfFreq0= floor(NumberOfFreq0/lengthLastSample);
%NumberOfFreqEnd= floor(NumberOfFreqEnd/lengthLastSample);

halfNumberOfSamplesByFrequency = floor(length(FourierMatrixEnd)/2);
    v_a = abs(FourierMatrixEnd(halfNumberOfSamplesByFrequency + NumberOfFreq1 +1,1));
    v_b = abs(FourierMatrixEnd(halfNumberOfSamplesByFrequency + NumberOfFreq0 +1,1));
    %v_end = abs(FourierMatrixEnd(halfNumberOfSamplesByFrequency + NumberOfFreqEnd +1,1));

    maximum = max([v_a, v_b]);
    if maximum == v_a
        frequencies(NumberOfFrequencies+1,1) = Freq1;
    elseif maximum == v_b
        frequencies(NumberOfFrequencies+1,1) = Freq0;
    else
        
    end 

        

   
end