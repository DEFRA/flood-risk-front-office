require "rails_helper"
module FloodRiskEngine
  RSpec.describe "LocalAuthority - Name" do
    let(:page_object) { LocalAuthorityNamePage.new }

    let(:form_class) { Steps::LocalAuthorityForm }

    context "Page Object" do
      it "has state helpers setup to check page text" do
        expect(
          LocalAuthorityNamePage.on_page_locale_key
        ).to eq ".flood_risk_engine.enrollments.steps.local_authority.heading"

        expect(LocalAuthorityNamePage.on_page_text).to_not be_blank
      end

      it "has state helpers setup to confirm the state we are testing" do
        expect(page_object.expected_state).to eq :local_authority
      end

      it "renders the correct starting point" do
        page_object.visit_page
        expect(page).to be_on_page_object page_object
      end
    end

    context "Given I'm on the local authority or public body name page" do
      before(:each) do
        page_object.visit_page
      end

      let(:name) { "Bristol City Council" }

      scenario "When I enter my local authority or public body name" do
        page_object.advance_page
        expect(Enrollment.last.organisation.name).to eq page_object.name_filled_wth
      end
    end

    context "Navigating back from next page using back link " do
      scenario " When I click on the back link" do
        page_object.advance_page_with Faker::Name.name

        page_object.click_back_link

        expect(page).to be_on_page_object page_object

        page_object.my_previous_details_are_remembered
      end
    end

    context "Validation" do
      scenario "When I don't enter a name, Then I expect to see error" do
        page_object.advance_page_with("")
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.name.blank")

        expect(page).to have_error_anchors :name
      end

      scenario "When I enter a very long name, Then I expect to see related error" do
        name = "this will is will blow" + "a" * form_class.name_max_length

        page_object.advance_page_with name
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.name.too_long")

        expect(page).to have_error_anchors :name
      end

      scenario "When I enter a name with invalid characters, Then I expect to see related error" do
        name = "name *& 12"

        page_object.advance_page_with name
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("flood_risk_engine.validation_errors.name.invalid")
        expect(page).to have_error_anchors :name
      end

      scenario "When I enter a name with only acceptable non alpha characters, Then I don't expect to see error" do
        # letters, spaces, commas, full stops, hyphens and apostrophes
        name = "name . blah-, ' council"

        page_object.advance_page_with name

        expect(page).to_not be_on_page_object page_object

        expect(page).to_not have_text I18n.t("flood_risk_engine.validation_errors.name.invalid")
        expect(page).to_not have_error_anchors :name
      end
    end
  end
end
