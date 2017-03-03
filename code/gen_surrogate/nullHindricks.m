% Implementation of null model of Hindrick2105, NeuroImage
% 03-03-2017 Jonathan Wirsich Brainhack Global 2017, UIUC
%
% ts - input timeseries(time x regions)
% iter - number of iterations
%
% shifted_ts1 shifted_ts2 - timeseries pairs of iteration x connection x
% timepoint with random pahseshift for each connections preserving static
% connectivity
function [shifted_ts1 shifted_ts2] = nullHindricks(ts, iter)

    dim = size(ts);
    vec_size = sum(1: dim(2)-1);
    
    %preallocate results
    shifted_ts1 = zeros(iter, dim(1), vec_size); 
    shifted_ts2 = zeros(iter, dim(1), vec_size); 
    
    for i = 1:iter
    %get timeseries pair
        shift = rand(dim(1), vec_size);
        
        count = 1;
        
        for r1 = 1:dim(2)-1 
            for r2 = r1+1:dim(2)
                %FFT pair
                f1 = fft(ts(:,r1));
                f2 = fft(ts(:,r2));
%                 %get phase
                phi1 = angle(f1);
                phi2 = angle(f2);
                %randomize phase (same shift for both timeseries)
                phi_rand1 = wrapToPi(phi1+(shift(:,count)*2*pi));
                phi_rand2 = wrapToPi(phi2+(shift(:,count)*2*pi));
                
                %TODO shift whole pairwise connection the same phase???
                shifted_ts1(i,:,count) = real(ifft(abs(f1).*exp(1i*phi_rand1)));
                shifted_ts2(i,:,count) = real(ifft(abs(f2).*exp(1i*phi_rand2)));
                
                count = count+1;
            end
        end
    end

end


