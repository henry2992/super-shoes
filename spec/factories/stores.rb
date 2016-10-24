FactoryGirl.define do
  
    factory :store do

  	    name "New Store"

  	    address "18 Road"

  	    after(:create) do |store|
	      store.articles << FactoryGirl.create(:article)
	    end

    end

 
end
