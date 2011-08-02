class UserSession
  include Mongoid::Document
  field :session_id, :type => String
  references_many :blocks
end
