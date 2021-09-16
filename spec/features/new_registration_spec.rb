require "rails_helper"

RSpec.feature "New scenario" do
  scenario "in general" do
    visit main_app.root_path

    expect(page).to have_css("h3", text: "Before you register you must")
  end
end
