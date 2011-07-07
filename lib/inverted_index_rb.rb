# stdlib requires
require 'rubygems'
require 'set'
# 3rd party rubygem requires

# local rubygem requires
require 'packageinfo'

$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# internal requires
# require 'inverted_index_rb/filename_without_rb'

# gem version
# KEEP THE VERSION CONSTANT BELOW THIS COMMENT
# IT IS AUTOMATICALLY UPDATED FROM THE VERSION
# SPECIFIED IN configure.ac DURING PACKAGING

module Fitzgerald
  class InvertedIndexRb
    VERSION = '0.0.0' 
    
    attr_accessor :index
    attr_accessor :tokens 
    attr_accessor :documents

    def initialize()
      @index = Hash.new
      @documents = Set.new
      @tokens = Set.new
    end
    
    def document_index_size
       @documents.size
    end
    
    def token_index_size
       @tokens.size
    end
     
    

    def index_token doc_id, token 
      token = token.downcase
      @index[token] ||= Set.new
      @index[token] << doc_id 
      @tokens << token
      @documents << doc_id
    end 
    
    
    def tokenize line
      line.strip.split(/\W+/)
    end

    def index_line doc_id, line
      tokenize(line).each {|token| index_token(doc_id, token)}
    end

    def index_file filename
      File.open(filename).each {|line| index_line(filename, line)}
    end

    def query_token token
      @index[token] || Set.new
    end

    def query_and tokens
      return Set.new if tokens.size == 0
      sets = tokens.map{|token| query_token token}
      sets[1..-1].inject(sets[0]){|reduction, x| reduction & x}
    end 
    
    def query_or tokens
      return Set.new if tokens.size == 0
      sets = tokens.map{|token| query_token token}
      sets[1..-1].inject(sets[0]){|union, x| union | x}
    end
    
  end
end
