%w(SECRET_KEY_BASE).each do |key|
  ENV.fetch(key) { raise "#{key} not found in ENV" }
end
