require "rails_helper"

RSpec.describe "New scenario" do
  it "shows h2 header" do
    visit main_app.root_path

    expect(page).to have_css("h2", text: "Before you register you must")
  end
end
