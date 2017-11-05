function val = func_objective(data, seq)
    M = data.M;
    temp = M(find(seq),:);
    
    [U , S , V ] = svd(temp);
    W = diag(S);
    val = exp(sum(log(W(1:size(temp,1)))));
    
end