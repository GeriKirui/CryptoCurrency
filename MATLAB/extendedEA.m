% A function to find the private key h

function h = extendedEA(n,s)

%% Initialisation of a 2x2 matrix
matrix(1,:) = n; % The top row becomes the value n
matrix(2,1) = s; % The bottom left value becomes the value s
matrix(2,2) = 1; % The bottom right value becomes the value 1

while matrix(2,1) ~= 1 % For as long as the bottom left value is not equal to one:
        
    quo = floor(matrix(1,1)/matrix(2,1));% Find the largest integer less than the quotient of matrix(1,1) divided by matrix(2,1)
    temp = matrix(2,:); % Store the secondn row in a temporary variable
    matrix(2,:) = quo*matrix(2,:); % Multiply the second row by the quotient
    matrix(2,:) = matrix(1,:) - matrix(2,:); % Subtract the second row and add the first row, to the second row
    matrix(2,:) = mod(matrix(2,:),n); % mod the second row to get rid of negative values
    matrix(1,:) = temp; %Shift the rows up by one 
    
end

h = matrix(2,2); % The private key h is now the bottom right value

end