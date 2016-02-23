module  SendMailJob
  @queue = :default

  def self.perform
  	client_ids = Order.where(status: "READY", sendtojob: true, sendmail: false || nil).where('sendtojobdatetime < ?', 10.minutes.ago).collect(&:client_id)
  	clients = Client.where(id: client_ids)
  		
  		clients.each do |client|
    		Powiadomienie.email(client).deliver_later unless client.email.blank?
		end
  
  end

end