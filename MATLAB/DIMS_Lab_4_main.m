clc
clear

KiruiCoin = BlockChain;
%% Participants of the digital token payment system
[e,d,n,phi] = RSA();
Bob = Members(e,d,'0');
[e,d,n,phi] = RSA();
Alice = Members(e,d,'0');

fprintf("Bob is a member of the digital token payment system\n");
fprintf("Alice is a member of the digital token payment system\n");

fprintf("\n\n");

%% Valid transaction of R100 from Alice to Bob

fprintf("Attempting to transfer R100 from Alice to Bob with Alice's signature: ")
t1 = Transaction(Alice.publicKey,Bob.publicKey, '100');
t1.sign(Alice.privateKey, n);

if t1.isValid(t1.signature, Alice.publicKey,n)
    disp("The transaction is valid and successful.");
else
    disp("Invalid transaction")    
end

fprintf("\n\n");

%% Invalid transaction of R50 from Alice to Bob

fprintf("Attempting to transfer R50 from Alice to Bob without Alice's signature: ")
t2 = Transaction(Alice.publicKey,Bob.publicKey,'50');
t2.sign(Bob.privateKey,n);

if t2.isValid(t2.signature, Alice.publicKey,n)
    disp("The transaction is valid and successful.");
else
    disp("Invalid transaction")    
end

fprintf("\n")

%% Adding transaction 1 to the block chain

fprintf("Attempting to mine a block with difficulty 1. Please wait...")
[e,d,n,phi] = RSA();

KiruiCoin.addTransaction(t1);
tic;
%% Time taken to mine a block with difficulty 2
KiruiCoin.minePendingTransactions(Alice.publicKey);
toc;

