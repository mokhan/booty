module PropertyBag
  def attributes
    items = instance_variables.map do |variable|
      [variable.to_s.gsub(/@/, '').to_sym, instance_variable_get(variable)]
    end
    Hash[items]
  end
end
