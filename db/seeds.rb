# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Exemption.delete_all

puts "Seeding Exemptions from locale data :"

codes = I18n.t('.enrollments.states.add_exemptions.td.span').values
desc  = I18n.t('.enrollments.states.add_exemptions.td.p').values

puts codes.inspect, desc.inspect
codes.each_with_index do |c, i|

  Exemption.create(code: c,
                   summary: desc[i],
                   description:  desc[i],
                   valid_from: Time.zone.now,
                   valid_to: nil,
                   url: "TBD"
  )
end

