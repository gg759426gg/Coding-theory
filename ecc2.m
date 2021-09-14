
clc;close all;clear;
%暫存器
D=[1,0,1;1,1,1;1,1,1;1,1,1];
%g(1)=1+D^2
%g(2)=g(3)=g(4)=1+D+D^2

%輸入碼字
R=[0 1 1 1;1 0 1 0 ;0 1 0 1 ;1 0 0 1;0 1 0 1 ;0 1 1 0 ;1 1 0 1 ;0 0 0 1 ;1 0 0 1];  

fprintf("state diagram\n");
clear State 
State(8)=struct('a',[], 'b',[] ,'c',[],'d',[],'e',[]); 
fprintf("current state     input     output   next state  \n"  )
for i=0:1:3
    for j=0:1:1
        State(1+2*i+j)=struct('a',i,'b',[mod(i,2),(i-mod(i,2))/2],'c',j,'d',[-inf,-inf,-inf,-inf],'e',[j,-inf]); 
        State(1+2*i+j).e(2)=State(1+2*i+j).b(1);% 
        for k=1:1:4
           
            %a(j,1)=xor(1,s(j,3));
            %a(j,2)=xor(a(j,1),D(k,2));
            %a(j,3)=a(j,2);
            %a(j,4)=a(j,2);
            
            and=[j,State(1+2*i+j).b]&(D(k,:));    % S AND D
            State(1+2*i+j).d(k)=(mod(sum(and),2));% XOR  =>output
        end
   
       fprintf("  S%d(%d%d)            %d        %d%d%d%d        %d%d \n",State(2*i+j+1).a,State(2*i+j+1).b,State(2*i+j+1).c,State(2*i+j+1).d,State(2*i+j+1).e);
    end
end
%=====================================================================

%算出每個可能路徑的漢明距離 
road=ones(8,9);
for r=1:9 
    for i=0:3
       for j=0:1
           %讓R與output做XOR，再做sum得到當下的漢明距離，最後利用for求出所有路徑的距離。
           road(2*i+j+1,r)=sum(xor(R(r,1:4),State(2*i+j+1).d));
       end
    end    
end     
%  for a=1:1:4
%         if r(1,a)==1
%             n=n+1;  
%         end
%         if r(2,a)==1
%             m=m+1;
%         end
%     end


fprintf("\nr=(0111,1010,0101,1001,0101,0110,1101,0001,1001)\n");
distance=0;
input=ones(1,9);
A=zeros(1,2);%代表狀態00
C=zeros(1,9);
while (A(1)==1) || (A(2)==1) || (distance~=11) 
    distance=0;
    for r=1:9 
       %用m迴圈尋找下個狀態
       next=zeros(2,2);
       for m=1:8
           if State(m).b(1:2)==A(1:2)
               if State(m).c==0
                   %如果狀態相同，且輸入為0，則下個狀態為NS1
                   next(1,:)=State(m).e;
                   row=m;
                   %如果狀態相同，且輸入為1，則下個狀態為NS2
                   next(2,:)=State(m+1).e;
                   break;         
                   %如果找到就跳出迴圈 否則會出錯會繼續找下去
               end
           end
       end
       %判斷距離，取距離較小的輸入和下個狀態
       if road(row,r)>road(row+1,r)     %輸入為1
            distance=distance+road(row+1,r);
            input(1,r)=1;
            A=next(2,:);
       elseif road(row,r)<road(row+1,r) %輸入為0
           distance=distance+road(row,r);
            input(1,r)=0;
            A=next(1,:);
       elseif road(row+1,r)==road(row+1,r)  %兩個都可，用隨機變數去代替
           distance=distance+2;
           rand=randi([0,1]);
           input(1,r)=rand;
           A=next(rand+1,:);   
       end
    end
end    
    fprintf("最短路徑:%d",distance);
    fprintf("\n");
    fprintf("根據路徑可能傳送值:%d%d%d%d%d %d%d%d%d\n",input);    
%y=0;
%sum=zeros(2,9);
%road=[];

%for x=1:1:9
%    n=0;
%    m=0;
    
%    if y==0
%        ro(1,1:4)=xor(r(x,1:4),g(1,2:5));
%        ro(2,1:4)=xor(r(x,1:4),g(2,2:5));
%    end
    
%    if y==1
%        ro(1,1:4)=xor(r(x,1:4),g(3,2:5));
%        ro(2,1:4)=xor(r(x,1:4),g(4,2:5));
%    end
    
%    if y==2
%        ro(1,1:4)=xor(r(x,1:4),g(5,2:5));
%        ro(2,1:4)=xor(r(x,1:4),g(6,2:5));
%    end
    
%    if y==3
%        ro(1,1:4)=xor(r(x,1:4),g(7,2:5));
%        ro(2,1:4)=xor(r(x,1:4),g(8,2:5));
%    end
    
    %算漢明距離
 %   for a=1:1:4
%         if ro(1,a)==1
%             n=n+1;  
%         end
%         if ro(2,a)==1
%             m=m+1;
%         end
%     end
%     
%     選小的路徑
%     if n<m
%         b(1,1)=g(y*2+1,6);
%         b(1,2:5)=g(y*2+1,2:5);
%     else
%         b(1,1)=g(y*2+2,6);
%         b(1,2:5)=g(y*2+2,2:5);
%     end
%     
%     
%     road=[road;b(1,1:5)];
%     
%     y=b(1,1);
%       
% end
% 
% road(9,1:5)=0;    
    
    

































    
    fprintf("路徑:s0 =>s1 =>s3 => s3=> s2=>s1 =>s2 => s0=> s0=>s0\n")

    