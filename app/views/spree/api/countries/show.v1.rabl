object @country
cache [I18n.locale, root_object], expires_in: 1.day
attributes *country_attributes
attribute :states_required
child :states => :states do
  attributes :id, :name, :abbr, :country_id
end