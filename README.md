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

convert binary file to text: `python load_vector_bin.py ./output/vectors.bin vectors.txt`.

vectors.txt:

```
frederikke 0.111187 0.023541 0.011842 0.272916 0.000004 0.008952 0.000003 0.000076 ...
evita 0.246191 0.236299 0.378308 0.110335 0.000001 0.215787 0.000003 0.000073 ...
contradanza 0.058163 0.203514 0.016196 0.010003 0.000001 0.008312 0.000004 0.000089 ...
raam 0.028472 1.556614 0.060492 0.010761 0.000000 0.037923 0.000002 0.012079 0.000001...
barad 0.489277 0.044670 0.012591 0.026385 0.000003 0.091246 0.000001 0.000121 0.000005...
baume 0.480921 0.051466 0.089450 0.100741 0.000004 0.001142 0.000003 0.000016 0.000000...
mothmen 0.017367 0.023990 0.000067 0.171735 0.000003 0.042909 0.000002 0.001003 0.000003...
gallopin 0.001380 0.033212 0.007252 0.031673 0.000002 0.004911 0.000006 0.000006 0.000001 ...
```

## How does it work

### Mikolov's model 

**CBOW**

![cbow](https://raw.githubusercontent.com/waterblas/non-negative-word2vec/master/experiments/cbow.png)

<img src="http://latex.codecogs.com/gif.latex?\sum_{(c,w) \in D}{\log{P(v_{w}|v_{c})}}" />

**Skip-gram**

![sg](https://raw.githubusercontent.com/waterblas/non-negative-word2vec/master/experiments/sg.png)

<img src="http://latex.codecogs.com/gif.latex?\sum_{(i,c) \in D} \sum_{v_j \in c} {\log{P(v_{i}|v_{j})}}" />

### Non-negative model

**CBOW**

![non-cbow](https://raw.githubusercontent.com/waterblas/non-negative-word2vec/master/experiments/non-cbow.png)

<img src="http://latex.codecogs.com/gif.latex?embedding(w) = v_c.v_c" />

**Skip-gram**

![non-sg](https://raw.githubusercontent.com/waterblas/non-negative-word2vec/master/experiments/non-sg.png)

<img src="http://latex.codecogs.com/gif.latex?embedding(j) = v_j .v_j" />

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

![doublesg](https://raw.githubusercontent.com/waterblas/non-negative-word2vec/master/experiments/doublesg.png)

<img src="http://latex.codecogs.com/gif.latex?embedding(w) = v_j.v_j" />

Though I update the code to implement it, the result is not good. ***Not recommended use now*** . the result of experiment is saved in `experiment/double2vec.txt` file.


## REFERENCES
[1] Mikolov T, Chen K, Corrado G, et al. Efficient estimation of word representations in vector space[J]. arXiv preprint arXiv:1301.3781, 2013.

[2] Mikolov T, Dean J. Distributed representations of words and phrases and their compositionality[J]. Advances in neural information processing systems, 2013.

[3] Lai S, Liu K, Xu L, et al. How to Generate a Good Word Embedding?[J]. arXiv preprint arXiv:1507.05523, 2015.



