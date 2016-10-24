require 'rails_helper'
# require 'articles'


RSpec.describe Article do 

	# Clean DB To test Associations
	DatabaseCleaner.strategy = :truncation
	DatabaseCleaner.clean


	let(:article) { FactoryGirl.create(:article) } 
	subject { article }

	it 'should not be valid without a name' do
	    article.name = nil
	    expect(article).to be_invalid
	end

	it 'should not be valid with less than 2 characters' do
	    article.name = 'NA'
	    expect(article).to be_invalid
	end

	it 'should not be valid without a description' do
	    article.description = nil
	    expect(article).to be_invalid
	end

	it 'should not be valid without a description' do
	    article.description = 'NANA'
	    expect(article).to be_invalid
	end

	it 'should not be valid without a price' do
	    article.price = nil
	    expect(article).to be_invalid
	end

	it 'should not be valid if price is not numeric' do
	    article.price = 'Six'
	    expect(article).to be_invalid
	end

	it 'should not be valid if price is less then 0' do
	    article.price = -60
	    expect(article).to be_invalid
	end


	it 'should not be valid without total_in_shelf' do
	    article.total_in_shelf = nil
	    expect(article).to be_invalid
	end

	it 'should not be valid if total_in_shelf is not numeric' do
	    article.total_in_shelf = 'Six'
	    expect(article).to be_invalid
	end

	it 'should not be valid if total_in_shelf is less then 0' do
	    article.total_in_shelf = -60
	    expect(article).to be_invalid
	end


	it 'should not be valid without total_in_vault' do
	    article.total_in_vault = nil
	    expect(article).to be_invalid
	end

	it 'should not be valid if total_in_vault it is not numeric' do
	    article.total_in_vault = 'Six'
	    expect(article).to be_invalid
	end

	it 'should not be valid if it is less then 0' do
	    article.total_in_vault = -60
	    expect(article).to be_invalid
	end



	# # Associations 
	it "belongs to store" do
	    assc = described_class.reflect_on_association(:store)
	    expect(assc.macro).to eq :belongs_to
	end
    

  

end