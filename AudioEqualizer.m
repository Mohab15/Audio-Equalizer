clear all
clc
prompt = 'Please type the name of the wave file(including .format) : ';
filename = input(prompt,'s');

db1=input('Please enter the gain (in dB) in the frequency 0~170 Hz : ');
db2=input('Please enter the gain (in dB) in the frequency 170~310 Hz : ');
db3=input('Please enter the gain (in dB) in the frequency 310~600 Hz : ');
db4=input('Please enter the gain (in dB) in the frequency 600~1k Hz : ');
db5=input('Please enter the gain (in dB) in the frequency 1k~3k Hz : ');
db6=input('Please enter the gain (in dB) in the frequency 3k~6k Hz : ');
db7=input('Please enter the gain (in dB) in the frequency 6k~12k Hz : ');
db8=input('Please enter the gain (in dB) in the frequency 12k~14k Hz : ');
db9=input('Please enter the gain (in dB) in the frequency 14k~16k Hz : ');

sample_rate=input('Please enter the desired sample rate for output : ');
while sample_rate < 10 || sample_rate >100000
    sample_rate=input('Invalid,Please re-enter the desired sampling rate : ');
end     %end While

choice = input('Please Enter the number of the desired filter:\n1.IIR\n2.FIR\nYour choice is : ');
while choice < 1 || choice > 2                                  %error handling 
            choice = input('please reenter your choice : ');    %error handling
end    %endWhile                                                %error handling

%--------------------------------------------------------------------------------
[mywave,Fs]=audioread(filename);
Fn=Fs/2;
if Fs <= 32000
    flag = 1;
    mywave=resample(mywave,40000,Fs);
    Fn=20000;       %Chose a random number to fit all frequency bands    
end     %end IF

Filtered0 = [];         %Total Filtered Composite output
Filtered1 = [];         %1st filter output  (partial signal)
Filtered2 = [];         %2nd filter output  (partial signal)
Filtered3 = [];         %3rd filter output  (partial signal)
Filtered4 = [];         %4th filter output  (partial signal)
Filtered5 = [];         %5th filter output  (partial signal)
Filtered6 = [];         %6th filter output  (partial signal)  
Filtered7 = [];         %7th filter output  (partial signal)
Filtered8 = [];         %8th filter output  (partial signal)
Filtered9 = [];         %9th filter output  (partial signal)

Wc1=[170];              Wc1n=Wc1/(Fn);            %Low -pass
Wc2=[170 310];          Wc2n=Wc2/(Fn);            %Band-Pass
Wc3=[310 600];          Wc3n=Wc3/(Fn);            %Band-Pass
Wc4=[600 1000];         Wc4n=Wc4/(Fn);            %Band-Pass
Wc5=[1000 3000];        Wc5n=Wc5/(Fn);            %Band-Pass
Wc6=[3000 6000];        Wc6n=Wc6/(Fn);            %Band-Pass
Wc7=[6000 12000];       Wc7n=Wc7/(Fn);            %Band-Pass
Wc8=[12000 14000];      Wc8n=Wc8/(Fn);            %Band-Pass
Wc9=[14000 16000];      Wc9n=Wc9/(Fn);            %Band-Pass

