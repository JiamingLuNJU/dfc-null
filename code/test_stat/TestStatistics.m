%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the test statistics of the functional connectivity matrix
% 
% To be tested.
%
% Inputs:
%
%--corrTRegion (correlation matrix re-organized into a matrix with row the
%number of time series points, and column the number of pair-wise regions
%
%--code (index code for the type of feature statistics):
%
% if code == 1, the test Statistics is the variance of correlation
% matrix
% if code == 2, the test Statistics is the zero crossing of correlation
% matrix
% if code == 3, ... to be continued
%
% Output: 
%
% --testStat: calcualted test statistics in a row vector (number of regions)
% 
% Michelle Wang on March 4, 2017 at BrainHack 2017 in Urbana.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function testStat = TestStatistics(corrTRegion, code)

if code == 1
    testStat = var(corrTRegion)
    
elseif code == 2
    m = median(corrTRegion)
    
    % to be optimzed
    for i = 1 : size(corrTRegion, 2)
        location = zeros(1, size(corrTRegion, 1));
        
        for t = 1 : size(corrTRegion, 1)
            loc_counter = 0;
            if corrTRegion(t, i) == m(i) % this needs to be modified or updated.
                loc_counter = loc_counter + 1;
                location(loc_counter) = t;
            end          
        end
        % size(location)
        t_old = location(1);
        H = zeros(1, size(location, 2)-1);
        L = zeros(1, size(location, 2)-1); 
        
        for j = 2 : size(location)
            H_max = 0;
            for t = t_old : location(j)
                fprintf('t = %d\n', t);
               
                if abs(corrTRegion(t, i) - m(i)) > H_max
                    H_max = corrTRegion(t, i) - m(i);
                end
                
            end
            
            H(j-1) = H_max;
            L(j-1) = location(j) - t_old;
            
            t_old = location(j);
        end
        
        testStat(i) = sum(abs(H.*L));
         
    end
                  
elseif code == 3
    
    % to be continued
    
end

end