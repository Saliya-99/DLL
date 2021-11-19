function [cdwrd] = Encoder(dataword,divisor)
sizeOfdivisor = size(divisor);% length of the divisor
agdataword = dataword;
%%%%%%
%add 0 s to dataword to get augmented dataword before modulo 2 division
for i=1:sizeOfdivisor(2)-1
    agdataword(end+1)=0;        
end
%%%%%%%%

%%%%%%%%
%modulo 2 division
count = sizeOfdivisor(2);
count1 = 1;
word = agdataword(count1:count);
sizeOfagdataword = size(agdataword);

while true
    
    c = xor(word, divisor);
    g = find(c==0);
    for i=1:length(g)
        if g(i)==i
            c(1) =  [];
        end
    end
    if sizeOfdivisor(2)-length(c) > length(agdataword)-count
        remainder = [c agdataword(count+1:end)];
        for i=0: length(divisor)-1-length(remainder)-1
            remainder = [0 remainder];% add zeros to make remainder length is equal to (divisior length -1)
        end
        break;
    end
    for i = 1:sizeOfdivisor(2)-length(c)
        c(end+1) = agdataword(count+1);
        count = count +1;
    end
    word = c;
end
cdwrd = [dataword remainder]; % after get the remainder, it combined with the dataword to get the codeword
end

