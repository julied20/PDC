%function conversion (file)
function conversion ()

Freq1 = 16000;
Freq0 = 16150;


%analyze the frequencies
%freq = analyzation(file);
freq = analyzation();

result = fopen('result.txt', 'w');

for i = 1:length(freq)
    a = freq(i);
    switch a
        case Freq1
            fprintf(result, '1');
        case Freq0
            fprintf(result, '0');
            
    end
    
    %result
    
    
end

fclose(result);

end