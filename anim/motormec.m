function [A,S,Q,P,L] = motormec (L2,t2max,t2min)
% Design the motor mecanism attached to the main mecanism
% Paramenters: Limit angles and length of the input link of the main
% mecanism
% Output: Fixed points coordinates and link lengths of the secondary
% mecanism

P = L2*2/5; % Link 4 length

% Limit positions of D point:
D1 = [P*cos(t2min), P*sin(t2min)];
D2 = [P*cos(t2max), P*sin(t2max)];

% Length of the link attached to the rotor:
a = (sqrt((D1(1)-D2(1))^2+(D2(2)-D1(2))^2))/2;
S = a;
Q = P*1.5; % Estimating the link 3 length

alfa = atan((D2(2)-D1(2))/(D1(1)-D2(1))); % Slope of the line that passes in D1 and D2

% Use Grashof condition to calculate the link 1 length and the rotor
% coordinate (A) by iteration with increment in the length:

i = 0;
while i==0
    A(1) = -((S+Q)*cos(alfa)-D1(1));
    
    A(2) = (S+Q)*sin(alfa)+D1(2);
    
    L = sqrt(A(1)^2+A(2)^2);
    
    if S+L >= P+Q
        Q = Q*1.1;
    else
        i=1;
    end
end
end