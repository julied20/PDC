function data = extractor(file)

FileID = fopen(file);
data = textscan(FileID, '%s');
%data = fscanf(FileID, '%1d');
fclose(FileID);
data = data{1}{1};
size(data, 2)
data
if ( mod(size(data, 2),2) ~= 0) 
    data = strcat(data, '0');
end
size(data,2)
data

A = [];
for i = 1:2:size(data, 2)
A = [A; strcat(data(i), data(i+1))];
end
data = A
end
