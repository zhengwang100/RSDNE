function L = build_intra_class_LaplacianMatrix(U, X, Y, orgk )
%  Build the inter-class lap matrix by considering the label information and embedding distances 
% U - [n,d] the embedded nodes
% X - [n,1] the labeled nodes
% Y - [n,1] the labels
% k - the neighbor number

% author: Zheng Wang @Tsinghua 2018.04.01

%disp '-------- build ranked class laplacian matrix --------'
[n, ~] = size(U) ;
S = zeros(n, n) ;
labellist = unique(Y) ;
for i = 1 : length(labellist)
    label = labellist(i) ;
    idx = Y == label  ;
    nodelist = X(idx) ;
    tempX = U(nodelist,:) ; 
    k = min(orgk, length(nodelist)-1) ;
    A = knn_idx( tempX, k ) ;
    for ii = 1 : size(A, 1)
        node_start = nodelist(ii) ; 
        for jj = 1 : size(A, 2)
            selected = nodelist( A(ii, jj) ) ;
            S(node_start, selected) = 1 ;
        end
    end
end
L = directed_LaplacianMatrix(S) ;
end