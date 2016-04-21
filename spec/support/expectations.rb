require "rspec/expectations"

# USAGE :
# Each Page has the same error functionality - a small partial at top with details of the errors
# and then a link from there, down to the actual field (within the form) the error relates to.
#
# In format : "#form_group_#{key}"
#
#     expect(page).to have_error_anchors( "key" )
#
RSpec::Matchers.define :have_error_anchors do |key, text: nil|
  m1 = nil
  m2 = nil # matchers
  r1 = false
  r2 = false # results

  match do |page|
    m1 = have_error_anchors_summary(key, text) # this returns matcher instances
    m2 = have_error_anchors_div_and_message(key, text)

    r1 = m1.matches?(page) # evaluate matchers
    r2 = m2.matches?(page)

    r1 && r2 # true if both are true
  end

  failure_message do |_actual| # collect error messages from matchers
    messages = []
    messages << m1.failure_message unless r1
    messages << m2.failure_message unless r2
    messages.join("\n")
  end
end

RSpec::Matchers.define :have_error_anchors_div_and_message do |key, text: nil|
  # anchor link target in form
  field_css = "div#form_group_#{key}.form-group.error .error-message"

  match do |page|
    if text
      expect(page).to have_css(field_css, text: text)
    else
      expect(page).to have_css(field_css)
    end
  end
  failure_message do |_actual|
    msg = "expected page to have error anchors div and message #{field_css}"
    msg += %{ (text: "#{text}")} if text
    msg
  end
end

RSpec::Matchers.define :have_error_anchors_summary do |key, text: nil|
  summary_css = ".error-summary a.error-text[href='#form_group_#{key}']"

  match do |page|
    if text
      expect(page).to have_css(summary_css, text: text)
    else
      expect(page).to have_css(summary_css)
    end
  end
  failure_message do |_actual|
    msg = "expected page to have error summary #{summary_css}"
    msg += %{ (text: "#{text}")} if text
    msg
  end
end

# USAGE :

# First in your PageObject class, define the text you expect to find
# on that page
#
#   expected_page_text "This is the text I expect in my very own Page"
#
# Now in feature tests you can test if you are on that particular page with
#
#     expect(page).to be_on_page_object( my_very_own_page_object )
#
RSpec::Matchers.define :be_on_page_object do |page_object|
  match do |page|
    expect(page).to have_text(page_object.class.on_page_text)
  end
  failure_message do |_actual|
    "expected to be on page object #{page_object.class}"\
    " but text #{page_object.class.on_page_text} not found"
  end
end

RSpec::Matchers.define :be_on_page_object_klass do |page_object_class|
  match do |page|
    expect(page).to be_on_page_object page_object_class.new
  end
end

# First in your PageObject class, define the radio button group
# for which initial state is nothing  selected
#
#   expected_radio_buttons  %w{Pharmacy Farming}
#
# Now in feature tests you can do
#
#     expect(my_very_own_page_object).to have_nothing_selected
#
RSpec::Matchers.define :have_nothing_selected do
  match do |page_object|
    page_object.class.radio_button_ids.each do |id|
      expect(find('#' + id)).to_not be_checked
    end
  end
end

# Shortcut to check a page contains a particular radio button
#
#     expect(page).to have_input_radio( "event_on_farm" )
#
RSpec::Matchers.define :have_input_radio do |id|
  match do |page|
    expect(page).to have_css("input.radio##{id}")
  end
end