%----------------------------------------------------------------------------------
switch choice
    case 1  %IIR-FILTER
        fprintf('Processing... , Please wait!\n');
        
        [Z1,P1,K1]=butter(4,Wc1n);      [Num1,Den1]=zp2tf(Z1,P1,K1);        [H1]=freqz(Num1,Den1,Fs);       %Developing Filters
        [Z2,P2,K2]=butter(4,Wc2n);      [Num2,Den2]=zp2tf(Z2,P2,K2);        [H2]=freqz(Num2,Den2,Fs);       %Developing Filters
        [Z3,P3,K3]=butter(4,Wc3n);      [Num3,Den3]=zp2tf(Z3,P3,K3);        [H3]=freqz(Num3,Den3,Fs);       %Developing Filters
        [Z4,P4,K4]=butter(4,Wc4n);      [Num4,Den4]=zp2tf(Z4,P4,K4);        [H4]=freqz(Num4,Den4,Fs);       %Developing Filters
        [Z5,P5,K5]=butter(4,Wc5n);      [Num5,Den5]=zp2tf(Z5,P5,K5);        [H5]=freqz(Num5,Den5,Fs);       %Developing Filters
        [Z6,P6,K6]=butter(4,Wc6n);      [Num6,Den6]=zp2tf(Z6,P6,K6);        [H6]=freqz(Num6,Den6,Fs);       %Developing Filters
        [Z7,P7,K7]=butter(4,Wc7n);      [Num7,Den7]=zp2tf(Z7,P7,K7);        [H7]=freqz(Num7,Den7,Fs);       %Developing Filters
        [Z8,P8,K8]=butter(4,Wc8n);      [Num8,Den8]=zp2tf(Z8,P8,K8);        [H8]=freqz(Num8,Den8,Fs);       %Developing Filters
        [Z9,P9,K9]=butter(4,Wc9n);      [Num9,Den9]=zp2tf(Z9,P9,K9);        [H9]=freqz(Num9,Den9,Fs);       %Developing Filters
        
        Filtered1 = filter(Num1,Den1,mywave);       %Time domain filtered partial signals                
        Filtered2 = filter(Num2,Den2,mywave);       %Time domain filtered partial signals       
        Filtered3 = filter(Num3,Den3,mywave);       %Time domain filtered partial signals       
        Filtered4 = filter(Num4,Den4,mywave);       %Time domain filtered partial signals        
        Filtered5 = filter(Num5,Den5,mywave);       %Time domain filtered partial signals       
        Filtered6 = filter(Num6,Den6,mywave);       %Time domain filtered partial signals        
        Filtered7 = filter(Num7,Den7,mywave);       %Time domain filtered partial signals        
        Filtered8 = filter(Num8,Den8,mywave);       %Time domain filtered partial signals       
        Filtered9 = filter(Num9,Den9,mywave);       %Time domain filtered partial signals       
        
        Freq1 = fftshift(fft(Filtered1));   Freq1mag=abs(Freq1);    Freq1phase=angle(Freq1);        %Frequency domain of filtered partial signals
        Freq2 = fftshift(fft(Filtered2));   Freq2mag=abs(Freq2);    Freq2phase=angle(Freq2);        %Frequency domain of filtered partial signals
        Freq3 = fftshift(fft(Filtered3));   Freq3mag=abs(Freq3);    Freq3phase=angle(Freq3);        %Frequency domain of filtered partial signals
        Freq4 = fftshift(fft(Filtered4));   Freq4mag=abs(Freq4);    Freq4phase=angle(Freq4);        %Frequency domain of filtered partial signals
        Freq5 = fftshift(fft(Filtered5));   Freq5mag=abs(Freq5);    Freq5phase=angle(Freq5);        %Frequency domain of filtered partial signals
        Freq6 = fftshift(fft(Filtered6));   Freq6mag=abs(Freq6);    Freq6phase=angle(Freq6);        %Frequency domain of filtered partial signals
        Freq7 = fftshift(fft(Filtered7));   Freq7mag=abs(Freq7);    Freq7phase=angle(Freq7);        %Frequency domain of filtered partial signals
        Freq8 = fftshift(fft(Filtered8));   Freq8mag=abs(Freq8);    Freq8phase=angle(Freq8);        %Frequency domain of filtered partial signals
        Freq9 = fftshift(fft(Filtered9));   Freq9mag=abs(Freq9);    Freq9phase=angle(Freq9);        %Frequency domain of filtered partial signals
        
        while 1
            choice2 = input('\nWhat would you like to do?\n1.View Filters responses\n2.View Filters Impulse and step responses\n3.View Time and Freq representation of filtered output\n4.Continue the process\nYour choice is : ');
            while choice2 < 1 || choice2 > 4
                choice2 = input('invalid choice , please re-enter : ');
            end %end While (ERROR HANDLING)
            
            switch choice2
                
                case 1  %Filter's respose
                    close all
                    fprintf('Processing... , Please wait!\n');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H1));                 title('Magnitude response of filter #1 ,range ( 0 ~ 170Hz )');            %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H1)*180/pi);        title('Phase response of filter #1 , range( 0 ~ 170Hz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H2));                 title('Magnitude response of filter #2 ,range ( 170 ~ 310Hz )');         %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H2)*180/pi);        title('Phase response of filter #2 , range( 170 ~ 310Hz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H3));                 title('Magnitude response of filter #3 ,range ( 310 ~ 600Hz )');         %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H3)*180/pi);        title('Phase response of filter #3 , range( 310 ~ 600Hz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H4));                 title('Magnitude response of filter #4 ,range ( 600 ~ 1kHz )');          %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H4)*180/pi);        title('Phase response of filter #4 , range( 600 ~ 1kHz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H5));                 title('Magnitude response of filter #5 ,range ( 1k ~ 3kHz )');           %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H5)*180/pi);        title('Phase response of filter #5 , range( 1k ~ 3kHz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H6));                 title('Magnitude response of filter #6 ,range ( 3k ~ 6kHz )');           %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H6)*180/pi);        title('Phase response of filter #6 , range( 3k ~ 6kHz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H7));                 title('Magnitude response of filter #7 ,range ( 6k ~ 12kHz )');          %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H7)*180/pi);        title('Phase response of filter #7 , range( 6k ~ 12kHz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H8));                 title('Magnitude response of filter #8 ,range ( 12k ~ 14kHz )');         %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H8)*180/pi);        title('Phase response of filter #8 , range( 12k ~ 14kHz )');
                    figure;  
                    subplot(2,2,[1,2]);     plot(abs(H9));                 title('Magnitude response of filter #9 ,range ( 14k ~ 16kHz )');        %Filter's mag response
                    subplot(2,2,[3,4]);     plot(angle(H9)*180/pi);        title('Phase response of filter #9 , range( 14k ~ 16kHz )');
                       
                case 2  %Impulse and step responses
                    close all
                    fprintf('Processing... , Please wait!\n');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num1,Den1,50);     title('Impulse response of filter #1');
                    subplot(2,2,[3,4]);     stepz(Num1,Den1,50);    title('Step response of filter #1');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num2,Den2,50);     title('Impulse response of filter #2');
                    subplot(2,2,[3,4]);     stepz(Num2,Den2,50);    title('Step response of filter #2');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num3,Den3,50);     title('Impulse response of filter #3');
                    subplot(2,2,[3,4]);     stepz(Num3,Den3,50);    title('Step response of filter #3');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num4,Den4,50);     title('Impulse response of filter #4');
                    subplot(2,2,[3,4]);     stepz(Num4,Den4,50);    title('Step response of filter #4');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num5,Den5,50);     title('Impulse response of filter #5');
                    subplot(2,2,[3,4]);     stepz(Num5,Den5,50);    title('Step response of filter #5');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num6,Den6,50);     title('Impulse response of filter #6');
                    subplot(2,2,[3,4]);     stepz(Num6,Den6,50);    title('Step response of filter #6');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num7,Den7,50);     title('Impulse response of filter #7');
                    subplot(2,2,[3,4]);     stepz(Num7,Den7,50);    title('Step response of filter #7');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num8,Den8,50);     title('Impulse response of filter #8');
                    subplot(2,2,[3,4]);     stepz(Num8,Den8,50);    title('Step response of filter #8');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num9,Den9,50);     title('Impulse response of filter #9');
                    subplot(2,2,[3,4]);     stepz(Num9,Den9,50);    title('Step response of filter #9');
                    
                case 3  %Filtered output time and freq representations
                    close all
                    fprintf('Processing... , Please wait!\n');
                    range=(-length(Freq1)/2 : length(Freq1)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered1);        title('Time domain representation of filtered output #1');
                    subplot(3,2,[3,4]);         plot(range,Freq1mag);   title('Mag response of filtered output #1');
                    subplot(3,2,[5,6]);         plot(range,Freq1phase); title('Phase response of filtered output #1');
        
                    range=(-length(Freq2)/2 : length(Freq2)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered2);        title('Time domain representation of filtered output #2');
                    subplot(3,2,[3,4]);         plot(range,Freq2mag);   title('Mag response of filtered output #2');
                    subplot(3,2,[5,6]);         plot(range,Freq2phase); title('Phase response of filtered output #2');
        
                    range=(-length(Freq3)/2 : length(Freq3)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered3);        title('Time domain representation of filtered output #3');
                    subplot(3,2,[3,4]);         plot(range,Freq3mag);   title('Mag response of filtered output #3');
                    subplot(3,2,[5,6]);         plot(range,Freq3phase); title('Phase response of filtered output #3');
        
                    range=(-length(Freq4)/2 : length(Freq4)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered4);        title('Time domain representation of filtered output #4');
                    subplot(3,2,[3,4]);         plot(range,Freq4mag);   title('Mag response of filtered output #4');
                    subplot(3,2,[5,6]);         plot(range,Freq4phase); title('Phase response of filtered output #4');
        
                    range=(-length(Freq5)/2 : length(Freq5)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered5);        title('Time domain representation of filtered output #5');
                    subplot(3,2,[3,4]);         plot(range,Freq5mag);   title('Mag response of filtered output #5');
                    subplot(3,2,[5,6]);         plot(range,Freq5phase); title('Phase response of filtered output #5');
        
                    range=(-length(Freq6)/2 : length(Freq6)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered6);        title('Time domain representation of filtered output #6');
                    subplot(3,2,[3,4]);         plot(range,Freq6mag);   title('Mag response of filtered output #6');
                    subplot(3,2,[5,6]);         plot(range,Freq6phase); title('Phase response of filtered output #6');
        
                    range=(-length(Freq7)/2 : length(Freq7)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered7);        title('Time domain representation of filtered output #7');
                    subplot(3,2,[3,4]);         plot(range,Freq7mag);   title('Mag response of filtered output #7');
                    subplot(3,2,[5,6]);         plot(range,Freq7phase); title('Phase response of filtered output #7');
        
                    range=(-length(Freq8)/2 : length(Freq8)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered8);  title('Time domain representation of filtered output #8');
                    subplot(3,2,[3,4]);         plot(range,Freq8mag);   title('Mag response of filtered output #8');
                    subplot(3,2,[5,6]);         plot(range,Freq8phase); title('Phase response of filtered output #8');
        
                    range=(-length(Freq9)/2 : length(Freq9)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered9);        title('Time domain representation of filtered output #9');
                    subplot(3,2,[3,4]);         plot(range,Freq9mag);   title('Mag response of filtered output #9');
                    subplot(3,2,[5,6]);         plot(range,Freq9phase); title('Phase response of filtered output #9');
                    
                case 4  %Filteration continues
                    close all
                    fprintf('\nFilteration process continues..\n');
                    fprintf('Processing... , Please wait!\n');
                    break
                    
            end     %end Switch
        end     %end While
              
