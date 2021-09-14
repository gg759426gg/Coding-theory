clc;close all;clear;
%環境：GF(2^4) 的(15,9)的RS code
%A為被除式 B為除式 C為商 D為餘式
%A/B=C...D
%X7 /b1X0+b2X1+b3X2+b4X3+b5X4+b6X5+b7X6
R=[6,-1,-1,4,14,10];
addone=[4,8,14,1,10,13,9,2,7,5,12,11,6,3]; %GF表
A=-ones(1,8);A(8)=0;    
C=zeros(3,2);
%% 特徵s(x)
s=-ones(1,6);
for i=1:6
    T=R(6);
    for y=5:-1:1
        T=gfMUL(i,T,addone);
        T=gfADD(T,R(y),addone);
    end
    s(i)=T;
end
B=[0,s];        %被除式B(x)為1+S(x)
%B=[0,11,5,3,11,9,8];    
%% 輾轉相除法 
%除法器 當被除式與除式不同長度時 不能一次除完

for i=1:3
    fprintf("被除式");
    fprintf("%d ",A(1:length(A)));
    fprintf("\n除式  ");
    fprintf("%d ",B(1:length(B)));
    [C(i,2),D]=gfDIV(A,B,addone); %A/B=C...D
    [C(i,1),D]=gfDIV([A(1),D],B,addone);%A/B=C...D
    fprintf("\n商式");
    fprintf("%d ",C(i,:));
    fprintf("\t");
    fprintf("\t餘式  ");
    fprintf("%d ",D(1:length(D)));
    fprintf("\n=====================================\n");
    A=B;B=D;
    %pause
end
%% 求出 OMEGA Ω
omega=D;
for i=1:length(D)
    if D(i)==-1
        omega(i)=-1;
    else
        omega(i)=D(i)-D(1);
        if omega(i)<0
            omega(i)=omega(i)+15;
        end
    end
end
fprintf("OMEGA Ω :");
fprintf("%d ",omega(1:length(omega)));
%% 求出 SIGMA σ
T=gfMUL(C(1,:),C(2,:),addone);  %T為暫存器
T=gfADD(0,T,addone);
T=gfMUL(C(3,:),T,addone);
T=gfADD(C(1,:),T,addone);
sigma=T;
for i=1:length(T)
    if T(i)==-1
        sigma(i)=-1;
    else
        sigma(i)=T(i)-T(1);
        if sigma(i)<0
            sigma(i)=sigma(i)+15;
        end
    end
end
fprintf(" SIGMA σ :");
fprintf("%d ",sigma(1:length(sigma)));

%% 求出根
root=zeros(1,3);
error=-ones(1,15);
sum=0;
for x=1:14
    T=sigma(4);         %T為暫存器
    for y=3:-1:1
        T=gfMUL(x,T,addone);   
        T=gfADD(T,sigma(y),addone);
    end
    if T==-1
        sum=sum+1;
        root(sum)=x;
    end
end
%% 求出錯誤值
location=15-root;
error(location(1)+1)=0;%X^0+X^1+...X^14
sum=0;

%將值帶入omega 得到error
for i=1:3
    T=omega(4);         %T為暫存器
    for y=3:-1:1
        T=gfMUL(root(i),T,addone);
        T=gfADD(T,omega(y),addone);
    end
    L=location;

    L(L==location(i))=[];
    for j=1:2
        T2=gfMUL(L(j),root(i),addone);
        T2=gfADD(T2,0,addone);
        T=T-T2;
        if T<0
            T=T+15;
        end
        error(location(i)+1)=T;
    end
    fprintf(" \nerror location:%d\t error value:%d",...
    location(i),error(location(i)+1));
end
fprintf("\n=====================================\n");

%% 糾正   correct of transmiision signal
%V(x)=r(x)+error(x)
correct=gfADD(R,error,addone);

fprintf("\n糾正後的V(x)信號 correct of transmiision signal:\n");
fprintf("%d ",correct);
fprintf("\n");
for i=1:15
    if correct(i)==-1
    else
        if i==1
            fprintf("α^%d",correct(i));   
        else
            fprintf(" +α^%dX^%d",correct(i),i-1);  
        end
    end
end






























