class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy, :rest_articles_by_store]

  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with :name => "user", :password => "password"

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers


  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def rest_index
    @stores = Store.all

    myhash= { stores: @stores.as_json(:only => [:id, :name, :address]) , status: "success", total_elements: @stores.count.as_json  }
    
    render json: myhash
  end

  def rest_articles_by_store
    @articles = @store.articles.all
    myhash = { store: @store.as_json( :only => [:id, :name, :address ], :include => { :articles => { :only => :name } } ) , status: "success", total_elements: @articles.count.as_json }
    render :json => myhash 
  end


  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :address)
    end


    def record_not_found(error)

      is_number?(params[:id]) ? myhash = {"error_msg": "Bad Request, No store with that ID","error_code": 400, "success": false} : myhash = {"error_msg": "Record not Found, Wrong parameters (id is not a number)", "error_code": 404, "success": false}
      
      render :json => myhash
    end 

    
    def is_number? string
      true if Float(string) rescue false
    end
end
