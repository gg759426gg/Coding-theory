function [C,D]=gfDIV(A,B,addone)
an=length(A);
bn=length(B);
T=zeros(1,bn);%�Ȧs��
%% �P�_�̰������_��0a 
if A(an)==-1
    D=(A(1:length(A)-1)); 
    C=-1;
else
    %��A�̤j��/B�̤j�� ��J�Ӧ�
    C=A(an)-B(bn);
    if C<0
        C=C+15;
    end

    %���k�P�[�k
    for i=length(B):-1:1
        %���k
        T(i)=B(i)+C;
        if T(i)>=15
        T(i)=T(i)-15; 
        end
        %�[�k
         if A(i+an-bn)==-1          %A��0a ���G����T
            T(i)=T(i);
        elseif T(i)==-1             %T��0a  ���G����A
            T(i)=A(i+an-bn);
        elseif (A(i+an-bn)-T(i))==0 %A=B ���G����0a
            T(i)=-1;
        elseif (A(i+an-bn)-T(i))>0  %A����j
            T(i)=addone(A(i+an-bn)-T(i))+T(i);
            if T(i)>=15
             T(i)=T(i)-15;
            end

        elseif (A(i+an-bn)-T(i))<0  %B����j
            T(i)=addone(T(i)-A(i+an-bn))+A(i+an-bn);
            if T(i)>=15
            T(i)=T(i)-15;
            end
        end
    end
    %�̫�@���R�� 
    D=(T(1:length(T)-1)); 
end