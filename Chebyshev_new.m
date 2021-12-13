clc
close all
clear all

% Length of the Chebyshev mecanism links
L1 = 4;
L2 = L1/4*5;
L3 = L1/2;
L4 = L2;

% ANIMATION PARAMETERS
w = pi/2; % Motor angular velocity
T = 8; % Period
t = 0:1/30:T; % Time vector

% Input angle limits
t2max = acos((L1^2+L2^2-(L4+L3)^2)/(2*L1*L2));
t2min = acos((L2^2+L1^2-((L4-L3)^2))/(2*L2*L1));

% Defining points 2 and 4
O2 = [0, 0];
O4 = [L1, 0];

% Function that design a supply mecanism to attach the Chebyshev
% mecanism to a rotor
[A,S,Q,P,L] = motormec(L2,t2max,t2min);

% Function that return the movement of the motor mecanism
[theta2,x1,y1] = motormov(t,S,Q,P,A,w);

% Function that return the movement of the Chebyshev mecanism
[x,y] = chebyshevmov(L1,L2,L3,L4,theta2,t,t2max,t2min);

xmin=-4;
xmax=6;
ymin=-1;
ymax=6;

fig1 = figure;

for i = 1:length(t)-1
    clf
    
    plot([x(1,i) x(2,i)],[y(1,i) y(2,i)],'g','linewidth',2)
    
    hold on
    
    plot([O2(1) x(1,i)],[O2(2) y(1,i)],'r','linewidth',2)
    plot([O4(1) x(2,i)],[O4(2) y(2,i)],'b','linewidth',2)
    plot([A(1) x1(1,i)],[A(2) y1(1,i)],'r','linewidth',2)
    plot([x1(1,i) x1(2,i)],[y1(1,i) y1(2,i)],'g','linewidth',2)
    
    plot(x(3,:),y(3,:),'--k','linewidth',.5)
    plot(x1(1,:),y1(1,:),'--k','linewidth',.5)
    plot([O2(1) O4(1)],[O2(2) O4(2)],'--k','linewidth',.5)
    
    plot(A(1),A(2),'.k','MarkerSize', 15);
    plot(x(3,i),y(3,i),'.k','MarkerSize', 15)
    plot(x1(1,i),y1(1,i),'.k','MarkerSize', 15);
    plot(x1(2,i),y1(2,i),'.k','MarkerSize', 15);
    plot(O2(1),O2(2),'.k',O4(1),O4(2),'.k','MarkerSize', 15)
    plot(x(1,i),y(1,i),'.k',x(2,i),y(2,i),'.k','MarkerSize', 15)
    
    hold off
    title('Chebyshev Mecanism Animation')
    xlabel('x(m)')
    ylabel('y(m)')
    axis equal
    axis ([xmin,xmax,ymin,ymax])
    
    movieVector(i) = getframe(fig1, [10 10 520 400]);
    
end

myWriter = VideoWriter('animation', 'MPEG-4');
myWriter.FrameRate = 20;
open(myWriter);
writeVideo(myWriter, movieVector);
close(myWriter);



