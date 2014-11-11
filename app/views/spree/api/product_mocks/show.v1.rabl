object @product_mock
cache @product_mock, expires_in: 10.minutes
attributes :id, :position, :name, :product_id
node('svg_url') { |i| i.product_mock_svg.url }