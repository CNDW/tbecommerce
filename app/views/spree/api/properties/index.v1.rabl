object false
child(@properties => :properties) do
  extends "spree/api/properties/show"
end
node(:count) { @properties.count }