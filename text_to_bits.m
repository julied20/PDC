%%% Extract bit from the text file in an array %%%

function data = text_to_bits()

%open the file that contains the text
fileID = fopen('text.txt');
transmission = fopen('transmission.txt', 'w');
% ASCII binary notation uses 7 bits
bin_txt = dec2bin(fread(fileID), 7);
% x are nb_char and y nb_bits
[x, y] = size(bin_txt);
% transform the array in a String of bits
String_of_bits = reshape(bin_txt', 1, x*y);
fprintf(transmission, String_of_bits, '%d');
fclose(fileID);
fclose(transmission);

data = extractor('transmission.txt');

end
