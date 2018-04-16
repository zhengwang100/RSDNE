function Lw = build_inter_class_LaplacianMatrix(G, X, Y) 
% Build the inter-class lap matrix by considering the label information: 
% -------- default Wij = Gij (the edges) and Wij=0 if (Y(i)!=Y(j))
% X - [n,1] the instances
% Y - [n,1] the labels

% author: Zheng Wang @Tsinghua 2018.04.01
    for i = 1 : size(G,1)
        G(i,i) = 0 ; 
    end
    
    %disp '-------- build edge lap matrix --------'
    mydict = java.util.Hashtable;
    for i = 1 : length(X)
        mydict.put(X(i), Y(i));
    end
    [rows, columns, ~]  = find(G) ;
    
    for i = 1 : length(rows)
        node1 = rows(i) ;
        node2 = columns(i) ;
        if( mydict.containsKey(node1) == false || mydict.containsKey(node2) == false )
            continue ;
        end
        if( mydict.get(node1) ~= mydict.get(node2)  )
            % cannot link
            %disp '---- cannot link -----'
            G(node1, node2) = 0 ;
            G(node2, node1) = 0 ;
        end
    end

    Lw = directed_LaplacianMatrix(G) ;
end