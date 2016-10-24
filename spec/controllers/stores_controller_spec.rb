# require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  
  # Clean DB 
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  before(:each) do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("user:password")
  end



  # TEST CONTROLLER RESPONSES 
  describe "GET STORE INDEX " do
    
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "Loads all of the stores into @stores" do
      store1, store2 = FactoryGirl.create(:store), FactoryGirl.create(:store)
      get :index
      expect(assigns(:stores)).to match_array([store1, store2])
    end

  end


  # TEST STORES API CONNECTIONS

  describe 'GET STORE #services_index ' do
    
    it 'expects response to be successful' do     
      get 'services_index'
      expect(response).to be_success
    end

    it 'expects response not be successful' do     
      @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("user:wrongpassword")
      get 'services_index'
      expect(response).not_to be_success
    end

  end

  describe 'GET STORE #services_articles_by_store' do


    it 'expects response to be successful' do   
      get :services_articles_by_store, id: 1
      expect(response).to be_success
    end

  end

  # TEST STORE API RESPONSES

  describe "STORES API Services_index" do
    
    it 'Respond with a list of stores' do
      
      FactoryGirl.create(:store)      

      get 'services_index'

      json = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      # check to make sure the right amount of stores are returned
      expect(json['stores'].length).to eq(1)

    end


    it 'retrieves a specific message' do
      
      FactoryGirl.create(:store)   

      get 'services_index'

      json = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      myhash = {"stores"=>[{"id"=>4, "name"=>"New Store", "address"=>"18 Road"}], "status"=>"success", "total_elements"=>1}
      
      # check that the message attributes are the same.
      expect(json).to eq(myhash) 

      # ensure that private attributes aren't serialized
      expect(json['private_attr']).to eq(nil)
    end

  end
    


    describe "STORES API #services_articles_by_store" do 

      # it 'send a list of articles in store' do

      it 'send a list of articles in Store' do
        

        FactoryGirl.create(:store) 

        get :services_articles_by_store, id: 5

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        # check to make sure the right amount of information is returned {STORES, STATUS, TOTAL ELEMENTS}
        expect(json.length).to eq(3)

        # check to make sure the right amount of information is returned in store hash { ID, NAME, ADDRESS, ARTICLES }
        expect(json['store'].length).to eq(4)

        # check to make sure the right amount of information is returned Articles
        expect(json['store']['articles'].length).to eq(1)
      end


      it 'retrieves a specific message' do
      
        FactoryGirl.create(:store)

        get :services_articles_by_store, id: 6

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        myhash = {"store"=>{"id"=>6, "name"=>"New Store", "address"=>"18 Road", "articles"=>[{"name"=>"New Article"}]}, "status"=>"success", "total_elements"=>1}
        
        # check that the message attributes are the same. This is store with ID 6
        expect(json).to eq(myhash) 

        # ensure that private attributes aren't serialized
        expect(json['private_attr']).to eq(nil)
      
      end

      it 'retrieves 400 error messages' do 

        FactoryGirl.create(:store)

        get :services_articles_by_store, id: 70

        json = JSON.parse(response.body)
        
        # check that the error code is 400.
        expect(json['error_code']).to eq(400) 

      end


      it 'retrieves 404 error messages' do 

        FactoryGirl.create(:store)

        get :services_articles_by_store, id: 'd'

        json = JSON.parse(response.body)
        
         # check that the error code is 404.
        expect(json['error_code']).to eq(404) 

      end
    
    end


end
