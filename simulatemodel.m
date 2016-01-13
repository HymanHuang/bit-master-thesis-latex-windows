function [xout,tout,Pe, Pedot, dpsi, dpsidot] = simulatemodel(Xo,initial_pos);
xk=Xo;
posk=initial_pos';
steps=2000;
x=zeros(steps,9);
pos=zeros(steps,3);
u=zeros(steps,4);
Pe=zeros(1,steps);
Pedot=zeros(1,steps);
dpsi=zeros(1,steps);
dpsidot=zeros(1,steps);
timestep=0.001;
for k=1:steps;
[uk,Pek, Pedotk, dpsik, dpsidotk]=autopilot(xk,posk);
u(k,:)=uk;
Pe(1,k)=Pek;
Pedot(1,k)=Pedotk;
dpsi(1,k)=dpsik;
dpsidot(1,k)=dpsidotk;
Xdot=flightmodel(xk,uk);
posdot=navigation(xk,posk);
xk=xk+Xdot*timestep;
posk=posk+posdot*timestep;
x(k,:)=xk';
pos(k,:)=posk';
end
xout=[x,pos,u];
tout=timestep*(1:steps);


