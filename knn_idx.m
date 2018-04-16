function A = knn_idx( X, k )
% Input
%   X: input data matrix, [nObservations, nFeature]
%   k: is the number of the nearest neighbors for which we want to capture their similarities.
%  Output:
%   A - [n, k] the idx of neighbors for all nodes

[Nsamples, ~] = size(X);
DD = distMat(X);

% assign cost values to the k-nearest neighbors.
A = zeros(Nsamples, k);

for i=1:Nsamples
    [C,I] = sort(DD(i,:));
    %row = I(2:k+1) ;
    myrow = zeros(k,1) ;
    tt = 1 ;
    for j = 1 : length(I)
        temp = I(j) ;
        if( temp == i ) continue ; end ;
        myrow(tt) = temp ;
        tt = tt + 1 ;
        if( tt == k + 1 ) break ; end ;
    end
    A(i, :) = myrow ;
end

end

