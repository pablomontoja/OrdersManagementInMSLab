class Order < ActiveRecord::Base
	belongs_to :client
	belongs_to :grant
	has_many :measurements
	has_many :techniques, through: :measurements

	accepts_nested_attributes_for :measurements, :reject_if => :all_blank, :allow_destroy => true

	validates_presence_of :number, :order_date, :status, :order_type, :sample_name, :client_id, :grant_id


def self.search(search)
  if search.present?
  	a = self.joins(:client).where("number LIKE ? or sample_name LIKE ? or comment LIKE ? or clients.last_name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").collect(&:id)
    a = a + self.joins(:techniques).where("techniques.short_name LIKE ?", "#{search}").collect(&:id)
    self.where(id: a).all
    #self.where("number LIKE ? or sample_name LIKE ? or comment LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%").all
  else
    self.all
  end
end


end
