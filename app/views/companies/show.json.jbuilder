json.extract! @company, :id, :name, :domain, :address, :offices, :created_at, :updated_at
json.offices(@company.offices) do |office|
  json.id office.id
  json.name office.name
  json.address office.address
end
