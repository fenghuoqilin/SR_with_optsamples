function list = func_swap_list(seq1, seq2)

x = (seq1 == 1 & seq2 == 0);
y = (seq1 == 0 & seq2 == 1);

ind1 = find(x == 1);
ind2 = find(y == 1);


ind1 = ind1(randperm(length(ind1)));
ind2 = (ind2(:))';


list = [ind1; ind2];  

% exchagne list data, example£º
% list = [ 3  4
%          1  2 ];
% sequence 3<->1, 4<->2



