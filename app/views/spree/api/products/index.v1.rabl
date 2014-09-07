object false
@products.categories.each do |category|
  child(@products.catalogue[category] => category) do
    extends "spree/api/products/show"
  end
end
