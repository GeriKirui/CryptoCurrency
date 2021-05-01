%% A class to hold information of a single member of a digital payment system

classdef Members<handle
    properties
        privateKey
        publicKey
        amount
    end
    
    methods
        function obj = Members(publicKey, privateKey, amount)
            obj.privateKey = double(privateKey);
            obj.publicKey = double(publicKey);
            obj.amount = amount;
        end
    end
end