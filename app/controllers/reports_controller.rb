class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :showpdf, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all.paginate(:page => params[:page], :per_page => 30) 
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  # dla icho 1 grant
    @orders = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to, grant_id: @report.grant)  
    @order_ids = @orders.collect(&:id)
    @clients = Client.where(id: @orders.collect(&:client_id))
  # wszyscy
    @grant_ids = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to).collect(&:grant_id)
    @team_ids = Grant.where(id: @grant_ids).collect(&:team_id)
  # dla komercyjnych i niekomercyjnych
  case @report.i_type 
  when "NON-COMMERCIAL"    
    @niekomercyjni = Institution.where(i_type: "NON-COMMERCIAL")
  when "COMMERCIAL"
    @niekomercyjni = Institution.where(i_type: "COMMERCIAL")
  end
  # dla icho
    @institution = Institution.find(@report.institution) unless @report.institution.blank?
    @teams = @institution.teams.where(id: @team_ids).order(:name) unless @report.team.blank? && @report.institution.blank?
    @techniques = Technique.all    
  end

  def showpdf
  # dla icho 1 grant
    @orders = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to, grant_id: @report.grant)  
    @order_ids = @orders.collect(&:id)
    @clients = Client.where(id: @orders.collect(&:client_id))
  # wszyscy
    @grant_ids = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to).collect(&:grant_id)
    @team_ids = Grant.where(id: @grant_ids).collect(&:team_id)
  # dla komercyjnych niekomercyjnych    
  case @report.i_type 
  when "NON-COMMERCIAL"    
    @niekomercyjni = Institution.where(i_type: "NON-COMMERCIAL")
  when "COMMERCIAL"
    @niekomercyjni = Institution.where(i_type: "COMMERCIAL")
  end   
  # dla icho
    @institution = Institution.find(@report.institution) unless @report.institution.blank?
    @teams = @institution.teams.where(id: @team_ids).order(:name) unless @report.team.blank? && @report.institution.blank?
    @techniques = Technique.all 

      #if File.exist?(Rails.root.join('app','assets','pdfs', "#{@report.id}.pdf"))
      #  send_file(Rails.root.join('app','assets','pdfs', "#{@report.id}.pdf"), :filename => "#{@report.id}.pdf", :disposition => 'inline', :type => "application/pdf")
      #else
        render :pdf    => "#{@report.id}.pdf",
          :disposition => "inline",
          :template    => "reports/showpdf.html.erb", 
          :encoding    => "UTF-8",
          :orientation => 'Landscape',
          page_size: 'A4',
          footer: { right: '[page] of [topage]' }
          #save_to_file: Rails.root.join('app','assets','pdfs', "#{@report.id}.pdf")
      #end

  end

  # GET /reports/new
  def new
    @report = Report.new
    @institutions = Institution.all
    @teams = Team.all
    @clients = Client.all
    @grants = Grant.all
  end

  # GET /reports/1/edit
  def edit
    @institutions = Institution.all
    @report.team.nil? ? @teams = Team.all : @teams = Institution.find(@report.institution.to_i).teams
    @report.team.nil? ? @clients = Client.all : @clients = Team.find(@report.team.to_i).clients
    @report.team.nil? ? @grants = Grant.all : @grants = Team.find(@report.team.to_i).grants
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

     # dla icho 1 grant
    @orders = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to, grant_id: @report.grant)  
    @order_ids = @orders.collect(&:id)
    @clients = Client.where(id: @orders.collect(&:client_id))
  # wszyscy
    @grant_ids = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to).collect(&:grant_id)
    @team_ids = Grant.where(id: @grant_ids).collect(&:team_id)
  # dla komercyjnych i niekomercyjnych
  case @report.i_type 
  when "NON-COMMERCIAL"    
    @niekomercyjni = Institution.where(i_type: "NON-COMMERCIAL")
  when "COMMERCIAL"
    @niekomercyjni = Institution.where(i_type: "COMMERCIAL")
  end
  # dla icho
    @institution = Institution.find(@report.institution) unless @report.institution.blank?
    @teams = @institution.teams.where(id: @team_ids).order(:name) unless @report.team.blank? && @report.institution.blank?
    @techniques = Technique.all

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }

        #pdf = render_to_string :pdf => "#{@report.id}.pdf",
        #  :disposition => "inline",
        #  :template    => "reports/showpdf.html.erb", 
        #  :encoding    => "UTF-8",
        #  page_size: 'A3',
        #  footer: { right: '[page] of [topage]' }

        #save_path = Rails.root.join('app','assets','pdfs',"#{@report.id}.pdf")
        #File.open(save_path, 'wb') do |file|
        #file << pdf
        #end

      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
  # dla icho 1 grant
    @orders = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to, grant_id: @report.grant)  
    @order_ids = @orders.collect(&:id)
    @clients = Client.where(id: @orders.collect(&:client_id))
  # wszyscy
    @grant_ids = Order.where(status: "ENDED", order_end_date: @report.date_from..@report.date_to).collect(&:grant_id)
    @team_ids = Grant.where(id: @grant_ids).collect(&:team_id)
  # dla komercyjnych i niekomercyjnych
  case @report.i_type 
  when "NON-COMMERCIAL"    
    @niekomercyjni = Institution.where(i_type: "NON-COMMERCIAL")
  when "COMMERCIAL"
    @niekomercyjni = Institution.where(i_type: "COMMERCIAL")
  end
  # dla icho
    @institution = Institution.find(@report.institution) unless @report.institution.blank?
    @teams = @institution.teams.where(id: @team_ids).order(:name) unless @report.team.blank? && @report.institution.blank?
    @techniques = Technique.all

    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }

        #pdf = render_to_string :pdf => "#{@report.id}.pdf",
        #  :disposition => "inline",
        #  :template    => "reports/showpdf.html.erb", 
        #  :encoding    => "UTF-8",
        #  page_size: 'A3',
        #  footer: { right: '[page] of [topage]' }
        

        #save_path = Rails.root.join('app','assets','pdfs',"#{@report.id}.pdf")
        #File.open(save_path, 'wb') do |file|
        #file << pdf
        #end


      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      #File.delete(Rails.root.join('app','assets','pdfs',"#{@report.id}.pdf")) if File.exist?(Rails.root.join('app','assets','pdfs',"#{@report.id}.pdf"))
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:name, :date_from, :date_to, :institution, :team, :client, :grant, :i_type)
    end
end
