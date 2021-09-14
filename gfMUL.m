function C=gfMUL(A,B,addone)
%限制GF(2^4)
%A.B可為多項式 但每項都要補-1
%-1表示0a ,0表示1a^0
%A*B=C
an=length(A);
bn=length(B);
%讓A長度大於B長度
if length(A)<length(B)
    C=A;A=B;B=C;
end
%B補足其他項
for i=1:(length(A)-length(B))
    T=[B,-1];
    B=T;
end
%用原本的長度
C=-ones(1,an+bn-1);%輸出
for x=1:an
    for y=1:bn
        if A(y)==-1 || B(x)==-1
            T=-1;
            C(x+y-1)=gfADD(C(x+y-1),T,addone);
        else
            %相乘
            T=A(y)+B(x);%T為暫存器
            if T>=15
                T=T-15; 
            end
            %相加
            C(x+y-1)=gfADD(C(x+y-1),T,addone);
        end
    end
end
end
