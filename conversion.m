function conversion (file)
%function conversion ()

Freq11 = 9000;
Freq00 = 10000;
Freq10 = 11000;
Freq01 = 12000;

%analyze the frequencies
freq = analyzation(file);
%freq = analyzation()

result = fopen('resultbits.txt', 'w');

    for i = 1:length(freq)
        a = freq(i);
        switch a
            case Freq11
                fprintf(result, '11');
            case Freq00
                fprintf(result, '00'); 
            case Freq10
                fprintf(result, '10');
            case Freq01
                fprintf(result, '01');     
        end   
    end
    
fclose(result);

end
