function [e,d,n,phi] = RSA()

max = 2.^32;
p = sym(3494053);
q = sym(3471463);
phi = (p-1)*(q-1);
n = p*q;

%% Finds e, the public key
while (1 > 0)
    e = sym(randi([2,max-1]));
    condition = gcd(e,phi);
    if condition == 1
        break
    end    
end

%% Finds d, the private key
d = extendedEA(phi,e);
e;
phi;


end