class Technique < ActiveRecord::Base
	has_many :measurements
	has_many :orders, through: :measurements
	
	after_save :load_into_soulmate
	before_destroy :remove_from_soulmate

	validates_presence_of :name, :short_name, :price_icho, :price_ncc, :price_cc, :price_science

  def self.search(term)
    matches = Soulmate::Matcher.new('technique').matches_for_term(term)
    matches.collect {|match| {"id" => match["id"], "value" => match["term"] } }
  end


private 

	def load_into_soulmate
		loader = Soulmate::Loader.new("technique")
		loader.add("term" => short_name, "id" => self.id)
	end

	def remove_from_soulmate
		loader = Soulmate::Loader.new("technique")
	    loader.remove("id" => self.id)
	end


end
