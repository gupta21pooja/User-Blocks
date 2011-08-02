module BlocksHelper
  def is_self_block(blk)
    set_user_session == blk.user_session
  end
end
