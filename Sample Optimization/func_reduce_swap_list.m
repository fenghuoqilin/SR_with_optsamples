function list = func_reduce_swap_list(list0, prob)

% reduce list size according to prob

list = [];

num = size(list0, 2);

for i = 1 : num
    if rand(1,1) < prob
        list = [list, list0(:,i)];
    end
end