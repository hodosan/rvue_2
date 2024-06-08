json.extract! room, :id, :name, :profile, :created_at, :updated_at
json.url room_url(room, format: :json)
