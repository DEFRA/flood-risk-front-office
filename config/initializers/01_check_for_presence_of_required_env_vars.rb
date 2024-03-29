# Check up-front that neccessary ENV vars are present. This prevents delayed
# errors, for example email failing on first execution because of missing configuration.
# You can add these variables in development or CI using your .env file.
%w(
  SECRET_KEY_BASE
  DEVISE_MAILER_SENDER
).each do |key|
  ENV.fetch(key) { raise "#{key} not found in ENV" }
end

# Ensure presence of any essential production ENV vars
if Rails.env.production?
  %w(
    AIRBRAKE_HOST
    AIRBRAKE_FO_PROJECT_KEY
  ).each do |key|
    ENV.fetch(key) { raise "#{key} not found in ENV" }
  end
end
