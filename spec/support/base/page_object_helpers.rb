require_relative "exceptions"

module PageObjectHelpers
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    # Try to find and Choose matching Radio button
    # N.B CHOOSE form so only selects radio if found, will NOT call SUBMIT
    #
    def find_and_choose(radio_to_find)
      method = methods.grep(/choose_#{radio_to_find}/).first

      send(method) if method

      raise WasteExemptionsRspec::RadioButtonNotFound, "RadioButton #{radio_to_find} not found on page"
    end

  end

  module ClassMethods

    # Enables quick setup of the text you expect to find on a derived PageObject
    #   expected_page_text "This is the text I expect in my very own Page"
    #
    # Now in FEATURE tests you can test if you are on that particular page with
    #     expect(page).to be_on_page_object( my_page_object )
    #
    def expected_page_text(text_to_expect)
      instance_eval <<-end_eval
        def on_page_text
          "#{text_to_expect}"
        end
      end_eval
    end

    # Enables quick setup of the text you expect to find on a derived PageObject
    #   expected_page_text "This is the text I expect in my very own Page"
    #
    # Now in FEATURE tests you can test if you are on that particular page with
    #     expect(page).to be_on_page_object( my_page_object )
    #
    def expected_page_locale(locale_key)
      instance_eval <<-end_eval
        def on_page_locale_key
          "#{locale_key}"
        end
      end_eval
    end

    # Enables quick setup of the STATE this Page relates to.
    #
    # All pages should conform to standard of having their text in the locale in a standard Calls :
    #
    #   expected_page_text I18n.t(".enrollments.states.#{state}.heading")
    #
    # This is used to auto create methods :
    #
    #   create_related_enrollment - returns an Enrollment object from appropriate factory: page_<state>
    #
    # rubocop:disable Metrics/MethodLength
    #
    def generate_state_helpers(state,
                               page_text_key = "heading",
                               page_text_root = ".flood_risk_engine.enrollments.steps")

      expected_page_locale(".#{page_text_root}.#{state}.#{page_text_key}")

      expected_page_text I18n.t(on_page_locale_key)

      # create an instance method that points to this pages root path in locales
      class_eval <<-end_eval
        def state_pages_locale_path
          ".#{page_text_root}.#{state}"
        end
      end_eval

      # create an instance method that can be used to generate an Enrollment in right state
      class_eval <<-end_eval
        def create_related_enrollment
          Rails.logger.debug("RSPEC : PageObject - create_related_enrollment :page_#{state}")
          FactoryGirl.create(:page_#{state})
        end
      end_eval

      # create an instance method that returns the defined state
      class_eval <<-end_eval
        def expected_state
          :#{state}
        end
      end_eval
    end

    # Enables quick setup of group of Radio buttons on a derived PageObject
    #
    #   expected_radio_buttons [:individual, :limited_company]
    #
    # there are associated expectation, for example in feature tests you can do
    #
    #     expect(my_page_object).to have_nothing_selected
    #
    def expected_radio_button_ids(radio_list)
      instance_eval <<-CODE, __FILE__, __LINE__ + 1
        def radio_button_ids
          #{radio_list}
        end
      CODE
    end

    # Build set of Helpers that match your view IDs
    #
    # Usage:
    #
    # Given that you have Radio button group with Ids defined dynamically with
    #   <% @organisation_types.each do |organisation_type|
    #     <%= form.radio_button  ...  id: "organisation_#{organisation_type.name}"
    #
    # Setup helpers to get any id or choose any id, choose and id and submit
    #
    def radio_button_helpers(radio_list)
      # N.B These are class_eval so methods called on a PageObject instance
      # (not class) as the instance has access to page level Capybara feature  methods

      # Helper method - verify_nothing_selected
      # ENSURE on first visit that NO radio button selected

      class_eval <<-CODE, __FILE__, __LINE__ + 1
         def verify_nothing_selected
            #{radio_list}.each do |radio|
              expect(find(\"#\#{radio}\")).to_not be_checked
            end
          end
      CODE

      radio_list.each do |radio|
        # N.B These are class_eval so methods called on a PageObject instance
        # (not class) as the instance has access to page level feature  methods
        # (Capybara) such as CHOOSE, submit etc

        # Helper methods to CHOOSE a particular buttons

        #   BusinessTypePage.choose_individual_soletrader
        #   BusinessTypePage.choose_partnership
        # etc
        #
        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def choose_#{radio}
            choose("#{radio}")
          end
        CODE

        # Helper methods to CLICK a particular button & SUBMIT Form in one
        #   BusinessTypePage.advance_via_radio_partnership
        #
        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def advance_via_radio_#{radio}
            send("choose_#{radio}")
            submit
          end
        CODE
      end
    end
  end
end
