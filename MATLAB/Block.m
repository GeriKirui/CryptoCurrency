%% A class to hold information of a single block

classdef Block<handle
    properties
        timestamp
        transaction
        previousHash
        hash
        dummy= 0
    end
    
    methods
        function obj = Block(timestamp, data)
        obj.timestamp = timestamp;
        obj.transaction = data;
        obj.hash = obj.calcHash;
        end
        
        function toSHA = calcHash(obj)
        
         fromadress = ' ';
         toadress = ' ';
         amount = ' ';
         
         numTrans = size(obj.transaction,2);
         
         for i=1:numTrans
             fromadress = [fromadress obj.transaction(i).fromAddress];
             toadress = [toadress obj.transaction(i).toAddress];
             amount = [amount obj.transaction(i).amount];
         end
         
         
         toSHA = [obj.timestamp fromadress toadress amount obj.previousHash obj.dummy];
         toSHA = SHA256(toSHA);        
        end
        
        function mineBlock(obj,diff)
            arr = zeros(1,diff) + 48;
            arr = char(arr);
            while ~strcmp(obj.hash(1,1:diff),arr)
                obj.dummy = obj.dummy + 1;
                obj.hash = obj.calcHash;
            end
        end
        
        function status = hasValidTransactions(obj)
            
            numOfTrans = size(obj.transaction,2);
            
            for j=1:numOfTrans
                if ~obj.transaction(j).isValid()
                    status = false;
                    return;
                end
            end
            
            status = true;
        end
    end
end