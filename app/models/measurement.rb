class Measurement < ActiveRecord::Base
	belongs_to :order
	belongs_to :technique

	before_save :set_price

	validates_presence_of :multiplier, :technique_id
	validates :multiplier, :numericality => { :greater_than_or_equal_to => 0 }

protected

def set_price
	case self.order.client.institution.i_type
		when "1 INSTITUTION"
		self.price = self.multiplier * self.technique.price_icho
		when "NON-COMMERCIAL"
		self.price = self.multiplier * self.technique.price_ncc
		when "COMMERCIAL"
		self.price = self.multiplier * self.technique.price_cc
	end

	case self.order.order_type
		when "SCIENTIFIC COLLABORATION"
		self.price = self.multiplier * self.technique.price_science
	end

end

end
