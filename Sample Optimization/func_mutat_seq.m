function seq =func_mutat_seq(seq,prob_mutation)
    seq_cur = seq;
    ind = find(seq);
    for i = 1:size(ind)
        if rand < prob_mutation
            ine = find(~seq);
            ine = ine(randperm(length(ine)));
            seq(ind(i)) = 0;
            seq(ine(1)) = 1;
        end
    end
    
end