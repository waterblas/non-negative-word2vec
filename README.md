# non-negative-word2vec
A word2vec toolkit with non-negative constrains. This project originated from [Mikolov's word2vec toolkit](https://code.google.com/archive/p/word2vec/), and I change the update training process to add constrains and get non-negative vector finally (each value of dimension > 0 ).  

It can be applied to Parameter Initialization for neural network in some NLP task.

## Structure

```
./baseline              Mikolov's word2vec toolkit copy
./src                   Non-negative word2vec code(by me)
./demo-single2vec.sh    Non-negative word2vec example
./demo-double2vec.sh    Dev training version  (Incomplete production, not recommended use)
./experiment            Some experiments to measure the quality of embeddings
```    

## Example

```
make
./demo-single2vec.sh
```

## How does it work

### Mikolov's model 

**CBOW**

![cbow_Mikolov](http://7xkrbx.com1.z0.glb.clouddn.com/github/cbow_Mikolov.png)

```
$$ P(v_{w}|v_{c}) = \frac{exp(v_{w}^{T}v_{c})}{\sum_{k \in V}{exp(v_{k}^{T}v_{c})}}$$
$$ \sum_{(c,w) \in D}{\log{P(v_{w}|v_{c})}}$$
```

**Skip-gram**

![skip-gram_Mikolov](http://7xkrbx.com1.z0.glb.clouddn.com/github/skip-gram_Mikolov.png)

```
$$ P(v_{i}|v_{j}) = \frac{exp(v_{i}^{T}v_{j})}{\sum_{k \in V}{exp(v_{k}^{T}v_{j})}}$$
$$ \sum_{(i,c) \in D} \sum_{v_j \in c} {\log{P(v_{i}|v_{j})}}$$
```
### Non-negative model

**CBOW**

![cbow_mine](http://7xkrbx.com1.z0.glb.clouddn.com/github/cbow_mine.png)


```
$$ P(v_{w}|v_{c}) = \frac{exp(v_{w}^{T}(v_{c}. v_{c}))}{\sum_{k \in V}{exp(v_{k}^{T}(v_{c}. v_{c}))}}$$
$$ embedding(w) = v_c.v_c $$
```


**Skip-gram**

![skip-gram_mine](http://7xkrbx.com1.z0.glb.clouddn.com/github/skip-gram_mine.png)

```
$$ P(v_{i}|v_{j}) = \frac{exp(v_{i}^{T}(v_{j}. v_{j}))}{\sum_{k \in V}{exp(v_{k}^{T}(v_{j}. v_{j}))}}$$
$$ embedding(j) = v_j .v_j $$
```

## Experiment

- Experiment Environment: single 2.2Ghz Intel Xeon CPU，1G DDR3 RAM （Aliyun）
- Contrast Object: Mikolov's word2vec

There are something interesting I find in experiment. In my way(single2vec), it seems that no impact on word similarity featue:

```
Enter word or sentence (EXIT to break): apple

Word: apple  Position in vocabulary: 1221

                                              Word       Cosine distance
------------------------------------------------------------------------
                                               mac        0.887437
                                             amiga        0.873168
                                         macintosh        0.868616
                                         microsoft        0.851529
                                                os        0.845202
                                         commodore        0.842106
                                                pc        0.828330
                                          software        0.819627
                                               rom        0.818264
                                                cd        0.816847
                                               ibm        0.815670
                                             atari        0.813561
                                               bsd        0.811073

Enter word or sentence (EXIT to break): france

Word: france  Position in vocabulary: 303

                                              Word       Cosine distance
------------------------------------------------------------------------
                                           belgium        0.822980
                                             spain        0.800581
                                             italy        0.799730
                                       netherlands        0.771286
                                            sweden        0.747223
                                        luxembourg        0.739861
                                           germany        0.734011
                                       switzerland        0.729641
                                           denmark        0.704383
                                             japan        0.704201
                                           england        0.690731
                                            norway        0.683007
                                           austria        0.678848
```

However, the analogy(woman - man = queen - king) feature has a big drop-down, and it seems to be the impact of non-nengative constrains.
```
: Analogy
capital-common-countries:
ACCURACY TOP1: 34.98 %  (177 / 506)
Total accuracy: 34.98 %   Semantic accuracy: 34.98 %   Syntactic accuracy: -nan %
capital-world:
ACCURACY TOP1: 12.81 %  (186 / 1452)
Total accuracy: 18.54 %   Semantic accuracy: 18.54 %   Syntactic accuracy: -nan %
currency:
ACCURACY TOP1: 1.12 %  (3 / 268)
Total accuracy: 16.44 %   Semantic accuracy: 16.44 %   Syntactic accuracy: -nan %
city-in-state:
ACCURACY TOP1: 9.10 %  (143 / 1571)
Total accuracy: 13.41 %   Semantic accuracy: 13.41 %   Syntactic accuracy: -nan %
family:
ACCURACY TOP1: 21.24 %  (65 / 306)
Total accuracy: 13.99 %   Semantic accuracy: 13.99 %   Syntactic accuracy: -nan %
gram1-adjective-to-adverb:
ACCURACY TOP1: 7.67 %  (58 / 756)
Total accuracy: 13.01 %   Semantic accuracy: 13.99 %   Syntactic accuracy: 7.67 %
```

**More detail result is in `./experiment` dir.**




## Development

Dev double inner product method. run `./demo-double2vec.sh`

![dev-double2vec](http://7xkrbx.com1.z0.glb.clouddn.com/github/dev-double2vec.png)

```
$$ P(v_{i}|v_{j}) = \frac{exp((v_{i}.v_{i})^{T}(v_{j}. v_{j}))}{\sum_{k \in V}{exp((v_{k}.v_{k})^{T}(v_{j}. v_{j}))}}$$
$$ embedding(j) = v_j .v_j $$
```

Though I update the code to implement it, the result is not good. ***Not recommended use now*** . the result of experiment is saved in `experiment/double2vec.txt` file.


## REFERENCES
[1] Mikolov T, Chen K, Corrado G, et al. Efficient estimation of word representations in vector space[J]. arXiv preprint arXiv:1301.3781, 2013.

[2] Mikolov T, Dean J. Distributed representations of words and phrases and their compositionality[J]. Advances in neural information processing systems, 2013.

[3] Lai S, Liu K, Xu L, et al. How to Generate a Good Word Embedding?[J]. arXiv preprint arXiv:1507.05523, 2015.



