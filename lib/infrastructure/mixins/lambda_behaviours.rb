module Booty
  module LambdaBehaviours
    def memoize(lambda_method)
      lambda { |container| @cache ||= lambda_method.call(container) }
    end
  end
end
