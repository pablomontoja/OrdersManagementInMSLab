class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if params[:client_id].blank?
      @orders = Order.search(params[:search]).order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)
    else
      @orders = Order.where(client_id: params[:client_id]).search(params[:search]).order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)      
    end     
  end

  def gotindex
    case params[:status]
      when "ready"
        @gotorders = Order.where(status: "GOTOWY DO ODBIORU").order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)    
      when "finished"
        @gotorders = Order.where(status: "ZAKOŃCZONE").order(created_at: :desc).paginate(:page => params[:page], :per_page => 30)
      when "not_ready"
        @gotorders = Order.where(status: ["W TRAKCIE POMIARU","ZMIANA METODY"]).order(created_at: :asc).paginate(:page => params[:page], :per_page => 30)
      end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @measurements = @order.measurements.build
    @techniques = Technique.all
    @grants = Grant.all
  end

  # GET /orders/1/edit
  def edit
    @measurements = @order.measurements.build
    @techniques = Technique.all
    @order.client.grants.count == 1 ? @grants = @order.client.grants : @grants = @order.client.grants.where(active: true)  
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
          @order.update_attribute(:created_by, current_user.username)
        if order_params[:status] == "ZAKOŃCZONE"
        @order.update_attribute(:final_price, @order.measurements.sum(:price))
        @order.update_attribute(:order_end_date, Time.now.strftime("%Y-%m-%d"))
        end

        case order_params[:order_type]
          when "WSPÓŁPRACA NAUKOWA"
            @order.update_attribute(:order_type, "WSPÓŁPRACA NAUKOWA")
            @order.measurements.find_each(&:save)
            @order.update_attribute(:final_price, @order.measurements.sum(:price))
          when "PŁATNE"
            @order.update_attribute(:order_type, "PŁATNE")
            @order.measurements.find_each(&:save)
            @order.update_attribute(:final_price, @order.measurements.sum(:price))
        end

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    order_before = @order.status
    @techniques = Technique.all
    @grants = @order.client.grants


    respond_to do |format|

      if @order.update(order_params)
        @order.update_attribute(:edited_by, current_user.username)

        @order.update_attribute(:status, "ZMIANA METODY") if @order.measurements.count > 1 && order_before == "W TRAKCIE POMIARU"
        
        if (order_params[:status] == "W TRAKCIE POMIARU" || order_params[:status] == "ZMIANA METODY" )  && order_before == "ZAKOŃCZONE"
        @order.update_attribute(:order_end_date, nil) 
        @order.update_attribute(:final_price, nil)
        end

        if order_params[:status] == "ZAKOŃCZONE"
        @order.update_attribute(:final_price, @order.measurements.sum(:price))
        @order.update_attribute(:order_end_date, Time.now.strftime("%Y-%m-%d"))
        end

        case order_params[:order_type]
          when "WSPÓŁPRACA NAUKOWA"
            @order.update_attribute(:order_type, "WSPÓŁPRACA NAUKOWA")
            @order.measurements.find_each(&:save)
            @order.update_attribute(:final_price, @order.measurements.sum(:price))
          when "PŁATNE"
            @order.update_attribute(:order_type, "PŁATNE")
            @order.measurements.find_each(&:save)
            @order.update_attribute(:final_price, @order.measurements.sum(:price))
        end

        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autocomplete_client_name
    render :json => Client.search(params['term'])
  end

  def change_status
    a = params[:status]
    order = Order.find(a.split("_")[1])
      case a.split("_")[0]
        when "start"
        order.update_attribute(:status, "W TRAKCIE POMIARU")
        order.update_attribute(:sendtojob, false)
        order.update_attribute(:sendtojobdatetime, nil) unless order.sendmail == true
        order.update_attribute(:order_end_date, nil)
        order.update_attribute(:final_price, nil)
        render :json => { "new_status": order.status, "new_final_price": order.final_price, "order_end_date": order.order_end_date }
        when "done"
        order.update_attribute(:status, "GOTOWY DO ODBIORU")
        order.update_attribute(:sendtojob, true)
        order.update_attribute(:sendtojobdatetime, Time.now)
        order.update_attribute(:final_price, order.measurements.sum(:price))
        order.update_attribute(:order_end_date, Time.now.strftime("%Y-%m-%d"))
        render :json => { "new_status": order.status , "new_final_price": order.final_price, "order_end_date": order.order_end_date }
        when "end"
        order.update_attribute(:order_end_date, Time.now.strftime("%Y-%m-%d"))
        order.update_attribute(:final_price, order.measurements.sum(:price))
        order.update_attribute(:status, "ZAKOŃCZONE")
        render :json => { "new_status": order.status , "new_final_price": order.final_price, "order_end_date": order.order_end_date }
      end  
  end

  def get_alertcontent
      a = params[:status]
      @order = Order.find(a.split("_")[1])
      respond_to do |format|
        format.js 
      end
  end

  def get_grant_options
    client = Client.find(params[:client_id])
    options = client.grants.where(active: true).collect{|x| "'#{x.id}':'#{x.short_name}'"}
    render :text => "{#{options.join(",").gsub!("'", '"')}}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:number, :sample_name, 
                                    :order_date, :order_end_date, 
                                    :status, :final_price, :created_by, 
                                    :edited_by, :order_type, :comment, :client_id, :grant_id,
                                    :measurements_attributes => [:multiplier, :technique_id, :id, :_destroy])
    end
end
