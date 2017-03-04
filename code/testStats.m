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

wlen = 50;
FCsliding = compute_slidingWindow_FC(ts_conn',wlen,wlen-1, '');

%cut it down for testing
FCsliding = FCsliding(1:90, 1:90, :);

dim = size(FCsliding);
le = dim(1);
count = 1;

ts_vec = zeros(sum(1:le-1), dim(3));

for r1 = 1:le-1
   for r2 = r1+1:le
        ts_vec(count, :) = FCsliding(r1, r2, :);
        count = count + 1;
   end
end

test = testStatVar(ts_vec);

