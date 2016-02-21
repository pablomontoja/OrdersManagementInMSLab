class Institution < ActiveRecord::Base
	has_many :clients
	has_many :teams, dependent: :destroy

	accepts_nested_attributes_for :teams, :reject_if => :all_blank, :allow_destroy => true

	validates_presence_of :name, :short_name


def self.search(search)
  if search.present?
    self.where("name LIKE ? or short_name LIKE ?", "%#{search}%", "%#{search}%").all
  else
    self.all
  end
end




end
