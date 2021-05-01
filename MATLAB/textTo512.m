%% A function to convert text to a multiple of 512

function text_ = textTo512(text)

binary = dec2bin(text,8);
[length width] = size(binary);

text_ = binary(1,:);

for i = 2:length
    text_ = [text_, binary(i,:)];    
end

% Count the number of bits

numOfBits = strlength(text_);
binaryNumOfBits = dec2bin(numOfBits,64);
text_ = [text_,'1'];

sum = numOfBits + 1 + 64;
sum = mod(sum,512);

numOfZeros = 512 - sum;

newText = text_;

for i = 1:numOfZeros
    newText = [newText,'0'];
end

newText = [newText, binaryNumOfBits];

text_ = newText;

strlength(newText);


end