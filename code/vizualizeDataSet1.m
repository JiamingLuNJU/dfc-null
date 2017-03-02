%viualize fMRI test data

conn = load ('data/rsfmri-dataset1/subject4session1_PowerPetersen_allSpheres_wraf_sig.mat');

names=fieldnames(conn.sys);

%convert to matrix
regions = length(names);
timepoints = length(conn.sys.(names{1}));

ts_conn = zeros(regions, timepoints);
for i = 1:regions
    ts_conn(i, :) = conn.sys.(names{i});
end

figure 
imagesc(ts_conn)

conn = corr(ts_conn');
figure
imagesc(conn)