%--------------------
        close all
        Filtered1 = 10^(db1/20).*Filtered1;     %Amplifying the filtered partial signals
        Filtered2 = 10^(db2/20).*Filtered2;     %Amplifying the filtered partial signals
        Filtered3 = 10^(db3/20).*Filtered3;     %Amplifying the filtered partial signals
        Filtered4 = 10^(db4/20).*Filtered4;     %Amplifying the filtered partial signals
        Filtered5 = 10^(db5/20).*Filtered5;     %Amplifying the filtered partial signals
        Filtered6 = 10^(db6/20).*Filtered6;     %Amplifying the filtered partial signals
        Filtered7 = 10^(db7/20).*Filtered7;     %Amplifying the filtered partial signals
        Filtered8 = 10^(db8/20).*Filtered8;     %Amplifying the filtered partial signals
        Filtered9 = 10^(db9/20).*Filtered9;     %Amplifying the filtered partial signals
               
%----------------------------------------------------------------------------------------------------------------------------------------
    case 2  %FIR-FILTERS
        close all
        Order=input('please Enter the desired FIR-filter order : ');
        fprintf('Processing... , Please wait!\n');
        
        [Num1]=fir1(Order,Wc1n,blackman(Order+1));      [H1,W1]=freqz(Num1);        %Developing Filters
        [Num2]=fir1(Order,Wc2n,blackman(Order+1));      [H2,W2]=freqz(Num2);        %Developing Filters
        [Num3]=fir1(Order,Wc3n,blackman(Order+1));      [H3,W3]=freqz(Num3);        %Developing Filters     
        [Num4]=fir1(Order,Wc4n,blackman(Order+1));      [H4,W4]=freqz(Num4);        %Developing Filters
        [Num5]=fir1(Order,Wc5n,blackman(Order+1));      [H5,W5]=freqz(Num5);        %Developing Filters
        [Num6]=fir1(Order,Wc6n,blackman(Order+1));      [H6,W6]=freqz(Num6);        %Developing Filters
        [Num7]=fir1(Order,Wc7n,blackman(Order+1));      [H7,W7]=freqz(Num7);        %Developing Filters
        [Num8]=fir1(Order,Wc8n,blackman(Order+1));      [H8,W8]=freqz(Num8);        %Developing Filters
        [Num9]=fir1(Order,Wc9n,blackman(Order+1));      [H9,W9]=freqz(Num9);        %Developing Filters
        
        Filtered1 = filter(Num1,1,mywave);      %Time domain filtered partial signals                
        Filtered2 = filter(Num2,1,mywave);      %Time domain filtered partial signals     
        Filtered3 = filter(Num3,1,mywave);      %Time domain filtered partial signals       
        Filtered4 = filter(Num4,1,mywave);      %Time domain filtered partial signals        
        Filtered5 = filter(Num5,1,mywave);      %Time domain filtered partial signals       
        Filtered6 = filter(Num6,1,mywave);      %Time domain filtered partial signals        
        Filtered7 = filter(Num7,1,mywave);      %Time domain filtered partial signals        
        Filtered8 = filter(Num8,1,mywave);      %Time domain filtered partial signals       
        Filtered9 = filter(Num9,1,mywave);      %Time domain filtered partial signals
        
        Freq1 = fftshift(fft(Filtered1));           Freq1mag=abs(Freq1);    Freq1phase=angle(Freq1);        %Frequency domain filtered partial signals
        Freq2 = fftshift(fft(Filtered2));           Freq2mag=abs(Freq2);    Freq2phase=angle(Freq2);        %Frequency domain filtered partial signals
        Freq3 = fftshift(fft(Filtered3));           Freq3mag=abs(Freq3);    Freq3phase=angle(Freq3);        %Frequency domain filtered partial signals
        Freq4 = fftshift(fft(Filtered4));           Freq4mag=abs(Freq4);    Freq4phase=angle(Freq4);        %Frequency domain filtered partial signals
        Freq5 = fftshift(fft(Filtered5));           Freq5mag=abs(Freq5);    Freq5phase=angle(Freq5);        %Frequency domain filtered partial signals
        Freq6 = fftshift(fft(Filtered6));           Freq6mag=abs(Freq6);    Freq6phase=angle(Freq6);        %Frequency domain filtered partial signals
        Freq7 = fftshift(fft(Filtered7));           Freq7mag=abs(Freq7);    Freq7phase=angle(Freq7);        %Frequency domain filtered partial signals
        Freq8 = fftshift(fft(Filtered8));           Freq8mag=abs(Freq8);    Freq8phase=angle(Freq8);        %Frequency domain filtered partial signals
        Freq9 = fftshift(fft(Filtered9));           Freq9mag=abs(Freq9);    Freq9phase=angle(Freq9);        %Frequency domain filtered partial signals
        
        while 1
            choice2 = input('\nWhat would you like to do?\n1.View Filters responses\n2.View Filters Impulse and step responses\n3.View Time and Freq representation of filtered output\n4.Continue the process\nYour choice is : ');
            while choice2 < 1 || choice2 > 4
                choice2 = input('invalid choice , please re-enter : ');
            end %end While (ERROR HANDLING)
            
            switch choice2
                case 1  %Filter's respose
                    close all
                    fprintf('Processing... , Please wait!\n');
                    figure;
                    subplot(2,2,[1,2]);     plot(W1,abs(H1));               title('Time domain representation of FIR filter #1 ,range ( 0 ~ 170Hz )');                             %Time domain response 
                    subplot(2,2,[3,4]);     plot(W1/pi,20*log10(abs(H1)));  title('Magnitude response of FIR filter #1 ,range ( 0 ~ 170Hz )');          ylabel('magnitude (dB)');  %Frequncy domaon response
                    figure;
                    subplot(2,2,[1,2]);     plot(W2,abs(H2));               title('Time domain representation of FIR filter #2 ,range ( 170 ~ 310Hz )');                           %Time domain response
                    subplot(2,2,[3,4]);     plot(W2/pi,20*log10(abs(H2)));  title('Magnitude response of FIR filter #2 ,range ( 170 ~ 310Hz )');        ylabel('magnitude (dB)');  %Frequncy domaon response  
                    figure;
                    subplot(2,2,[1,2]);     plot(W3,abs(H3));               title('Time domain representation of FIR filter #2 ,range ( 310 ~ 600Hz )');                            %Time domain response
                    subplot(2,2,[3,4]);     plot(W3/pi,20*log10(abs(H3)));  title('Magnitude response of FIR filter #2 ,range ( 310 ~ 600Hz )');        ylabel('magnitude (dB)');   %Frequncy domaon response
                    figure;
                    subplot(2,2,[1,2]);     plot(W4,abs(H4));               title('Time domain representation of FIR filter #4 ,range ( 600 ~ 1kHz )');                             %Time domain response
                    subplot(2,2,[3,4]);     plot(W4/pi,20*log10(abs(H4)));  title('Magnitude response of FIR filter #4 ,range ( 600 ~ 1kHz )');         ylabel('magnitude (dB)');   %Frequncy domaon response
                    figure;
                    subplot(2,2,[1,2]);     plot(W5,abs(H5));               title('Time domain representation of FIR filter #5 ,range ( 1k ~ 3kHz )');                              %Time domain response
                    subplot(2,2,[3,4]);     plot(W5/pi,20*log10(abs(H5)));  title('Magnitude response of FIR filter #5 ,range ( 1k ~ 3kHz )');          ylabel('magnitude (dB)');   %Frequncy domaon response
                    figure;
                    subplot(2,2,[1,2]);     plot(W6,abs(H6));               title('Time domain representation of FIR filter #6 ,range ( 3k ~ 6kHz )');                              %Time domain response
                    subplot(2,2,[3,4]);     plot(W6/pi,20*log10(abs(H6)));  title('Magnitude response of FIR filter #6 ,range ( 3k ~ 6kHz )');          ylabel('magnitude (dB)');   %Frequncy domaon response  
                    figure;
                    subplot(2,2,[1,2]);     plot(W7,abs(H7));               title('Time domain representation of FIR filter #7 ,range ( 6k ~ 12kHz )');                             %Time domain response
                    subplot(2,2,[3,4]);     plot(W7/pi,20*log10(abs(H7)));  title('Magnitude response of FIR filter #7 ,range ( 6k ~ 12kHz )');         ylabel('magnitude (dB)');   %Frequncy domaon response
                    figure;
                    subplot(2,2,[1,2]);     plot(W8,abs(H8));               title('Time domain representation of FIR filter #8 ,range ( 12k ~ 14kHz )');                            %Time domain response
                    subplot(2,2,[3,4]);     plot(W8/pi,20*log10(abs(H8)));  title('Magnitude response of FIR filter #8 ,range ( 12k ~ 14kHz )');        ylabel('magnitude (dB)');   %Frequncy domaon response
                    figure;
                    subplot(2,2,[1,2]);     plot(W9,abs(H9));               title('Time domain representation of FIR filter #9 ,range ( 14k ~ 16kHz )');                            %Time domain response
                    subplot(2,2,[3,4]);     plot(W9/pi,20*log10(abs(H9)));  title('Magnitude response of FIR filter #9 ,range ( 14k ~ 16kHz )');        ylabel('magnitude (dB)');   %Frequncy domaon response
                    
                case 2  %Impulse and step responses
                    close all
                    fprintf('Processing... , Please wait!\n');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num1,1,50);        title('Impulse response of filter #1');
                    subplot(2,2,[3,4]);     stepz(Num1,1,50);       title('Step response of filter #1');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num2,1,50);        title('Impulse response of filter #2');
                    subplot(2,2,[3,4]);     stepz(Num2,1,50);       title('Step response of filter #2');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num3,1,50);        title('Impulse response of filter #3');
                    subplot(2,2,[3,4]);     stepz(Num3,1,50);       title('Step response of filter #3');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num4,1,50);        title('Impulse response of filter #4');
                    subplot(2,2,[3,4]);     stepz(Num4,1,50);       title('Step response of filter #4');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num5,1,50);        title('Impulse response of filter #5');
                    subplot(2,2,[3,4]);     stepz(Num5,1,50);       title('Step response of filter #5');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num6,1,50);        title('Impulse response of filter #6');
                    subplot(2,2,[3,4]);     stepz(Num6,1,50);       title('Step response of filter #6');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num7,1,50);        title('Impulse response of filter #7');
                    subplot(2,2,[3,4]);     stepz(Num7,1,50);       title('Step response of filter #7');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num8,1,50);        title('Impulse response of filter #8');
                    subplot(2,2,[3,4]);     stepz(Num8,1,50);       title('Step response of filter #8');
                    figure;
                    subplot(2,2,[1,2]);     impz(Num9,1,50);        title('Impulse response of filter #9');
                    subplot(2,2,[3,4]);     stepz(Num9,1,50);       title('Step response of filter #9');
                    
                case 3  %Filtered output time and freq representations
                    close all
                    fprintf('Processing... , Please wait!\n');
                    range=(-length(Freq1)/2 : length(Freq1)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered1);        title('Time domain representation of filtered output #1');
                    subplot(3,2,[3,4]);         plot(range,Freq1mag);   title('Mag response of filtered output #1');
                    subplot(3,2,[5,6]);         plot(range,Freq1phase); title('Phase response of filtered output #1');
        
                    range=(-length(Freq2)/2 : length(Freq2)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered2);        title('Time domain representation of filtered output #2');
                    subplot(3,2,[3,4]);         plot(range,Freq2mag);   title('Mag response of filtered output #2');
                    subplot(3,2,[5,6]);         plot(range,Freq2phase); title('Phase response of filtered output #2');
        
                    range=(-length(Freq3)/2 : length(Freq3)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered3);        title('Time domain representation of filtered output #3');
                    subplot(3,2,[3,4]);         plot(range,Freq3mag);   title('Mag response of filtered output #3');
                    subplot(3,2,[5,6]);         plot(range,Freq3phase); title('Phase response of filtered output #3');
        
                    range=(-length(Freq4)/2 : length(Freq4)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered4);        title('Time domain representation of filtered output #4');
                    subplot(3,2,[3,4]);         plot(range,Freq4mag);   title('Mag response of filtered output #4');
                    subplot(3,2,[5,6]);         plot(range,Freq4phase); title('Phase response of filtered output #4');
        
                    range=(-length(Freq5)/2 : length(Freq5)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered5);        title('Time domain representation of filtered output #5');
                    subplot(3,2,[3,4]);         plot(range,Freq5mag);   title('Mag response of filtered output #5');
                    subplot(3,2,[5,6]);         plot(range,Freq5phase); title('Phase response of filtered output #5');
        
                    range=(-length(Freq6)/2 : length(Freq6)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered6);        title('Time domain representation of filtered output #6');
                    subplot(3,2,[3,4]);         plot(range,Freq6mag);   title('Mag response of filtered output #6');
                    subplot(3,2,[5,6]);         plot(range,Freq6phase); title('Phase response of filtered output #6');
        
                    range=(-length(Freq7)/2 : length(Freq7)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered7);        title('Time domain representation of filtered output #7');
                    subplot(3,2,[3,4]);         plot(range,Freq7mag);   title('Mag response of filtered output #7');
                    subplot(3,2,[5,6]);         plot(range,Freq7phase); title('Phase response of filtered output #7');
        
                    range=(-length(Freq8)/2 : length(Freq8)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered8);        title('Time domain representation of filtered output #8');
                    subplot(3,2,[3,4]);         plot(range,Freq8mag);   title('Mag response of filtered output #8');
                    subplot(3,2,[5,6]);         plot(range,Freq8phase); title('Phase response of filtered output #8');
        
                    range=(-length(Freq9)/2 : length(Freq9)/2-1);
                    figure;
                    subplot(3,2,[1,2]);         plot(Filtered9);        title('Time domain representation of filtered output #9');
                    subplot(3,2,[3,4]);         plot(range,Freq9mag);   title('Mag response of filtered output #9');
                    subplot(3,2,[5,6]);         plot(range,Freq9phase); title('Phase response of filtered output #9');
                    
                case 4  %Filteration continues
                    close all
                    fprintf('\nFilteration process continues..\n');
                    fprintf('Processing... , Please wait!\n');
                    break
                    
            end     %end Switch
        end     %end While
