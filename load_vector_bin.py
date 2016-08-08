"""
Loads the word2vec binary file:
- convert to a text file
- convert to a numpy matrix
"""
import numpy as np

def parse_matrix(bin_f):
    with open(bin_f, "rb") as f:
        header = f.readline()
        vocab_size, layer_size = map(int, header.split())
        binary_len = np.dtype('float32').itemsize * layer_size
        t_matrix = np.zeros((vocab_size, layer_size), dtype='float32')
        vocab = {}
        for i in xrange(vocab_size):
            word = []
            while True:
                ch = f.read(1)
                if ch == ' ':
                    word = ''.join(word)
                    break
                if ch != '\n':
                    word.append(ch)
            t_matrix[i] = np.fromstring(f.read(binary_len), dtype='float32')
            vocab[word] = i
    return vocab, t_matrix


def to_pickle(bin_f, pkl_f):
    import cPickle as pickle
    with open(pkl_f, "w") as fo:
        pickle.dump(parse_matrix(bin_f), fo, protocol=pickle.HIGHEST_PROTOCOL)


def to_text(bin_f, text_f):
    with open(bin_f, "rb") as f, open(text_f, "w") as fo:
        header = f.readline()
        print header
        vocab_size, layer_size = map(int, header.split())
        binary_len = np.dtype('float32').itemsize * layer_size
        for i in xrange(vocab_size):
            word = []
            while True:
                ch = f.read(1)
                if ch == ' ':
                    word = ''.join(word)
                    break
                if ch != '\n':
                    word.append(ch)
            vec = np.fromstring(f.read(binary_len), dtype='float32')
            fo.write("%s" % word)
            for ele in vec:
                fo.write(" %f" % ele)
            fo.write("\n")

if __name__ == '__main__':
    import sys
    if len(sys.argv) < 2:
        print("Missing Parameters of binary filename")
    #to_text(sys.argv[1], sys.argv[2])
    to_pickle(sys.argv[1], sys.argv[2])

