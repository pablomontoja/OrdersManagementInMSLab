class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.szukaj(params[:search]).order(:last_name).paginate(:page => params[:page], :per_page => 30)    
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
    @institutions = Institution.all.order(:name)
    @teams = Team.all   
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    @institutions = Institution.all 
    @teams = @client.institution.teams 
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    
    respond_to do |format|
      if @client.save
        format.html { redirect_to edit_client_path(@client), notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @client.attributes = {'grant_ids' => []}.merge(params[:client] || {})
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_team_options
    inst = Institution.find(params[:institution_id])
    options = inst.teams.collect{|x| "'#{x.id}':'#{x.name}'"}
    render :text => "{#{options.join(",").gsub!("'", '"')}}"
  end

  def get_clients_in_team
    team = Team.find(params[:team_id])
    options = team.clients.collect{|x| "'#{x.id}':'#{x.last_name} #{x.first_name}'"}
    render :text => "{#{options.join(",").gsub!("'", '"')}}"    
  end

  def get_client_grants
    client = Client.find(params[:client_id])
    options = client.grants.collect{|x| "'#{x.id}':'#{x.name}'"}
    render :text => "{#{options.join(",").gsub!("'", '"')}}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:first_name, :last_name, :institution_id, :email, :phone, :team_id, { grant_ids: [] })     
    end
end
