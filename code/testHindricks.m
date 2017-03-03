ts_conn = importdata('data/rsfmri-dataset2/sub015.txt');

[ts1 ts2] = nullHindricks(ts_conn, 1);

surrog = zeros(630);

count = 1;
for r1 = 1:629
    for r2 = r1+1:630
        surrog(r1, r2) = corr(ts1(:,count), ts2(:,count));
        surrog(r2, r1) = surrog(r1, r2);
        
        count = count + 1;
    end
end

for r1 = 1:630
    surrog(r1,r1) = 1; 
end
figure
imagesc(surrog)

conn = corr(ts_conn);
figure
imagesc(conn)

