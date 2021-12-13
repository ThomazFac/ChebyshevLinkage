function [x,y] = chebyshevmov(L1,L2,L3,L4,theta2,t,t2max,t2min)
% Function that return the movement of the Chebyshev mecanism

cx=L2*cos(theta2);
cy=L2*sin(theta2);

sinal=length(t);
aux=1;
for cont=1 : 1 : length(t)
    if (theta2(cont)<=t2min*1.0001)||(theta2(cont)>=t2max*.9995)
        aux = aux*-1;
    end
    sinal(cont)=aux;
end

% Vectors with the coordinates of the D point:

dx=length(t);
dy=length(t);
for cont=1 : 1 : length(t)
    Cx=cx(cont);
    Cy=cy(cont);
    
    s=sinal(cont);
    
    alfa=(L3^2+L1^2-L4^2-Cx^2-Cy^2)/(2*(L1-Cx));
    beta=Cy/(L1-Cx);
    a=1+beta^2;
    b=2*alfa*beta-2*L1*beta;
    c=L1^2-2*L1*alfa+alfa^2-L4^2;
    
    Dy=(-b+s*sqrt(b^2-4*a*c))/(2*a);
    Dx=alfa+Dy*beta;
    
    dx(cont)=Dx;
    dy(cont)=Dy;
    
end

px=length(t);
py=length(t);

for cont=1 : 1 : length(t)
    Cx=cx(cont);
    Cy=cy(cont);
    Dx=dx(cont);
    Dy=dy(cont);
    
    Px=Cx+((Dx-Cx)/2);
    Py=Cy+((Dy-Cy)/2);
    
    px(cont)=Px;
    py(cont)=Py;
end

% Array with de coodinates of the C, D and points:
x = [cx; dx; px];
y = [cy; dy; py];

end
