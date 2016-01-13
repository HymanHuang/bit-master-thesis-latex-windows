function [Pe, Pedot, dpsi, dpsidot] = guidance(x, pos)
%
% Controller based on:
%
% Performance and Lyapunov Stability of a Nonlinear Path-Following Guidance Method
%  Sanghyuk Park, John Deyst, and Jonathan P. How
%  DOI 10.2514/1.28957
%

% FIXME  flight plan is hardcoded here
line_x = [0  100];%laltitude
line_y = [0  100];%longitude
pathslope=(line_y(2)-line_y(1))/(line_x(2)-line_x(1));
k=pathslope;
xn=pos(1);
yn=pos(2);
Pe=(k*xn-yn)/sqrt(1+k.^2);
u=x(1);
v=x(2);
dpsi=atan(k)-x(9);
Vt=sqrt(u.^2+v.^2);
Pedot=Vt*dpsi;
r=x(6);
dpsidot=-r;
