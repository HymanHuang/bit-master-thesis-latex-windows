function [U,Pe, Pedot, dpsi, dpsidot]=autopilot(x,pos)

u=x(1);
v=x(2);
w=x(3);
p=x(4);
q=x(5);
r=x(6);
phi=x(7);
pitch=x(8);
psi=x(9);
[alpha,beta,V]=airangle(u,v,w);
%µ¼º½
% [roll_target, pitch_target, test_point] = guidance(x, pos);
[Pe, Pedot, dpsi, dpsidot] = guidance(x, pos);
%¿ØÖÆ
%aileron
% Kp=1.2;
% Kphi=0.75/1.2;
% delta_a=Kp*(Kphi*(roll_target-phi)-p);
% up=15 * pi / 180;
% down=-15 * pi / 180;
% delta_a=sat(delta_a,up,down);
delta_a=0;

%elevator
% Kq=-0.92214419446365;
% Kpitch=(-1.66972905223625)/(-0.92214419446365);
% delta_e=Kq*(Kpitch*(pitch_target-pitch)-q);
% up=15 * pi / 180;
% down=-15 * pi / 180;
% delta_e=sat(delta_e,up,down);
delta_e = 0;

% %Rudder
% Kr=-0.4;
% Kbeta=(-1)/(-0.4);
% yaw_target=0;
% delta_r=Kr*(Kbeta*(yaw_target-beta)-r);
% up=15 * pi / 180;
% down=-15 * pi / 180;
% delta_r=sat(delta_r,up,down);
%Rudder
K5=4.78;
K6=6.51;
K7=4.13;
K8=1.11;
K7=0;
K8=0;
delta_r=K5*Pe+K6*Pedot+K7*dpsi+K8*dpsidot;
up=15 * pi / 180;
down=-15 * pi / 180;
delta_r=sat(delta_r,up,down);

%throttle
Kv=0.4;
V_target=25;
delta_t=Kv*(V_target-V);

U=[delta_a,delta_e,delta_r,delta_t];

function y=sat(x,up,down);
y=x;
if x>up;
    y=up;
end
if x<down;
    y=down;
end