Deface::Override.new(virtual_path: 'spree/admin/products/_form',
	name: "add_category_and_type_to_product_edit",
	insert_bottom: '[data-hook="admin_product_form_left"]',
	:original => '6f929b54e86880a8efae973aa89fc766a8a8e39c',
	text: "
		<%= f.field_container :product_category do %>
			<%= f.label :product_category, Spree.t(:product_category) %>
			<%= f.error_message_on :product_category %>
			<%= f.text_field :product_category, class: 'fullwidth' %>
		<% end %>
		<%= f.field_container :product_subcategory do %>
			<%= f.label :product_subcategory, Spree.t(:product_subcategory) %>
			<%= f.error_message_on :product_subcategory %>
			<%= f.text_field :product_subcategory, class: 'fullwidth' %>
		<% end %>
")