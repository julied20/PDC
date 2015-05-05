%%% Extract bit from the text file in an array %%%

function data = transmitter()
FileID = fopen('test.txt');
%str = '0.41 8.24 3.57 6.24 9.27';
%data = textscan(str,'%f');
data = textscan(FileID, '%1d');
fclose(FileID);
celldisp(data)
end
