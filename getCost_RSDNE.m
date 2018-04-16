function [ res ] = getCost_RSDNE(G, U, V, Ls, Lw, alpha, lambda )
% Get the cost: J = |G-UV|^2 + alpha*( tr(U'LsU) + tr(U'LwU) ) + lambda(|U|^2 + |V|^2)
    UV = U*V ;
    cost1 = trace( (G-UV)'*(G-UV) ) ;
    cost21 = alpha* trace(U'*Ls*U);
    cost22 = alpha* trace(U'*Lw*U);
    cost3 = lambda*trace( U'*U ) ;
    cost4 = lambda*trace( V'*V ) ;
    res = cost1 + cost21 + cost22 + cost3 + cost4 ;
end

