function [ graph ] = graph_of_DeepWalk( graph )
% MF_DEEPWALK DeepWalk as Matrix Factorization Zhiyuan Liu IJCAI15
% graph - [n,n] the directed graph
% 

for i=1:size(graph,1)
  if (norm(graph(i,:))>0)
      graph(i,:) = graph(i,:)/nnz(graph(i,:)) ;
  end
end
g2 = graph * graph;
graph = graph + g2;
graph = graph ./ 2 ;

end

