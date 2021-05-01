%% A class to handle information of a block chain

classdef BlockChain<handle
    properties
        chain
        diff = 1
        pendingTransactions
        miningReward = '80';
    end
    
    methods
        function obj = BlockChain()
            obj.chain = obj.createGenBlock();
            obj.pendingTransactions = [];
        end
        
        function genBlock = createGenBlock(obj)
            trans = Transaction('gen', ' ', ' ');
            
            genBlock = Block(char(datetime('now')), trans);
        end
        
        function latestBlock = getLatestBlock(obj)
            lengthOfChain = size(obj.chain,2);
            latestBlock = obj.chain(lengthOfChain);
        end
        
        function minePendingTransactions(obj, miningRewardAddress)
            block = Block(char(datetime('now')), obj.pendingTransactions);
            block.mineBlock(obj.diff);
            
            obj.chain = [obj.chain block];
            
            obj.pendingTransactions = Transaction(00, miningRewardAddress, obj.miningReward);
                
        end
        
        function addTransaction(obj, transaction)
        

            obj.pendingTransactions = [obj.pendingTransactions transaction];
        end
        
        function balance = getBalanceOfAddress(obj, address)
        
            address = num2str(double(address));
            balance = 0;
            
            chainLength = size(obj.chain, 2);      
            
            
            for i = 1:chainLength
                numOfTrans = size(obj.chain(i).transaction,2);
                for j=1:numOfTrans
                     if strcmp(obj.chain(i).transaction(j).fromAddress,address)
                         balance = balance - str2num(obj.chain(i).transaction(j).amount);
                     end
                     
                     if strcmp(obj.chain(i).transaction(j).toAddress,address)
                         balance = balance + str2num(obj.chain(i).transaction(j).amount);
                     end
                end
                
            end
        end
        

        function status = isChainValid(obj)
            lengthOfChain = size(obj.chain, 2);            
            
            for i = 2:lengthOfChain
                currentBlock = obj.chain(i);
                prevBlock = obj.chain(i-1);
                
                if ~currentBlock.hasValidTransactions()
                    status = false;
                end
                
                if ~strcmp(currentBlock.hash, currentBlock.calcHash)
                    status = false;
                    return;
                end
                
                if ~strcmp(currentBlock.previousHash, prevBlock.hash)
                    status = false;
                    return;
                end                
                
            end
            status = true;
        end
    end
end