function [ U ] = RSDNE(G, X, Y, lowRank, alpha, lambda, learnRate, k)
%RSDNE: Exploring Relaxed Similarity and Dissimilarity from Completely-imbalanced Labels for Network Embedding. AAAI18
%min(U,V) J = |G-UV|^2 + alpha*|U' (Ls+Lw) U|^2 + lambda*(|U|^2 + |V|^2)
%         s.t., S1n = Kn ,S in {0,1}n¡Án ,sij = 0 forall C(ui) != C(uj)
% G - [n,n] matrix form of deepwalk (or anyother row normalized graph matrix, like matrix form of LINE)
% X - [n,1], Y - [n,c] labeled nodes with its labels 
% lowRank: the embedding dimension (200 in our paper)
% alpha, lambda: parameters (1 and 0.1 in our paper)
% learnRate: the learning rate for gradient descent (0.1 is suggested)
% k: the intra-class neighbor number

% author: Zheng Wang @Tsinghua 2018.04.01

    maxIter = 50 ; % Choose your own.
    % Random initialization:
    [node_num, ~] = size(G);
    G = sparse(G) ;
    U = rand(node_num, lowRank) / lowRank ;
    V = rand(lowRank, node_num) / lowRank ;
    % Gradient Descent:
    iter = 1;
    Ls = build_intra_class_LaplacianMatrix(U, X, Y, k ) ;
    Lw = build_inter_class_LaplacianMatrix(G, X, Y) ;
    lastU = U ;
    lastV = V ;
    lastLs = Ls ;
    
    trainRMSE_old = getCost_RSDNE(G, U, V, Ls, Lw, alpha, lambda ) ;
    fprintf('cost at iteration start : %f\n', trainRMSE_old);
    while iter <= maxIter    
        iter
        
        L = Ls + Lw ;
        dU = -2*G*V' + 2*U*(V*V') + 2*alpha*L*U + 2*lambda*U;
        U = U - learnRate * dU ;
        
        dV = 2*( -U'*G + U'*U*V + lambda*V );
        V = V - learnRate * dV ;
        
        Ls = build_intra_class_LaplacianMatrix(U, X, Y, k) ;
        trainRMSE_new = getCost_RSDNE(G, U, V, Ls, Lw, alpha, lambda ) ;

        if trainRMSE_old < trainRMSE_new
            U = lastU ;
            V = lastV ;
            Ls = lastLs;
            learnRate = learnRate/2.0 ;
        else
            learnRate = learnRate*1.05 ;
            trainRMSE_old = trainRMSE_new;
            lastU = U ;
            lastV = V ;
            lastLs = Ls ;
        end
        iter = iter + 1;
    end
end

