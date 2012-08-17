require "likable"

class PictureContestEntry < ActiveRecord::Base
  include Likable

  belongs_to :picture_contest
  belongs_to :picture

  validates :picture_contest, :presence => true
  validates :picture, :presence => true
end