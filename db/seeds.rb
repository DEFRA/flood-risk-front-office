# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Exemption.create(code: "Blah 01",
                 summary: "River flood example 001",
                 description: "This exemption is only for testing",
                 valid_from: Time.zone.now,
                 valid_to: nil,
                 url: "https://www.gov.uk/guidance/"
)
