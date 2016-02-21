class Report < ActiveRecord::Base

#validates_presence_of :name, :date_from, :date_to, :i_type
#validates_presence_of :institution, :team, :grant, if: :is_ichogrant?
#validates_presence_of :institution, if: :i_type == "ICHO"


#def is_ichogrant?
#  i_type == "ICHO 1 GRANT"
#end

end
