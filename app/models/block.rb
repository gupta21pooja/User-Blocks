class Block
  include Mongoid::Document
  include Mongoid::Versioning
  field :content, :type => String
  field :is_private, :type => Boolean
  validates_presence_of :content
  named_scope :public_blocks, :where => {:is_private => false}
  referenced_in :language
  referenced_in :user_session

  def revisions
    self.versions 
  end
  
  def is_owner?(current_session)
    self.session == current_session
  end
  
end
