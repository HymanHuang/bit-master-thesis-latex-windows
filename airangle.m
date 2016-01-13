function [alpha,beta,V]=airangle(u,v,w)
alpha=atan2(w,u);
V=sqrt(u.*u+v.*v+w.*w);
beta=asin(v/V);