function [C,D]=gfDIV(A,B,addone)
an=length(A);
bn=length(B);
T=zeros(1,bn);%暫存器
%% 判斷最高項視否為0a 
if A(an)==-1
    D=(A(1:length(A)-1)); 
    C=-1;
else
    %找A最大項/B最大項 放入商式
    C=A(an)-B(bn);
    if C<0
        C=C+15;
    end

    %乘法與加法
    for i=length(B):-1:1
        %乘法
        T(i)=B(i)+C;
        if T(i)>=15
        T(i)=T(i)-15; 
        end
        %加法
         if A(i+an-bn)==-1          %A為0a 結果等於T
            T(i)=T(i);
        elseif T(i)==-1             %T為0a  結果等於A
            T(i)=A(i+an-bn);
        elseif (A(i+an-bn)-T(i))==0 %A=B 結果等於0a
            T(i)=-1;
        elseif (A(i+an-bn)-T(i))>0  %A比較大
            T(i)=addone(A(i+an-bn)-T(i))+T(i);
            if T(i)>=15
             T(i)=T(i)-15;
            end

        elseif (A(i+an-bn)-T(i))<0  %B比較大
            T(i)=addone(T(i)-A(i+an-bn))+A(i+an-bn);
            if T(i)>=15
            T(i)=T(i)-15;
            end
        end
    end
    %最後一項刪除 
    D=(T(1:length(T)-1)); 
end