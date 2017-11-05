function [A]=OMP(D,X,L); 
%=============================================
% Sparse coding of a group of signals based on a given 
% dictionary and specified number of atoms to use. 
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       L - the max. number of coefficients for each signal.
% output arguments: 
%       A - sparse coefficient matrix.
%=============================================
[n,P]=size(X);%n为X的行数,P为X的列数
[n,K]=size(D);%n为D的行数,K为D的列数
parfor k=1:1:P,%对每个信号求其稀疏表达的字典
    a=[];
    x=X(:,k);
    residual=x;
    indx=zeros(L,1);%L行的零列向量
    for j=1:1:L,%求其L个表达的字典原子
        
        proj=D'*residual;
        [maxVal,pos]=max(abs(proj));% 求出绝对值最大的项
        pos=pos(1);%把该项在proj中的位置赋给pos
        indx(j)=pos;%pos赋给indx的第j项
        %a=pinv(D(:,indx(1:j)))*x;  %norm（Dy-x）使其范数最小 
        a=D(:,indx(1:j))\x;  %norm（Dy-x）使其范数最小 
        residual=x-D(:,indx(1:j))*a;%求残差
        if sum(residual.^2) < 1e-6
            break;
        end
        
    end;
    temp=zeros(K,1);%K维列向量
    temp(indx(1:j))=a;%第k个信号的表达系数
    A(:,k)=sparse(temp);%去零后赋给系数矩阵A的第k项
end;
return;
