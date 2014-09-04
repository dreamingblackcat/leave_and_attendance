json.array!(@leave_applications) do |leave_application|
  json.extract! leave_application, :id, :application_date, :user_id, :granted
  json.url leave_application_url(leave_application, format: :json)
end
