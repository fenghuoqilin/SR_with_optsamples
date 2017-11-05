function seq_mutant = func_crossover_seq(seq, swap_list)

seq_mutant = seq;

num = size(swap_list, 2);

for k = 1:num
    i = swap_list(1,k);
    j = swap_list(2,k);

    seq_mutant(i) = seq(j);
    seq_mutant(j) = seq(i);
end