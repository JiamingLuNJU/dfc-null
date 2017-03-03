function dyn_cor = standard_sliding(ts, le)
    
    dim = size(ts);
    
    dyn_cor = zeros(dim(1), dim(2), dim(2));
    for i = 1:dim(1)-le
       
            dyn_cor(i,:,:) = corr(ts(i:i+le-1, :));
        
    end

end