# example criteria blob
# {
#   "roles": ["athlete", "fan"],
#   "gender": ["male"],
#   "schools": [1],
#   "sports": [2],
# }

class ContestUser < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user

  validate :contest, :presence => true
  validate :user, :presence => true

  def eligible? force = false
    if !force && !eligible_cached.nil?
      return eligible_cached
    end

    blob = contest.criteria_blob
    if blob.nil?
      return eligible!
    end

    begin
      json = MultiJson.load blob
      update_attribute :eligible_cached, evaluate_conditions(json)
      return eligible_cached
    rescue DecodeError
      return eligible!
    end
  end

  def eligible!
    update_attribute :eligible_cached, true
    return true
  end

  def not_eligible!
    update_attribute :eligible_cached, false
    return false
  end

  private
  def evaluate_conditions cond
    if cond["roles"]
      ok = false
      
      cond["roles"].each do |r|
        ok ||= user.has_role? r
      end

      if !ok
        return false
      end
    end

    if cond["gender"]
      ok = false
      
      cond["gender"].each do |g|
        ok ||= (user.gender == g)
      end

      if !ok
        return false
      end
    end

    if cond["schools"]
      ok = !!user.schools.where(:id => cond["schools"])
      if !ok
        return false
      end
    end

    if cond["sports"]
      ok = !!user.sports.where(:id => cond["sports"])
      if !ok
        return false
      end
    end

    return true
  end
end