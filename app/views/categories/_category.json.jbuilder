json.extract! category, :id, :name, :created_at, :updated_at, :description, :mail_in
json.url category_url(category, format: :json)
