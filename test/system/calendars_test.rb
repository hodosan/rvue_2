require "application_system_test_case"

class CalendarsTest < ApplicationSystemTestCase
  setup do
    @calendar = calendars(:one)
  end

  test "visiting the index" do
    visit calendars_url
    assert_selector "h1", text: "Calendars"
  end

  test "should create calendar" do
    visit calendars_url
    click_on "New calendar"

    fill_in "Begin time", with: @calendar.begin_time
    fill_in "Close time", with: @calendar.close_time
    fill_in "Day", with: @calendar.day
    fill_in "Interval e", with: @calendar.interval_e
    fill_in "Interval s", with: @calendar.interval_s
    check "No use" if @calendar.no_use
    fill_in "Unit minute", with: @calendar.unit_minute
    click_on "Create Calendar"

    assert_text "Calendar was successfully created"
    click_on "Back"
  end

  test "should update Calendar" do
    visit calendar_url(@calendar)
    click_on "Edit this calendar", match: :first

    fill_in "Begin time", with: @calendar.begin_time
    fill_in "Close time", with: @calendar.close_time
    fill_in "Day", with: @calendar.day
    fill_in "Interval e", with: @calendar.interval_e
    fill_in "Interval s", with: @calendar.interval_s
    check "No use" if @calendar.no_use
    fill_in "Unit minute", with: @calendar.unit_minute
    click_on "Update Calendar"

    assert_text "Calendar was successfully updated"
    click_on "Back"
  end

  test "should destroy Calendar" do
    visit calendar_url(@calendar)
    click_on "Destroy this calendar", match: :first

    assert_text "Calendar was successfully destroyed"
  end
end
