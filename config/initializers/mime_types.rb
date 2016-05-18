# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
svg_raw = MIME::Types["text/html"].first
svg_raw.extensions << "svg"
MIME::Types.index_extensions! svg_raw
