ts_conn = importdata('data/rsfmri-dataset2/sub015.txt');

test = standard_sliding(ts_conn, 50);

figure
imagesc(squeeze(test(1,:,:)))