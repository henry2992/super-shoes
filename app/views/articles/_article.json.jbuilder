json.extract! article, :id, :name, :description, :total_in_shelf, :total_in_vault, :created_at, :updated_at
json.url article_url(article, format: :json)