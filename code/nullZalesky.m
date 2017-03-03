%stub for implementing Zalesky 2014, PNAS model

% Stolen code to make good matrices
load('subject4session1_PowerPetersen_allSpheres_wraf_sig.mat')
names=fieldnames(sys);

%convert to matrix
regions = length(names);
timepoints = length(sys.(names{1}));

ts_conn = zeros(regions, timepoints);
for i = 1:regions
    ts_conn(i, :) = sys.(names{i});
end

%% Create VAR model

%TO-DO
% choosing the VAR model order (using 11 because that's what Zalesky used)

%Define competing models to fit the data
%preallocate once I have any idea what this output looks like

%The BIC was evaluated
%for model orders between 1 and 50 in unity increments for 500 pairs of regions
%randomly sampled from the 10 individuals

%create random pair of ROIs

for y = 
    num_orders = 50;
    % how do we choose "T" (sample size?)
    EstMdl(
    for i = 1:num_orders
        EstMdl(i,:) = arima('ARLags',1:i);
    end 

    %Fit models to the data
    logL = zeros(num_orders,1);
    for i = 1:num_orders
        [~,~,logL(i)]= estimate(EstMdl(i,:),y,'print',false);
    end

    [aic, bic] = aicbic(logL,[3;4;5], T*ones(num_orders,1);


%%

    current_time_series = [ts_conn(1,:), ts_conn(2,:)];
    SuperCoolVARModel = vgxset('n',2,'nAR',11,'Constant',true);
    [EstSpec,EstStdErrors,logL,W] = vgxvarx(SuperCoolVARModel,current_time_series);
    vgxdisp(EstSpec)


    % building the pair of time-series

    %bootstrapping
    %choose time point at random n, 1<n<(N-p)
        rng(1,'twister');
        r = randi([1 length(ts_conn)-2],1,1000);

    %Initialize the first to be a randomly-selected contiguous block of p
    %observations from the actual data

        x(1) = current_time_series(1,r(1));
        y(1) = current_time_series(2,r(1));

        x(2) = current_time_series(1,r(1)+1);
        y(2) = current_time_series(2,r(1)+1);

