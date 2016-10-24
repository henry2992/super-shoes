# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
store1 = Store.create(name: 'New York Store', address: '18 Avenue')
store2 = Store.create(name: 'Chicago Store', address: 'Michigan Avenue')
store3 = Store.create(name: 'LA Store', address: 'Brockling Avenue')

article1 = Article.create(name: 'Running shoes', description: 'Shoes to run', price: '102.00', total_in_shelf: '40', total_in_vault: '20', store_id: '')
article2 = Article.create(name: 'Awesome Shoes', description: 'Awesome Shoes', price: '50.00', total_in_shelf: '34', total_in_vault: '90', store_id: '')
article3 = Article.create(name: 'Normal Shoes', description: 'These are normal shoes', price: '45.00', total_in_shelf: '10', total_in_vault: '23', store_id: '')
article4 = Article.create(name: 'Color Shoes', description: 'Color Shoes super nice', price: '67.00', total_in_shelf: '21', total_in_vault: '50', store_id: '')
article5 = Article.create(name: 'Zombie shoes', description: 'Survive the apocalipse', price: '100.00', total_in_shelf: '40', total_in_vault: '60', store_id: '')


store1.articles << article1
store1.articles << article2
store2.articles << article3
store2.articles << article4
store3.articles << article5