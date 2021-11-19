function [bin] = Bin(RN)
bin = [];
while true
    
    bin = [mod(RN,2) bin];
    if floor(RN/2)==0
         
        break
    end
    RN = floor(RN/2);
end

        


end

