function [seq] = func_genetic_algorithm(data, num_needed, prob_selection,prob_mutation,prob_crossover, num_generation)

M = data.M;

LARGE_VALUE = 999999999999;

num_channel = size(M, 1);

num_population = 1 * ceil(nchoosek(num_channel, num_needed)^(1/25))  % 
% num_population = max([num_population, num_channel/2]);
num_population = max([num_population, 500000]);

seq_population = zeros(num_population, num_channel,'logical');

parfor i = 1 : num_population
    ind = randperm(num_channel,num_needed);
    seq = zeros(1, num_channel,'logical');
    seq(ind) = 1;
    seq_population(i, :) = seq;
end

% %%%%%%%%% TEST CODE %%%%%%%%%%%%%
% D = zeros(num_generation,1);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxval = 0;
%% DE main code
for g = 1 : num_generation

    obj_seq = ones(num_population,1)*LARGE_VALUE;
    
    parfor i = 1:num_population 
        obj_seq(i) = func_objective(data, seq_population(i, :)); 
    end
    
    [v,index_seq] = sort(-obj_seq);
    num_selection = num_population - round((1-prob_selection) * num_population/2)*2;
    index_seq(1:num_selection) = index_seq(randperm(num_selection));
    
    seq_cur = seq_population;
    
    seq_population(1:num_selection,:) = seq_cur(index_seq(1:num_selection),:);
    
    disp(['generation:',num2str(g)]);
    disp(['vol = ',num2str(max(obj_seq))]);
    if maxval <= max(obj_seq)
        maxval = max(obj_seq);
    else
        1
    end

    for i = num_selection+1:2:num_population
        r1 = ceil(rand*num_selection);
        r2 = ceil(rand*num_selection);
        parent_seq1 = seq_population(r1,:);
        parent_seq2 = seq_population(r2,:);
        
        list = func_swap_list(parent_seq1, parent_seq2);
        list = func_reduce_swap_list(list, prob_crossover);
        
        if ~isempty(list) && size(list,1)>1
            a = func_crossover_seq(parent_seq1, list);
            b = func_crossover_seq(parent_seq2, list(2:-1:1,:));
        else
            a = parent_seq1;
            b = parent_seq2;
        end
         
        seq_population(i,:) = func_mutat_seq(a,prob_mutation);
        seq_population(i+1,:) = func_mutat_seq(b,prob_mutation);
        
    end
    
end

obj_seq = ones(num_population,1)*LARGE_VALUE;

parfor i = 1:num_population 
        obj_seq(i) = func_objective(data, seq_population(i, :)); 
end

index = find(obj_seq == max(obj_seq));

seq = seq_population(index(1),:);


end