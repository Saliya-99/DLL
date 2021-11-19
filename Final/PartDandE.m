dataword = [1 0 1 0 0 1 1 1 1];
divisor = [1 0 1 1 1];
p = 0.5;
cdword = Encoder(dataword, divisor);%encode at sender
cdword = bsc(cdword, p);%transmit through the BSC channel
syndrome = Decoder(cdword, divisor);%decode at the reciever
display(cdword);%recived codeword at the reciever
display(syndrome);% Syndrome at the reciever