%--------------------
        Filtered1 = 10^(db1/10).*Filtered1;     %Amplifying the filtered partial signals
        Filtered2 = 10^(db2/10).*Filtered2;     %Amplifying the filtered partial signals
        Filtered3 = 10^(db3/10).*Filtered3;     %Amplifying the filtered partial signals
        Filtered4 = 10^(db4/10).*Filtered4;     %Amplifying the filtered partial signals
        Filtered5 = 10^(db5/10).*Filtered5;     %Amplifying the filtered partial signals
        Filtered6 = 10^(db6/10).*Filtered6;     %Amplifying the filtered partial signals
        Filtered7 = 10^(db7/10).*Filtered7;     %Amplifying the filtered partial signals
        Filtered8 = 10^(db8/10).*Filtered8;     %Amplifying the filtered partial signals
        Filtered9 = 10^(db9/10).*Filtered9;     %Amplifying the filtered partial signals
               
end %endSwitch
%-----------------------------------------------------------------------------------
close all
if flag ==1
    mywave=resample(mywave,Fs,40000); %sampling abck to original frequency in case the original frequency caused error to any bandwidth of the filters        
end     %end IF

Filtered0 = Filtered1 + Filtered2 + Filtered3 + Filtered4 + Filtered5 + Filtered6 + Filtered7 + Filtered8 + Filtered9;      %Adding the amplified  filtered outputs to form a composite signal
Freq0 = fftshift(fft(Filtered0));               Freq0mag=abs(Freq0);    Freq0phase=angle(Freq0);    %Frequency domain of composite signal

