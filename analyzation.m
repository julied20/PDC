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
NumberOfSamples = size(x,1);
%Number of samples for each bip
samplesByNote = TimeFreq*FS;
nSplitSamples = NumberOfSamples/samplesByNote;
%To avoid problem in the end of the synchro
lgth_ending_sample = samplesByNote*(nSplitSamples-floor(nSplitSamples));
% Transform in integer
nSplitSamples = floor(nSplitSamples);
halfsamplesByNote = samplesByNote/2;

%Matrix containing each Sample
A = zeros(samplesByNote, nSplitSamples);
for i = 1:nSplitSamples
    for j = 1:samplesByNote
        A(j,i) = x(j+(i-1)*samplesByNote,1);
    end
end

A_end = zeros(floor(lgth_ending_sample), 1);

for i = 1:lgth_ending_sample
        A_end(i,1) = x(nSplitSamples+i,1);
end

%Matrix containing the fft of Each Sample
B = zeros(samplesByNote, nSplitSamples);
 
for i = 1:nSplitSamples
    % fftshift : Shift zero-frequency component to center of spectrum
    B(:,i) = fftshift(fft(A(:,i)));
end

B_end = fftshift(fft(A_end(:,1)));

%Initialization of the result
frequencies = zeros(nSplitSamples+1,1);

%Number of time an event occurs during one period
n1=Freq1*TimeFreq;
n2=Freq0*TimeFreq;
n_end = FreqEnd*TimeFreq;

%As it's symmetric, we can take the half and add the number of samples
%We take the absolute because it can have negative values
for j = 1:nSplitSamples
    v_a = abs(B(halfsamplesByNote + n1 + 1 ,j));
    v_b = abs(B(halfsamplesByNote + n2 + 1 ,j));
    v_end = abs(B(halfsamplesByNote + n_end + 1,j));

maximum = max([v_a, v_b, v_end]);
    if maximum == v_a
        frequencies(j,1) = Freq1;
    elseif maximum == v_b
        frequencies(j,1) = Freq0;
    else
        break;
    end
end

n1=floor(Freq1*TimeFreq/lgth_ending_sample);
n2=floor(Freq0*TimeFreq/lgth_ending_sample);
n_end=floor(FreqEnd*TimeFreq/lgth_ending_sample);

halfsamplesByNote = ceil(length(B_end)/2);
    v_a = abs(B_end(halfsamplesByNote + n1 +1,1));
    v_b = abs(B_end(halfsamplesByNote + n2 +1,1));
    v_end = abs(B_end(halfsamplesByNote + n_end +1,1));

    maximum = max([v_a, v_b, v_end]);
    if maximum == v_a
        frequencies(nSplitSamples+1,1) = Freq1;
    elseif maximum == v_b
        frequencies(nSplitSamples+1,1) = Freq0;
    else
        
    end 

        

   
end
