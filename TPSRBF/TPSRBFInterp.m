function [testresponse] = TPSRBFInterp(data,response,testdata,lamda)
%RBFINTERP Summary of this function goes here
%   Detailed explanation goes here

% data --  n x d
% response -- n x s
% testdata -- m x d
% testresponse -- m x s

[n,d] = size(data);
s = size(response,2);
m = size(testdata,1);

K = zeros(n+d+1); 

for ii = 1:n
    for jj = 1:n
        K(ii,jj) = norm(data(ii,:) - data(jj,:));
        if K(ii,jj) < eps;
        else
            K(ii,jj) = K(ii,jj).^2*log(K(ii,jj)+1);
        end
    end
end

K(n+1:n+d,1:n) = data';
K(1:n,n+1:n+d) = data;
K(n+d+1,1:n) = 1;
K(1:n,n+d+1) = 1;
K(n+1:n+d+1,n+1:n+d+1) = 0;

w = zeros(n+d+1,s);
warning off all

parfor ii = 1:s
    %keyboard
    w(:,ii) = inv(K'*K+lamda*eye(n+d+1))*K'*[response(:,ii); zeros(d+1,1)];
end


tic
testresponse = zeros(m,s);

tempm = zeros(m,n);


parfor ii = 1:m
    
    dis = sqrt(sum((data-repmat(testdata(ii,:),n,1)).^2,2));
    tempm(ii,:) = dis'.^2.*log(dis'+1);
    
end

tempm(:,n+1:n+d) = testdata;
tempm(:,n+d+1) = 1;

testresponse = tempm*w;
toc



  

end

