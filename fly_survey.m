function fly_survey()
%
% Wrapper script to run the nonlinear Simulink model
% Aaron Holtzman <aaron@holtzman.ca>
%
clear
addpath flight_model

% Initial conditions
kt_to_ms = 0.514444;
Xo = zeros(9,1);
Xo(1) = 40*kt_to_ms;                    %u
Xo(2) = 0;                              %v
Xo(3) = 0;                              %w
Xo(4) = 0;                              %p
Xo(5) = 0;                              %q
Xo(6) = 0;                              %r
Xo(7) = 0;                              %phi
Xo(8) = 0;                              %theta
% Xo(9) = -0.2415;                      %psi
Xo(9) = 0.785;                           %psi


% Run the sim
% initial_pos = [[44.9555 -76.9603] * pi / 180 500]; % lat/long
initial_pos = [0 0 0]; % lat/long north/east
% assignin('base', 'Xo', Xo);
% assignin('base', 'initial_pos', initial_pos);
% mdl = 'gsII_uas';
% set_param(mdl,'SaveOutput','on','OutputSaveName','xout','SaveFormat','array');
% sim(mdl, 5, []);
[xout,tout,Pe, Pedot, dpsi, dpsidot]=simulatemodel(Xo,initial_pos);
t = tout;
X = xout(:,1:9);
pos = xout(:,10:12);
U = xout(:,13:16);
%L=xout(:,17);
% unpack the sim output
u = X(:,1);
v = X(:,2);
w = X(:,3);
p = X(:,4);
q = X(:,5);
r = X(:,6);
phi   = X(:,7);
theta = X(:,8);
%psi   = -X(:,9) + pi;
psi = atan2(sin(X(:,9) + pi/2),-cos(X(:,9) + pi/2));

% x = pos(:,2) * 180 / pi; % latitude in degrees
% y = pos(:,1) * 180 / pi; % longitude in degrees
% z = pos(:,3);            % altitude in metres
x = pos(:,2); % latitude in degrees
y = pos(:,1); % longitude in degrees
z = pos(:,3);            % altitude in metres
y(1:10)

alpha = atan2(w, u);
airspeed = sqrt(u.^2 + v.^2 + w.^2);
beta = asin(v ./ airspeed);

hold on;
plot(x, y,'r');
grid
hold off

% Plot the outputs
figure('color','white')
subplot(3,1,1) 
plot(t, u, t, v, t, w);
grid
legend('u','v','w'); 
subplot(3,1,2) 
plot(t, p, t, q, t, r); 
legend('p','q','r');
grid
subplot(3,1,3) 
plot(t, phi, t, theta,t, psi); 
legend('\Phi','\theta','\psi');
grid
%plot(t, psi);
figure('color','white')   
subplot(2,1,1); 
grid
line_x = [0  100];%laltitude
line_y = [0  100];%longitude
% plot(x, y, 'k*'); 
% xm=(x-line_x(1))*6371000;
% ym=(y-line_y(1))*6371000;
xm=(x-line_x(1));
ym=(y-line_y(1));
plot(xm,ym,'r');
grid
title('¹ì¼£¸ú×Ù'); 
xlabel(' x(m)'); 
ylabel('y(m)'); 
%axis equal
hold on
% line_x = [-76.9603  -76.9758];
% line_y = [ 44.9550   44.9997];
% lx=[0,line_x(2)-line_x(1)]*6371000;
% ly=[0,line_y(2)-line_y(1)]*6371000;
%line(line_x, line_y);
line(line_x,line_y);
hold off

subplot(2,1,2); 
plot(t, z); 
title('Altitude'); 
xlabel('Time (s)');
ylabel('Alititude (m)');
grid

figure('color','white')
subplot(3,1,1)
title('Controls');
plot(t, U(:,1) * 180 / pi, t, U(:,2) * 180 / pi, t, U(:,3) * 180 / pi)
legend('Aileron','Elevator','Rudder'); 
ylabel('Angle (degrees)');
xlabel('time(seconds)')
grid
subplot(3,1,2)
plot(t, airspeed );
grid
ylabel('Airspeed (m/s)');
subplot(3,1,3)
plot(t, alpha * 180 / pi, t, beta * 180 / pi);
ylabel('Angle (degrees)');
legend('Alpha', 'Beta');
grid
% figure('color','white')(5)
% plot(t,L);
% title('Lift');

figure('color','white')
subplot(2,1,1)
plot(tout,Pe);
grid
title('e_p')
xlabel('time(secods)')
ylabel('e_p(m)')
subplot(2,1,2)
plot(tout,Pedot)
grid
title('de_p/dt')
figure('color','white')
subplot(2,1,1)
plot(tout,dpsi)
title('\psi')
grid
subplot(2,1,2)
plot(tout,dpsidot);
title('r')
grid

