function FCsliding = compute_slidingWindow_FC(data,wlen,overlap,winType)

% Computes sliding window dynamic functional connectivity
% Vibha Viswanathan, 3 March 2017.

% INPUTS:
% data: input timeseries of size m x n, where m is the number of timeseries
% and n is the length of each timeseries in samples
% wlen: length of each sliding window in samples
% overlap: overlap between successive sliding windows in samples
% winType: if specified as 'gauss', will implement a gaussian window, else
% will implement a rectangular window.

% OUTPUT:
% FCsliding: matrix of size m x m x p where m is the number of timeseries
% and p is the number of sliding windows.

if (strcmp(winType, 'gauss'))
    win = gausswin(wlen)'; % gaussian window
else
    win = ones(1,wlen); % rectangular window
end

numParcels = size(data,1);

numWindows = floor((size(data,2)-wlen)/(wlen-overlap) + 1);
FCsliding = zeros(numParcels,numParcels,numWindows);
for iter = 1:numWindows
    ts = data(:,...
        ((iter-1)*(wlen-overlap)+1):((iter-1)*(wlen-overlap)+wlen));
    FCsliding(:,:,iter) = corrcoef((ts.*repmat(win,numParcels,1))');
end