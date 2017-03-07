%stub for implementing Zalesky 2014, PNAS model

% Stolen code to make good matrices
% load('subject4session1_PowerPetersen_allSpheres_wraf_sig.mat')
% names=fieldnames(sys);
% 
% %convert to matrix
% regions = length(names);
% timepoints = length(sys.(names{1}));
% 
% ts_conn = zeros(regions, timepoints);
% for i = 1:regions
%     ts_conn(i, :) = sys.(names{i});
% end


ts_conn = importdata('data/rsfmri-dataset2/sub015.txt');

%% Create VAR model

%TO-DO
% choosing the VAR model order (using 11 because that's what Zalesky used)

%Define competing models to fit the data
%preallocate once I have any idea what this output looks like

%The BIC was evaluated
%for model orders between 1 and 50 in unity increments for 500 pairs of regions
%randomly sampled from the 10 individuals

%create random pair of ROIs

% %%% No idea what this code is - MKE 3/7
% for y = 
%     num_orders = 50;
%     % how do we choose "T" (sample size?)
%     EstMdl(
%     for i = 1:num_orders
%         EstMdl(i,:) = arima('ARLags',1:i);
%     end 
% 
%     %Fit models to the data
%     logL = zeros(num_orders,1);
%     for i = 1:num_orders
%         [~,~,logL(i)]= estimate(EstMdl(i,:),y,'print',false);
%     end
% 
%     [aic, bic] = aicbic(logL,[3;4;5], T*ones(num_orders,1);


%%
%%% New ManyModels code
ManyModels= [];
for i = 1:size(ts_conn,1)-1
 
%for i =1:20
    for j = i+1:size(ts_conn,1)
    % for j = 1:20
        if i ~= j
        current_time_series(i,j) = mat2cell([ts_conn(i,:); ts_conn(j,:)],2);        
        SuperCoolVARModel = vgxset('n',2,'nAR',11,'Constant',true);
        disp([i j]);
        [ManyModels(i,j).EstSpec,ManyModels(i,j).EstStdErrors,ManyModels(i,j).logL,ManyModels(i,j).W] = vgxvarx(SuperCoolVARModel,current_time_series{i,j}');
    
        end
     end
end

% %%% old ManyModels code
% ManyModels= [];
% %for i = 1:size(ts_conn,1)-1
%  
% for i =1:20
%    % for j = i+1:size(ts_conn,1)
%      for j = 1:20
%         if i ~= j
%             current_time_series(i,j) = mat2cell([ts_conn(i,:); ts_conn(j,:)],2);
%             SuperCoolVARModel = vgxset('n',2,'nAR',11,'Constant',true);
%             disp([i j]);
%             [ManyModels(i,j).EstSpec,ManyModels(i,j).EstStdErrors,ManyModels(i,j).logL,ManyModels(i,j).W] = vgxvarx(SuperCoolVARModel,current_time_series{i,j}');          
%         end
%      end
% end




    % building the pair of time-series

    %bootstrapping as Zalesky et al 2014
    
    
    
    % choose random blocks of time-series data of random pairs
    % apply the correct auto-regressive model
    
    
    % generate some number of random datasets
    
    
    %choose time point at random n, 1<n<(N-p)
% i=1;
% j=3;
rng(1,'twister');
p = 11;
N = length(ts_conn);        
NRois = 20;
%NRois = size(ts_conn,1);
n_sampl = 20;
r_sampl = 200
isEqual = 0;
rand_samp = randi([1 NRois],1,r_sampl);

i_rand = randi([1 NRois],1,r_sampl/2);
j_rand = randi([1 NRois],1,r_sampl/2);

rand_pairs = [];
i = 1;
x = 1;

while length(rand_pairs) < 20 
    if i_rand(i) ~= j_rand(i)
        rand_pairs(x,1) = i_rand(i); 
        rand_pairs(x,2) = j_rand(i);
        x=x+1;
    end
    i=i+1;
end
        
        
%% Work in progress
% while ~isEqual
%     i_rand = randi([1 NRois],1,n_sampl);
%     j_rand = randi([1 NRois],1,n_sampl);
%     for x = 1:n_sampl
%         if ismember(i_rand(x),j_rand)
%             i_rand(x) = randi([1 NRois]);
%             %j_rand = randi([1 NRois],1,n_sampl);
%         else
%             isEqual = 1;
%         end
%     end
% end
% A = 1:N;
% arrayfun(@(i)A(randi(N,1)),1:num_event)

count = 1;
for i=i_rand
    for j=j_rand        
        if i ~= j
            n0 = randi([1 N-p],1,1);
            x_b = zeros(n_sampl*n_sampl,N);
            y_b = zeros(n_sampl*n_sampl,N);
            % First p points from n0 + p-1
            x_b(1:p) = ts_conn(1,n0:n0+p-1);
            y_b(1:p) = ts_conn(2,n0:n0+p-1);
            for n=p+1:N
                n_hat = randi([1 N],1,1);
                x_b_AR = zeros(2,p);
                y_b_AR = zeros(2,p);    
                % Create autoregressive part of Appendix equation
                for t=1:p
                    x_b_AR(:,t) = ManyModels(i,j).EstSpec.AR{t}(:,1).*[ts_conn(1,n-t);ts_conn(1,n-t)];
                    y_b_AR(:,t) = ManyModels(i,j).EstSpec.AR{t}(:,1).*[ts_conn(2,n-t);ts_conn(2,n-t)];
                end
                x_b(count,n) = sum(x_b_AR(1,:)) + sum(y_b_AR(1,:)) + ManyModels(i,j).W(n_hat,1);
                y_b(count,n) = sum(x_b_AR(2,:)) + sum(y_b_AR(2,:)) + ManyModels(i,j).W(n_hat,2);
                count = count + 1;
            end
        end
    end
end

    

    %Initialize the first to be a randomly-selected contiguous block of p
    %observations from the actual data

        

