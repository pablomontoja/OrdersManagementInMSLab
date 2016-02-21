class Team < ActiveRecord::Base
  belongs_to :institution
  has_many :clients
  has_many :grants

  accepts_nested_attributes_for :grants, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :name
  validates_uniqueness_of :name

  def full_name
  	[name, self.institution.short_name].join(' - ')
  end


end
