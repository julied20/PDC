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
NumberOfFrequencies = NumberOfSamples/NumberOfSamplesByFrequency
%To avoid problem in the end of the synchro
lengthLastSample = NumberOfSamplesByFrequency*(NumberOfFrequencies-floor(NumberOfFrequencies))
% Transform in integer
NumberOfFrequencies = floor(NumberOfFrequencies)
halfNumberOfSamplesByFrequency = NumberOfSamplesByFrequency/2

%Matrix containing each Sample
A = zeros(NumberOfSamplesByFrequency, NumberOfFrequencies);
for i = 1:NumberOfFrequencies
    for j = 1:NumberOfSamplesByFrequency
        A(j,i) = x(j+(i-1)*NumberOfSamplesByFrequency,1);
    end
end

A_end = zeros(floor(lengthLastSample), 1);

for i = 1:lengthLastSample
        A_end(i,1) = x(NumberOfFrequencies+i,1);
end

%Matrix containing the fft of Each Sample
B = zeros(NumberOfSamplesByFrequency, NumberOfFrequencies);
 
for i = 1:NumberOfFrequencies
    % fftshift : Shift zero-frequency component to center of spectrum
    B(:,i) = fftshift(fft(A(:,i)));

end

B_end = fftshift(fft(A_end(:,1)));

%Initialization of the result
frequencies = zeros(NumberOfFrequencies+1,1);

%Number of time an event occurs during one period
NumberOfFreq1=Freq1*TimeFreq;
NumberOfFreq0=Freq0*TimeFreq;
NumberOfFreqEnd = FreqEnd*TimeFreq;

%As it's symmetric, we can take the half and add the number of samples
%We take the absolute because it can have negative values
for j = 1:NumberOfFrequencies
    v_a = abs(B(halfNumberOfSamplesByFrequency + NumberOfFreq1 + 1 ,j));
    v_b = abs(B(halfNumberOfSamplesByFrequency + NumberOfFreq0 + 1 ,j));
    v_end = abs(B(halfNumberOfSamplesByFrequency + NumberOfFreqEnd + 1,j));

maximum = max([v_a, v_b, v_end]);
    if maximum == v_a
        frequencies(j,1) = Freq1;
    elseif maximum == v_b
        frequencies(j,1) = Freq0;
    else
        break;
    end
end
NumberOfFreq1
NumberOfFreq0
NumberOfFreq1= floor(NumberOfFreq1/lengthLastSample);
NumberOfFreq0= floor(NumberOfFreq0/lengthLastSample);
NumberOfFreqEnd= floor(NumberOfFreqEnd/lengthLastSample);

halfNumberOfSamplesByFrequency = floor(length(B_end)/2)
    v_a = abs(B_end(halfNumberOfSamplesByFrequency + NumberOfFreq1 +1,1))
    v_b = abs(B_end(halfNumberOfSamplesByFrequency + NumberOfFreq0 +1,1))
    v_end = abs(B_end(halfNumberOfSamplesByFrequency + NumberOfFreqEnd +1,1))

    maximum = max([v_a, v_b, v_end]);
    if maximum == v_a
        frequencies(NumberOfFrequencies+1,1) = Freq1;
    elseif maximum == v_b
        frequencies(NumberOfFrequencies+1,1) = Freq0;
    else
        
    end 

        

   
end