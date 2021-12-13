function [theta2,x1,y1] = motormov(t,S,Q,P,A,w)
% Function that return the movement of the motor mecanism

theta = t*w; % Vector with the rotor angle
theta2 = zeros(1); % Vector with the output angle

% Position of the crank
C = [A(1)+S*cos(theta); A(2)+S*sin(theta)];

dx = length(t);
dy = length(t);

for cont=1: length(t)
    
    Cx = C(1, cont);
    Cy = C(2, cont);
    
    alfa=(P^2-Q^2+Cx^2+Cy^2)/(2*Cx);
    beta=-Cy/Cx;
    
    a=(1+beta^2);
    b=2*alfa*beta;
    c=alfa^2-P^2;
    
    Dy=(-b+sqrt(b^2-4*a*c))/(2*a);
    Dx=alfa+Dy*beta;
    
    dx(cont)=Dx;
    dy(cont)=Dy;
    
    theta2(cont) = acos(Dx/P);
    
end

x1 = zeros(length(t),2);
y1 = zeros(length(t),2);

% Return two vectors with the position of the links attached to the
% rotor and main mecanism

x1 = [C(1, :); dx];
y1 = [C(2, :); dy];

end