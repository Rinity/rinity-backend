# see: http://www.alexreisner.com/code/single-table-inheritance-in-rails

if Rails.env.development?
  %w[ride ride_request ride_offer].each do |c|
    require_dependency File.join("app", "models", "#{c}.rb")
  end
end