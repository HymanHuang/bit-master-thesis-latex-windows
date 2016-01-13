function posdot=navigation(x,pos)
u=x(1);
v=x(2);
w=x(3);
p=x(4);
q=x(5);
r=x(6);
phi=x(7);
theta=x(8);
psi=x(9);
h=pos(3);
%SbtoSg
dcm=[cos(theta)*cos(psi)    cos(theta)*sin(psi) -sin(theta);
 sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) cos(phi)*sin(psi)  cos(phi)*cos(psi);
 cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi) sin(phi)*sin(theta)*sin(psi)
]; 
R=6371000;
Vb=[u;v;w];
Vg=dcm'*Vb;
Vn=Vg(1);
Ve=Vg(2);
Vh=-Vg(3);
% posdot=[Vn/(R+h);Ve/(R+h);Vh];
posdot=[Vn;Ve;Vh];



% function dcm=body_inertial(phi,theta,psi)
% dcm=[cos(theta)*cos(psi)    cos(theta)*sin(psi) -sin(theta);
%  sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) cos(phi)*sin(psi)  cos(phi)*cos(psi);
%  cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi) sin(phi)*sin(theta)*sin(psi)
% ];