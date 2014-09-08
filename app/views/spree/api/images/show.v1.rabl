object @image
attributes :id, :position, :alt
node("small_url") { |i| i.attachment.url("web_small") }
node("large_url") { |i| i.attachment.url("web_large") }
node("medium_url") { |i| i.attachment.url("web_medium") }
node("thumb_url") { |i| i.attachment.url("web_thumb") }