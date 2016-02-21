class Grant < ActiveRecord::Base
	has_and_belongs_to_many :clients
	belongs_to :team
	has_many :orders
	

	validates_presence_of :name, :short_name


def self.search(search)
  if search.present?
    self.where("name LIKE ? or short_name LIKE ?", "%#{search}%", "%#{search}%").all
  else
    self.all
  end
end



end
