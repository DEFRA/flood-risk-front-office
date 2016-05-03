# Check up-front that neccessary ENV vars are present. This prevents delayed
# errors, for example email failing on first execution because of missing configuration.
# You can add these variables in development or CI using your .env file.

%w(SECRET_KEY_BASE).each do |key|
  ENV.fetch(key) { raise "#{key} not found in ENV" }
end
