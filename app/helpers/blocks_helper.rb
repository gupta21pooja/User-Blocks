module BlocksHelper
  def is_self_block(blk)
    user_session == blk.user_session
  end
end
