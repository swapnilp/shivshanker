
module Likable
  # def like_by user
  #   if self.id && self.persisted? && user && user.persisted?
  #     key = "#{self.class.table_name}:#{self.id}:likes"
  #     value = user.id
  #     return $redis.sadd key, value
  #   end
  # end

  # def liked_by? user
  #   if self.id && self.persisted? && user && user.persisted?
  #     key = "#{self.class.table_name}:#{self.id}:likes"
  #     value = user.id
  #     return $redis.sismember key, value
  #   end
  # end

  # def likes_count
  #   if self.id && self.persisted?
  #     key = "#{self.class.table_name}:#{self.id}:likes"
  #     return $redis.scard key
  #   end
  # end

  # def unlike_by user
  #   if self.id && self.persisted? && user && user.persisted?
  #     key = "#{self.class.table_name}:#{self.id}:likes"
  #     value = user.id

  #     return $redis.srem key, value
  #   end
  # end

  def self.included(model)
    model.instance_eval do
      has_many :likes,
        :as => :likable,
        :dependent => :destroy,
        :after_add => :sum_likes,
        :after_remove => :sum_likes
    end
  end

  def sum_likes l
    self.class.transaction do
      sum = Like.where(:likable_type => self.class.name, :likable_id => self.id).sum(:value)
      self.update_attribute(:likes_cache, sum)
    end

    return self.likes_cache
  end

  def like_by user, value = 1
    if self.id && self.persisted? && user && user.persisted?
      Like.transaction do
        lk = Like.new
        lk.likable = self
        lk.user = user
        lk.value = value
        self.likes << lk
      end
    end
  end

  def liked_by? user
    if self.id && self.persisted? && user && user.persisted?
      return !!user.likes.where(:user_id => user.id)
    else
      return false
    end
  end

  def unlike_by user
    if self.id && self.persisted? && user && user.persisted?
      lk = Like.where(:likable_type => self.class.name, :likable_id => self.id, :user_id => user.id).first
      self.likes.delete lk
    end
  end
end