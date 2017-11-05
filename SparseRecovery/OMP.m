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
[n,P]=size(X);%nΪX������,PΪX������
[n,K]=size(D);%nΪD������,KΪD������
parfor k=1:1:P,%��ÿ���ź�����ϡ������ֵ�
    a=[];
    x=X(:,k);
    residual=x;
    indx=zeros(L,1);%L�е���������
    for j=1:1:L,%����L�������ֵ�ԭ��
        
        proj=D'*residual;
        [maxVal,pos]=max(abs(proj));% �������ֵ������
        pos=pos(1);%�Ѹ�����proj�е�λ�ø���pos
        indx(j)=pos;%pos����indx�ĵ�j��
        %a=pinv(D(:,indx(1:j)))*x;  %norm��Dy-x��ʹ�䷶����С 
        a=D(:,indx(1:j))\x;  %norm��Dy-x��ʹ�䷶����С 
        residual=x-D(:,indx(1:j))*a;%��в�
        if sum(residual.^2) < 1e-6
            break;
        end
        
    end;
    temp=zeros(K,1);%Kά������
    temp(indx(1:j))=a;%��k���źŵı��ϵ��
    A(:,k)=sparse(temp);%ȥ��󸳸�ϵ������A�ĵ�k��
end;
return;
