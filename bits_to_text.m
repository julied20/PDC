% conversion bits to text
function bits_to_text()

    %%% Extract bit from the text file in an array %%%


    FileID = fopen('resultbits.txt');
    data = fscanf(FileID, '%s');
    fclose(FileID);
    
    if(mod(size(data),7) ~= 0 )
       data = data(1:end-1);
    end
    
    %data = char(data);
    [x, y] = size(data); 
    nb_char = x*y/7;
    dec_txt = bin2dec(reshape(data, 7, nb_char)');
    result = native2unicode(dec_txt);
    result = reshape(result, 1, nb_char);
    
    finaltext = fopen('result.txt', 'w');
    fprintf(finaltext, result);
    fclose(finaltext);
    
end

