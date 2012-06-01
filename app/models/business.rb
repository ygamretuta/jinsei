class Business < ActiveRecord::Base
  validates_presence_of :name
  mount_uploader :photo, PhotoUploader

  def to_param
    "#{name.parameterize}"
  end
end
