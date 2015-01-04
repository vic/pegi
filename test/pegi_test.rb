require_relative 'test_helper'

describe Pegi::Grammar do

  def peg(&block)
    Class.new {
      extend Pegi::Grammar
      instance_eval &block
    }.new
  end

  it 'match with a single literal rule' do
    o = peg {
      rule :hello, "Hello"
    }
    assert o.class.hello.kind_of?(Pegi::Rule)
    assert o.hello("Hello")
  end

  it 'match two rules with &' do
    o = peg {
      rule :he, /he/i
      rule :lo, /lo/
      rule :hello, he & lo & :downcase
    }
    assert o.class.hello.kind_of?(Pegi::Rule)
    assert_equal "hello", o.hello("Hello")
  end

  it 'matches negation of rule with !' do
    o = peg {
      rule :bye, "bye"
      rule :hello, !bye
    }
    assert_equal ["hello", 22], o.hello("hello", 22)
  end


  it 'match any of rules with |' do
    o = peg {
      rule :hi, /hi/
      rule :lo, /lo/
      rule :hello, hi | lo
    }
    assert o.class.hello.kind_of?(Pegi::Rule)
    assert_equal "lo", o.hello("hello").to_s
  end

  it 'chain output of rule as input of another with >>'  do
    o = peg {
      rule :reverse, ->(s) { s.reverse }
      rule :hi, /lle/
      rule :hello, reverse >> hi
    }
    assert_equal "lle", o.hello("hello").to_s
  end

  it 'peeks positive with +' do
    o = peg {
      rule :hi, "hi"
      rule :hello, +hi & :next & :next
    }
    assert_equal "jole", o.hello(%w[hi jole].each)
  end

  it 'peeks negative with -' do
    o = peg {
      rule :hi, "hi"
      rule :hello, -hi & :next
    }
    assert_equal "jole", o.hello(%w[jole mano].each)
  end
  
  it 'chain stream of rules with +' do
    o = peg {
      rule :he, /he/i
      rule :lo, /lo/
      rule :hello, he + lo
    }
    assert o.hello(%w[He llo].each)
  end
end
