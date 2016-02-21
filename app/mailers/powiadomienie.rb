class Powiadomienie < ApplicationMailer
	default from: "mslab@icho.edu.pl"

	after_action :set_sendmail 

  def email(client)
    @client = client
    @zlecenia = Order.where(client_id: @client.id, status: "GOTOWY DO ODBIORU", sendtojob: true, sendmail: false || nil).where('sendtojobdatetime < ?', 10.minutes.ago)
    mail(to: @client.email, subject: 'Laboratorium MS IChO - powiadomienie')
  end


private

	def set_sendmail		
		@zlecenia.each do |order|
			order.update_attribute(:sendmail, true)
		end
	end

end
