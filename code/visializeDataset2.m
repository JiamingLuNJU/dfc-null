%Visualize data of dataset2

ts_conn = importdata('data/rsfmri-dataset2/sub015.txt');
 
figure 
imagesc(ts_conn)

conn = corr(ts_conn);
figure
imagesc(conn)