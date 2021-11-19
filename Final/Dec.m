function [num] = Dec(bin)
num = 0;
for i=1:length(bin)
    num = num +( 2 ^ ((i-1))) * bin(1, length(bin)-i+1);
end

end

