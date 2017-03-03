% stub for Implementing null model of Hindrick2105, NeuroImage

% ts - input timeseries(time x regions)
function [shifted_ts1 shifted_ts2] = nullHindricks(ts, iter)

    dim = size(ts);

    for i = 1:iter
    %get timeseries pair
        vec_size = sum(1: dim(2)-1);
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
                %randomize phase (same randomize for both timeseries)
                phi_rand1 = wrapToPi(phi1+(shift(:,count)*2*pi));
                phi_rand2 = wrapToPi(phi2+(shift(:,count)*2*pi));

                
                %TODO shift whole pairwise connection the same phase???
%                 shifted_ts1(:,count) = real(ifft(abs(f1).*exp(1i*phi_rand)));
%                 shifted_ts2(:,count) = real(ifft(abs(f2).*exp(1i*phi_rand)));
                shifted_ts1(:,count) = real(ifft(abs(f1).*exp(1i*phi_rand1)));
                shifted_ts2(:,count) = real(ifft(abs(f2).*exp(1i*phi_rand2)));
                
                count = count+1;
                
                %surrogate(1) = shifted_ts1;
                %surrogate(2) = shifted_ts2;
            end
        end
    end

end


