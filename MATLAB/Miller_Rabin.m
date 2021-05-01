% A function to determine whether a number is prime

function status = Miller_Rabin(num)

numless = num - 1;% Finds one less than the number being tested
count = 0; %Initialises the counter to zero

%% Determines count and the odd number 
while mod(numless,2) == 0 % For as long as numless is not an odd numbera:
    count = count + 1;%Increment count by one
    numless = numless/2;%Update numless to numless/2
end

%% Determining the primality of num
check = 0;
k = 200;
d = numless;

for i = 1:k % Iterate k times:
    a = randi([2,num-2]);  %Generate a random number
    x = powermod(a,d,num); %Find x
    s = count; % Specify the value of s
    
    if x == 1 || x == num - 1 % If x is 1 or one less than the number being tested:
        continue;%Skip the remaining steps
    end
    
    for j = 1:s %Iterate s times:
        x = powermod(x,2,num);% Find x
        if x == num-1 %If x is one less than the number being tested:
            check = 1;%Skip the remaining steps in the main for loop 
            break;
        end
    end
    
    if check == 1
        check = 0;
        continue;
    end
    
    if check == 0% If x is not one less than the number being tested:
        status = 0;% num is composite
        return;
    end    
end

status = 1;% Otherwise, num is prime
return

end