function [syndrome] = Decoder(codeword,divisor)
sizeOfdivisor = size(divisor);

%modulo 2 division

count = sizeOfdivisor(2);
word = codeword(1:count);
while true
    c = xor(word, divisor);
    g = find(c==0);
    
    for i=1:length(g)
        if g(i)==i
            c(1) =  [];
        end
    end
    
    if sizeOfdivisor(2)-length(c) > length(codeword)-count
        syndrome = [c codeword(count+1:end)];
        syndrome = [zeros(1, length(divisor)-length(syndrome)-1) syndrome];
        break;
    end
    
    for i = 1:sizeOfdivisor(2)-length(c)
        c(end+1) = codeword(count+1);
        count = count +1;
    end
    word = c; 
end  
end

