# RSDNE
RSDNE: Exploring Relaxed Similarity and Dissimilarity from Completely-imbalanced Labels for Network Embedding. AAAI18

Usage (abstract):
---

% split the training and testing nodes

[X_train_nodes, Y_train, X_test_nodes, Y_test] = split_train_test_by_class(nodes, Y, train_rate=0.3) ;

% build the completely-imbalanced label setting

removedlist = [3,6] ;

[ X_zsl, Y_zsl ] = remove_classes( X_train_nodes, Y_train, removedlist ) ;

% run our algorithm

U = RSDNE(G, X_zsl, Y_zsl, lowRank, alpha, lambda, learnRate, k) ;


Citing
---
If you find RSDNE useful in your research, please cit our paper, thx:

```
@InProceedings{wang2018rsdne,
  title={{RSDNE}: Exploring Relaxed Similarity and Dissimilarity from Completely-imbalanced Labels for Network Embedding},
  author={Wang, Zheng and Ye, Xiaojun and Wang, Chaokun and Wu, YueXin and Wang, Changping and Liang, Kaiwen},
  booktitle={AAAI},
  pages={475--482},
  year={2018}
}
```
