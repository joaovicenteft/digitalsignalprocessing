% NRZ_Encoder Line codes encoder
%[time,output,Fs]=NRZ_Encoder(input,Rb,amplitude,style)
%NRZ_Encoder NRZ encoder
%Input a stream of bits and specify bit-Rate, amplitude of the output signal and the style of encoding

function [time,output,Fs]= NRZ_Encoder(input,Rb,amplitude,style)
Fs=16*Rb; %Sampling frequency ,
%oversampling factor = 32
Ts=1/Fs; % Sampling Period
Tb=1/Rb; % Bit period
output=[];
switch lower(style)
    case {'manchester'}
        for count=1:length(input),
            for tempTime=0:Ts:Tb/2-Ts,
                output=[output (-1)^(input(count))*amplitude];
            end
            for tempTime=Tb/2:Ts:Tb-Ts,
                output=[output (-1)^(input(count)+1)*amplitude];
            end
        end
    % 0 ou 1 variando randomicamente, em relação a amplitude
    case {'unipolar'}
        for count=1:length(input), 
            for tempTime=0:Ts:Tb-Ts,
                output=[output input(count)*amplitude];
            end
        end
    case {'polar'}
        k = 0;
        for count=1:length(input)
            for tempTime=0:Ts:Tb-Ts
                if input(count) == 0
                   output=[output 0];
                elseif input(count) == 1
                    if k == 0
                        output=[output amplitude*(-1)^1];
                    elseif k == 1
                        output=[output amplitude*(-1)^2];
                        
                    end
                end
            end
            if k == 0
                k = 1;
            elseif k == 1
                k = 0;
            end
        end
    otherwise,
        disp('NRZ_Encoder(input,Rb,amplitude,style)-Unknown method given as ''style'' argument');
        disp('Accepted Styles are ''Manchester'', ''Unipolar'' and ''Polar''');
end

time=0:Ts:Tb*length(input)-Ts;

