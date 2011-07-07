Simple inverted index code.

    require 'inverted_index_rb'
    index = InvertedIndexRb.new
    index.index_file('doc1.txt')
    index.index_file('doc2.txt')
    puts index.query_and(['glad','us'])
    puts index.query_or(['i','made'])