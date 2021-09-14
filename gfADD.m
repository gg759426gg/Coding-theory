function C=gfADD(A,B,addone)
%限制GF(2^4)
%A.B可為多項式 但每項都要補-1
%-1表示0a ,0表示1a^0
%A+B=C

%讓A長度大於B長度
if length(A)<length(B)
    C=A;A=B;B=C;
end
%B補足其他項
for i=1:(length(A)-length(B))
    T=[B,-1];
    B=T;
end
C=zeros(1,length(A));
for i=1:(length(B))
    if A(i)==-1          %A為0a 結果等於T
        C(i)=B(i);
    elseif B(i)==-1             %T為0a  結果等於A
        C(i)=A(i);
    elseif (A(i)-B(i))==0 %A=B 結果等於0a
        C(i)=-1;
    elseif (A(i)-B(i))>0  %A比較大
        C(i)=addone(A(i)-B(i))+B(i);
        if C(i)>=15
            C(i)=C(i)-15;
        end
    elseif (A(i)-B(i))<0  %B比較大
        C(i)=addone(B(i)-A(i))+A(i);
        if C(i)>=15
            C(i)=C(i)-15;
        end
    end
end
end