class Language
  include Mongoid::Document
  field :name, :type => String
  references_many :blocks
end
