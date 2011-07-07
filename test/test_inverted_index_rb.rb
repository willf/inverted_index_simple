require File.dirname(__FILE__) + '/test_helper'

describe "Simple Ruby Inverted Index" do
    
  it 'should create an inverted index' do
    i = InvertedIndexRb.new
    i.document_index_size.should == 0 
    i.token_index_size.should == 0 
  end
  
  it 'should allow creation indexing on one token' do
    i = InvertedIndexRb.new
    i.index_token(:test,'one')
    i.document_index_size.should == 1 
    i.token_index_size.should == 1 
  end
  
  it 'should allow creation indexing on lines' do
    i = InvertedIndexRb.new
    i.index_line(:test,'one two three four five one')
    i.document_index_size.should == 1 
    i.token_index_size.should == 5
  end
  
  it 'should allow creation indexing on files' do
    i = InvertedIndexRb.new
    i.index_file(File.dirname(__FILE__) + '/doc1.txt')
    i.index_file(File.dirname(__FILE__) + '/doc2.txt')
    i.document_index_size.should == 2 
  end
  
  it 'should allow single token queries' do
    i = InvertedIndexRb.new
    i.index_file(File.dirname(__FILE__) + '/doc1.txt')
    i.index_file(File.dirname(__FILE__) + '/doc2.txt')
    i.query_token('glad').size.should == 2   
    i.query_token('AAAAA').size.should == 0
  end
  
  it 'should allow multiple token AND queries' do
    i = InvertedIndexRb.new
    i.index_file(File.dirname(__FILE__) + '/doc1.txt')
    i.index_file(File.dirname(__FILE__) + '/doc2.txt')
    i.query_and(['glad']).size.should == 2   
    i.query_and(['glad','AAAAA']).size.should == 0
    i.query_and(['glad','AAAAA','BBBB']).size.should == 0
    i.query_and(['glad','i']).size.should == 1
  end 
  
  it 'should allow multiple token OR queries' do
    i = InvertedIndexRb.new
    i.index_file(File.dirname(__FILE__) + '/doc1.txt')
    i.index_file(File.dirname(__FILE__) + '/doc2.txt')
    i.query_or(['glad']).size.should == 2   
    i.query_or(['glad','AAAAA']).size.should == 2
    i.query_or(['glad','AAAAA','BBBB']).size.should == 2
    i.query_or(['aaa','bbb']).size.should == 0
  end
  
end