clc;
clear all;
divisor = [1 0 0 0 0 0 1 1 1];%pre define the divisor for encoder and decoder
check = zeros(1,length(divisor)-1);
fprintf("Enter the following inputs\nNumber of frames should be in between 0 and 256\nNumber of bytes should be 2(no isssue if it increased, but it will take lot of time)\nProbabilities should be between 0 and 1\n")
frames = input("Enter the number of frames(0-256): ");
len = input("Enter the frame length(number of data bytes)(0-2): ");
p = input("Enter the error probability of forward direction: ");
p1 = input("Enter the error probability of feedback direction: ");% get inputs from user for number of frames, number of bytes in a frame
%error probability for forward and feedback directions
datawords = randi([0,1],frames,len*8);%create datawords list with a given number of bytes of data

SN = 0;
RN = 0;% first, sequence number and request number is equal to zero
NumOfTransmissions = 0;% first number of transmission is equal to zero
ACK = [zeros(1, 8-length(Bin(RN))) Bin(RN) datawords(SN+1,:)];% for initialize the transmission, create an artificial ACK frame 
%with request number 0 and fed it in to the sender
cdwrd = Encoder(ACK,divisor);
trcdwrd = cdwrd;
% for initialize the transmission, create an artificial ACK frame 
%with request number 0 and fed it in to the sender
fprintf("Initialized transmission!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
while true
    %% sender side
 
    if Decoder(trcdwrd, divisor) == check
        if (SN==  Dec(trcdwrd(:, 1:8)))||(SN+1 ==Dec(trcdwrd(:, 1:8))); 
            SN = Dec(trcdwrd(:, 1:8));%length(trcdwrd)-length(datawords(SN,:))-length(divisor)-1+2));
        end
    end
    %first, sender decode the ACK frame from the reciever and check for
    %errors. if there is error in ACK frame, sender transmit previous frame
    %again. if there is no any detectable error in ACK frame, sender
    %extract the request number from the frame(fist 8 bits) and convert it
    %into decimel for find the frame number which is request by recuiver
    %and transmit it

    fprintf("Transmitter is requested by reciever for frame %d and transmitted it\n", SN);
    
    
    frame = [zeros(1, 8-length(Bin(RN))) Bin(SN) datawords(SN+1,:)];%create frame with requested frame number by reciever
    codeword = Encoder(frame,divisor);%Encode that frame
    
    trmtdcodeword = bsc(codeword,p);%transmit through channel
    NumOfTransmissions = NumOfTransmissions + 1;%increment number of transmission count by 1
    %%
    %% Reciver side
    syndrome = Decoder(trmtdcodeword, divisor);%reciever find syndrme ana check it for errors
    if (syndrome == check) & (Dec(trmtdcodeword(:, 1:8)) == RN)
        fprintf("Correctly recieved frame %d in reciever\n", SN);
        %SN = SN + 1;
        RN = SN + 1;
    else
        fprintf("Not Correctly recieved frame %d in reciever\n", SN);
        RN = SN;
    end
    %if there is an error in frame transmitted by Tx, reciever send ACK
    %with exsisiting RN and if there is no any error, reciever send ACK to
    %Tx with next RN
    
    ACK = [zeros(1, 8-length(Bin(RN))) Bin(RN) datawords(SN+1,:)];%create frame before transmit
    fprintf("Reciever sent a request to transmitter for frame %d\n", RN);
    if RN == frames
        fprintf("All the frames have successfully transmitted.\nTransmission Ended!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;
    end
    cdwrd = Encoder(ACK,divisor);%encode and transmit
    trcdwrd = bsc(cdwrd, p1);
    %%
end

display(NumOfTransmissions);
