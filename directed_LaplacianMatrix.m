function L = directed_LaplacianMatrix(W)
% Note: this is the undirected graph W
%disp '------------build undirected Laplacian Matrix-------------'
    N = length(W) ;
    D = zeros(N,N) ;
	G = (W + W')/2 ;
    for i = 1:N
		D(i,i) = sum( G(i,:) ) ;
    end
    
    L = D - G ;
    
%     A = (A+A')/2;
%     D = diag(sum(A));
%     L = D-A;
end