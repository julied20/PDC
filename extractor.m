%%% Extract bit from the text file in an array %%%

function data = extractor()
FileID = fopen('test.txt');
data = textscan(FileID, '%1d');
fclose(FileID);
celldisp(data)

end
