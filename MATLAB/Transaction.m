%% A class to handle information in a transaction

classdef Transaction<handle
    properties
        fromAddress = '0'
        toAddress = '0'
        amount
        time
        signature = -1
    end
    
    methods
        function obj = Transaction(fromAddress, toAddress, amount)
            obj.fromAddress = num2str(double(fromAddress));
            obj.toAddress = num2str(double(toAddress));
            obj.amount = amount;
            obj.time = char(datetime('now'));
        end
        
        function sign(obj,d,n)

            arr = [obj.fromAddress obj.toAddress obj.amount obj.time];
            
            x = SHA256(arr);
            
            hash_ = sprintf('text2int("%s",16)', x);
            hash_ = sym(evalin(symengine,hash_));
            
            hash_ = mod(hash_,n);           
            obj.signature = double(powermod(sym(hash_),d,n));
           
        end
        
        function status = isValid(obj,signature,e,n)
            
            if obj.fromAddress == 00
                status = true;
                return;
            end
            
            if obj.signature == -1
                status = true;
                return;
            end

            arr = [obj.fromAddress obj.toAddress obj.amount obj.time];            
            x = SHA256(arr);            
            hash_ = sprintf('text2int("%s",16)', x);
            hash_ = sym(evalin(symengine,hash_));            
            hash_ = mod(hash_,n);            
            check = powermod(sym(signature),e,n); 
            
            if double(hash_) == double(check)
                status = true;
                return;
            else
                status = false;
                return;
            end
            
        end
    end
end