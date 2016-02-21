class Client < ActiveRecord::Base
	belongs_to :institution
	belongs_to :team
	has_many :orders
	has_and_belongs_to_many :grants
	
	accepts_nested_attributes_for :grants, :reject_if => :all_blank, :allow_destroy => true

	after_save :load_into_soulmate
	before_destroy :remove_from_soulmate

	validates_presence_of :first_name, :last_name, :institution_id, :team_id

  def full_name
  	[last_name, first_name].join(' ')
  end


  def self.search(term)
    matches = Soulmate::Matcher.new('clients').matches_for_term(term)
    matches.collect {|match| {"id" => match["id"], "value" => match["term"] } }
  end


def self.szukaj(search)
  if search.present?
    self.where("last_name LIKE ? or first_name LIKE ?", "%#{search}%", "%#{search}%" ).all
  else
    self.all
  end
end



private 

	def load_into_soulmate
		imie = last_name + " " + first_name
		loader = Soulmate::Loader.new("clients")
		loader.add("term" => imie, "id" => self.id)
	end

	def remove_from_soulmate
		loader = Soulmate::Loader.new("clients")
	    loader.remove("id" => self.id)
	end
end
