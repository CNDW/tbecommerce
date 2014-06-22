object @blog_entry
cache [I18n.locale, root_object]
node(:id) { |p| p.id }
node(:title) { |p| p.title.to_s }
node(:body) { |p| p.body.to_s }
node(:permalink) { |p| p.permalink.to_s }
node(:created_at) { |p| p.created_at.to_s }
node(:updated_at) { |p| p.updated_at.to_s }
node(:visible) { |p| p.visible }
node(:published_at) { |p| p.published_at.to_s }
node(:summary) { |p| p.summary }
node(:author_id) { |p| p.author_id }