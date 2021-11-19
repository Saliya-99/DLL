datawords = mod(randi(2,1000,9),2); % generate 10**4 datawords with 9 bits
divisor = [1 0 1 1 1];
check = zeros(1,length(divisor)-1); % define a zero vector with the length is equal to (divisor length -1)
ErrorRates = []; %define a vector to store the error rates at differnet probabilities
prob = [];%define a vector to store the differnet probabilities
for p = 0:0.01:0.1 % change probability from 0 to 1
    count = 0; % variable to count codewords at reciever with errors
    for i = 1:1000
        dataword = datawords(i,:);
        cdword = Encoder(dataword, divisor);% encode for get the codeword
        cdword = bsc(cdword, p);%transmit through BSC channel
        syndrome = Decoder(cdword, divisor);% calculate syndrome at recioever
        if syndrome ~= check % check whether the syndrome is all zero or not
            count = count + 1;% if not, then increment error count by 1
        end
    end
    
    prob(end+1)=p;
    ErrorRates(end+1)=count/1000; % calculate error rates
end
plot(prob,ErrorRates);    
xlabel("Probability");
ylabel("Error rate");


            
        
