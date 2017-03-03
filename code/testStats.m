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

le = 630;
count = 1;
for r1 = 1:le
   for r2 = r1+1:le
        ts_vec(count, :) = FCsliding(r1, r2, :);
        count = count + 1;
   end
end

