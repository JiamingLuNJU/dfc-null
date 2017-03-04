% tmp = load('data/results/nullHind.mat', 'nullHind');
% 
% surrog1 = squeeze(tmp.nullHind(1,1:end/2-1,:));
% surrog2 = squeeze(tmp.nullHind(1,end/2:end,:));
% 
% le = 50;
% 
% 
% for i = 1:10
%     
%     dyn_cor(i,:,:) = corr(surrog1(i:i+le-1, :), surrog2(i:i+le-1, :));           
% end
% 

ts_conn = importdata('data/rsfmri-dataset2/sub015.txt');

%cut it down for testing
ts_conn = ts_conn(:, 1:90);

[ts1 ts2] = nullHindricks(ts_conn, 1);
nullHind = [ts1; ts2];

wlen = 50;
FCsliding = compute_slidingWindow_FC(ts_conn',wlen,wlen-1, '');

FCsliding_null = standard_sliding_pairs(squeeze(nullHind(1,:,:)), squeeze(nullHind(2,:,:)), 50, 90);

dim = size(FCsliding);
le = dim(1);
count = 1;

ts_vec = zeros(sum(1:le-1), dim(3));
ts_vec_null = zeros(sum(1:le-1), dim(3));

for r1 = 1:le-1
   for r2 = r1+1:le
        ts_vec(count, :) = FCsliding(r1, r2, :);
        ts_vec_null(count, :) = FCsliding_null(r1, r2, 1:dim(3));
        count = count + 1;
   end
end

test2 = testStatVar(ts_vec_null);

