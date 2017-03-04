function dyn_cor = standard_sliding_pairs(ts1, ts2, le, regions)
    
    dim = size(ts1);
    
%     le = 50;
    dyn_cor = zeros(regions, regions, dim(1));
    
    for i = 1:dim(1)-le
        count = 1;
        for r1 = 1:regions-1
            for r2 = r1+1:regions
                temp1 = squeeze(ts1(i:i+le-1, count));
                temp2 = squeeze(ts2(i:i+le-1, count));
                
                dyn_cor(r1,r2,i) = corr(temp1, temp2);
                dyn_cor(r2,r1,i) = dyn_cor(r1,r2,i);
                
                count = count + 1;
            end
        end
    end
end