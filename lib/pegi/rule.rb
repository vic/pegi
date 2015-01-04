module Pegi

  class Rule
    def initialize(condition)
      if condition.respond_to?(:to_proc)
        @condition = condition.to_proc
      else
        @condition = condition.method(:match)
      end
    end

    def match(*args)
      @condition.call(*args)
    end

    def !@()
      rule = self
      Rule.new ->(*args) { !rule.match(*args) && args }
    end

    def <<(rule)
      rule = Rule.new(rule) unless Rule === rule
      rule >> self
    end

    def >>(rule)
      rule = Rule.new(rule) unless Rule === rule
      Rule.new ->(*args) { (x = match(*args)) && rule.match(*x) }
    end

    def +(rule)
      (self << :next) & (rule << :next)
    end

    def -(rule)
      (self << :next) && !(rule << :next)
    end

    def +@()
      self << :peek
    end

    def -@()
      !self << :peek
    end

    def &(rule)
      rule = Rule.new(rule) unless Rule === rule
      Rule.new ->(*args) { match(*args) && rule.match(*args) }
    end

    def |(rule)
      rule = Rule.new(rule) unless Rule === rule
      Rule.new ->(*args) { match(*args) || rule.match(*args) }
    end

    def to_proc
      rule = self
      ->(*args) { rule.match(*args) }
    end

  end

end
