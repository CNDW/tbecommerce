object false
child(@products => :product) do
  extends "spree/api/products/show"
end
child(@color_types => :color_type) do
  extends "spree/api/color_types/show"
end
child(@color_values => :color_value) do
  extends "spree/api/color_values/show"
end
child(@option_types => :option_type) do
  extends "spree/api/option_types/show"
end
child(@properties => :property) do
  extends "spree/api/properties/show"
end