mywave;
mywave_Freq = fftshift(fft(mywave));            mywavemag=abs(mywave);  mywavephase=angle(mywave);  %Frequency domain of original signal

range=(-length(mywave_Freq)/2 : length(mywave_Freq)/2-1);
figure;
subplot(3,2,[1,2]);         plot(mywave);                title('Time domain representation of Original Signal');
subplot(3,2,[3,4]);         plot(range,mywavemag);       title('Mag response of Original Signal');
subplot(3,2,[5,6]);         plot(range,mywavephase);     title('Phase response of Original Signal');

range=(-length(Freq0)/2 : length(Freq0)/2-1);
figure;
subplot(3,2,[1,2]);         plot(Filtered0);             title('Time domain representation of filtered Composite Signal BEFORE RESAMPLING');
subplot(3,2,[3,4]);         plot(range,Freq0mag);        title('Mag response of filtered Composite Signal BEFORE RESAMPLING');
subplot(3,2,[5,6]);         plot(range,Freq0phase);      title('Phase response of filtered Composite Signal BEFORE RESAMPLING');

audiowrite('New.wav',Filtered0,sample_rate);

[Filtered0,Fs]=audioread('New.wav');

%-----------------------------------------------------------------------------------------
while 1
    choice3 = input('what would you like to do ?\n1.View the signal after resampling\n2.Close all figures\n3.Play The output sound\n4.Stop the output sound\n5.Exit\nYour choice is : ');
    while choice3 < 1 || choice3 > 5
        choice3 = input('please re-enter your choice : ');
    end     %end while
    switch choice3
        
        case 1
            Freq0 = fftshift(fft(Filtered0));               Freq0mag=abs(Freq0);    Freq0phase=angle(Freq0);    %Frequency domain of composite signal
            range=(-length(Freq0)/2 : length(Freq0)/2-1);
            figure;
            subplot(3,2,[1,2]);         plot(Filtered0);             title('Time domain representation of filtered Composite Signal AFTER RESAMPLING');
            subplot(3,2,[3,4]);         plot(range,Freq0mag);        title('Mag response of filtered Composite Signal after resampling AFTER RESAMPLING');
            subplot(3,2,[5,6]);         plot(range,Freq0phase);      title('Phase response of filtered Composite Signalafter resampling AFTER RESAMPLING');
            
        case 2
            close all
            
        case 3
            sound(Filtered0,sample_rate);
            
        case 4
            clear sound
            
        case 5
            clear sound
            close all
            fprintf('Thanks!\n');
            break
    end     %end Switch
    
end     %end While
%----------------------------------------------------------------------------------------
%%DONE%%
