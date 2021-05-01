%% The SHA-256 hash function code

function hash = SHA256(text)

hash = "01";

%% Find k constants and initial hashes

x = dec2bin(hex2dec('6a09e667'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash0 = y;

x = dec2bin(hex2dec('bb67ae85'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash1 = y;

x = dec2bin(hex2dec('3c6ef372'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash2 = y;
x = dec2bin(hex2dec('a54ff53a'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash3 = y;
x = dec2bin(hex2dec('510e527f'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash4 = y;
x = dec2bin(hex2dec('9b05688c'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash5 = y;
x = dec2bin(hex2dec('1f83d9ab'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end

initialHash6 = y;

x = dec2bin(hex2dec('5be0cd19'), 32);
x = convertStringsToChars(x);
y = zeros(1,32);

for i = 1:32
    y(i) = str2num(x(i));
end
initialHash7 = y;

% k constants

constants(1:64,:) = ['428a2f98'; '71374491'; 'b5c0fbcf'; 'e9b5dba5'; '3956c25b'; '59f111f1'; '923f82a4'; 'ab1c5ed5';...
            'd807aa98'; '12835b01'; '243185be'; '550c7dc3'; '72be5d74'; '80deb1fe'; '9bdc06a7'; 'c19bf174';...
            'e49b69c1'; 'efbe4786'; '0fc19dc6'; '240ca1cc'; '2de92c6f'; '4a7484aa'; '5cb0a9dc'; '76f988da';...
            '983e5152'; 'a831c66d'; 'b00327c8'; 'bf597fc7'; 'c6e00bf3'; 'd5a79147'; '06ca6351'; '14292967';...
            '27b70a85'; '2e1b2138'; '4d2c6dfc'; '53380d13'; '650a7354'; '766a0abb'; '81c2c92e'; '92722c85';...
            'a2bfe8a1'; 'a81a664b'; 'c24b8b70'; 'c76c51a3'; 'd192e819'; 'd6990624'; 'f40e3585'; '106aa070';...
            '19a4c116'; '1e376c08'; '2748774c'; '34b0bcb5'; '391c0cb3'; '4ed8aa4a'; '5b9cca4f'; '682e6ff3';...
            '748f82ee'; '78a5636f'; '84c87814'; '8cc70208'; '90befffa'; 'a4506ceb'; 'bef9a3f7'; 'c67178f2'];

newText = textTo512(text);
newText = convertStringsToChars(newText);
matrix = zeros(1,512);
hash = newText;
begin = 1;
end_ = 512; 

strlength(newText);

for q = 1:(strlength(newText))/512
    for i =begin:end_
        tempMatrix(i) = str2num(newText(i));
    end
    
    tempLength = length(tempMatrix);
    matrix = tempMatrix(1,tempLength - 511:tempLength);
    
    begin = begin + 512;
    end_ = end_ + 512;
    
    newMatrix = zeros(64,32);
    
    newMatrix(1,:) = matrix(1,1:32);
    
    for k = 1:16
        newMatrix(k,:) = matrix(1,(k-1)*32+1:k*32);
    end
    
    %% Rotations
    
    for currentRow = 17:64
        
        row1 = newMatrix(currentRow-15,:);
        row2 = newMatrix(currentRow-15,:);
        row3 = newMatrix(currentRow-15,:);
        
        row1 = circshift(row1,[0 7]);
        row2 = circshift(row2,[0 18]);
        
        dummyRow = zeros(1,32);
        dummyRow(1,4:32) = row3(1,1:29);
        row3 = dummyRow;
        
        row4 = newMatrix(currentRow-2,:);
        row5 = newMatrix(currentRow-2,:);
        row6 = newMatrix(currentRow-2,:);
        
        row4 = circshift(row4,[0 17]);
        row5 = circshift(row5,[0 19]);
        
        dummyRow = zeros(1,32);
        dummyRow(1,11:32) = row6(1,1:22);
        row6 = dummyRow;
        
        xor1 = xor(row1,row2);
        xor1 = xor(xor1,row3);
        
        xor2 = xor(row4,row5);
        xor2 = xor(xor2,row6);
        
        decXor1 = bin2dec(num2str(xor1));
        decXor2 = bin2dec(num2str(xor2));
        decRow1 = bin2dec(num2str(newMatrix(currentRow-16,:)));
        decRow2 = bin2dec(num2str(newMatrix(currentRow-7,:)));
        
        
        result1 = decXor1 + decRow1;
        result2 = decXor2 + decRow2;
        
        result = mod(result1+result2, 2.^32);
        result = dec2bin(result,32);
        
        newMatrix(currentRow,:) = result - 48;
    end
    
    %% Shift and Choose Functions
    
    % T1
    a = initialHash0;
    b = initialHash1;
    c = initialHash2;
    d = initialHash3;
    e = initialHash4;
    f = initialHash5;
    g = initialHash6;
    h = initialHash7;
    
    for i = 1:64
        dummyVar1 = e;
        dummyVar2 = e;
        dummyVar3 = e;
        dummyVar1 = circshift(dummyVar1, [0 6]);
        dummyVar2 = circshift(dummyVar2, [0 11]);
        dummyVar3 = circshift(dummyVar3, [0 25]);
        xor1 = xor(dummyVar1,dummyVar2);
        xor2 = xor(xor1,dummyVar3);
        
        
        ch1 = and(e,f);
        ch2 = not(e);
        ch3 = and(ch2,g);
        res =  xor(ch1,ch3);
        
        %num = dec2bin(hex2dec(constants(i,:)),32);
        
        decSum = bin2dec(num2str(h)) + bin2dec(num2str(xor2)) + bin2dec(num2str(res)) + hex2dec(constants(i,:)) + bin2dec(num2str(newMatrix(i,:)));
        T1 = mod(decSum,2.^32);
        
        
        % T2
        
        dummyVar1 = a;
        dummyVar2 = a;
        dummyVar3 = a;
        dummyVar1 = circshift(dummyVar1, [0 2]);
        dummyVar2 = circshift(dummyVar2, [0 13]);
        dummyVar3 = circshift(dummyVar3, [0 22]);
        xor1 = xor(dummyVar1,dummyVar2);
        xor2 = xor(xor1,dummyVar3);
        
        maj1 = and(a,b);
        maj2 = and(a,c);
        maj3 = and(b,c);
        majRes = xor(xor(maj1,maj2),maj3);
        
        T2 = bin2dec(num2str(xor2)) + bin2dec(num2str(majRes));
        T2 = mod(T2,2.^32);
        
        
        h = g;
        g = f;
        f = e;
        sum = bin2dec(num2str(d)) + T1;
        sum = mod(sum,2.^32);
        e = dec2bin(sum,32) - '0';
        
        d = c;
        c = b;
        b = a;
        sum = T1 + T2;
        sum = mod(sum,2.^32);
        a = dec2bin(sum,32) - '0';
    end
    
    hash0 = bin2dec(num2str(initialHash0)) + bin2dec(num2str(a));
    hash0 = mod(hash0,2.^32);
    initialHash0 = dec2bin(hash0, 32) - '0';
    
    hash1 = bin2dec(num2str(initialHash1)) + bin2dec(num2str(b));
    hash1 = mod(hash1,2.^32);
    initialHash1 = dec2bin(hash1, 32) - '0';
    
    hash2 = bin2dec(num2str(initialHash2)) + bin2dec(num2str(c));
    hash2 = mod(hash2,2.^32);
    initialHash2 = dec2bin(hash2, 32) - '0';
    
    hash3 = bin2dec(num2str(initialHash3)) + bin2dec(num2str(d));
    hash3 = mod(hash3,2.^32);
    initialHash3 = dec2bin(hash3, 32) - '0';
    
    hash4 = bin2dec(num2str(initialHash4)) + bin2dec(num2str(e));
    hash4 = mod(hash4,2.^32);
    initialHash4 = dec2bin(hash4, 32) - '0';
    
    hash5 = bin2dec(num2str(initialHash5)) + bin2dec(num2str(f));
    hash5 = mod(hash5,2.^32);
    initialHash5 = dec2bin(hash5, 32) - '0';
    
    hash6 = bin2dec(num2str(initialHash6)) + bin2dec(num2str(g));
    hash6 = mod(hash6,2.^32);
    initialHash6 = dec2bin(hash6, 32) - '0';
    
    hash7 = bin2dec(num2str(initialHash7)) + bin2dec(num2str(h));
    hash7 = mod(hash7,2.^32);
    initialHash7 = dec2bin(hash7, 32) - '0';
end

initialHash0 = dec2hex(bin2dec(num2str(initialHash0)), 8);
initialHash1 = dec2hex(bin2dec(num2str(initialHash1)), 8);
initialHash2 = dec2hex(bin2dec(num2str(initialHash2)), 8);
initialHash3 = dec2hex(bin2dec(num2str(initialHash3)), 8);
initialHash4 = dec2hex(bin2dec(num2str(initialHash4)), 8);
initialHash5 = dec2hex(bin2dec(num2str(initialHash5)), 8);
initialHash6 = dec2hex(bin2dec(num2str(initialHash6)), 8);
initialHash7 = dec2hex(bin2dec(num2str(initialHash7)), 8);


hash = [initialHash0 initialHash1 initialHash2 initialHash3 initialHash4 initialHash5 initialHash6 initialHash7];

end