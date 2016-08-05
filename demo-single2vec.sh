make
make -p ./output
if [ ! -e text8 ]; then
  wget http://mattmahoney.net/dc/text8.zip -O text8.gz
  gzip -d text8.gz -f
fi
## use cbow and negative
time ./bin/single2vec -train text8 -output ./output/vectors -cbow 1 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

## use skip-gram and hierarchical softmax method
#time ./bin/single2vec -train text8 -output ./output/vectors -cbow 0 -size 150 -window 10 -negative 0 -hs 1 -sample 1e-4 -threads 20 -binary 1 -iter 10

