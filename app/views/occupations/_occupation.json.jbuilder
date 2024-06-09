json.extract! occupation, :id, :user_id, :room_id, :day, :time_s, :time_e, :reservation, :confirmed, :created_at, :updated_at
json.url occupation_url(occupation, format: :json)
