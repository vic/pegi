module Pegi

  module Grammar
    def rule(name, rule)
      rule = r(rule)

      (class << self; self; end).module_eval do
        define_method name, -> { rule }
      end

      define_method name, &rule
    end

    def r(rule)
      Rule === rule ? rule : Rule.new(rule)
    end
  end

end
