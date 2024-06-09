require "application_system_test_case"

class RegulationsTest < ApplicationSystemTestCase
  setup do
    @regulation = regulations(:one)
  end

  test "visiting the index" do
    visit regulations_url
    assert_selector "h1", text: "Regulations"
  end

  test "should create regulation" do
    visit regulations_url
    click_on "New regulation"

    fill_in "Begin time", with: @regulation.begin_time
    fill_in "Close time", with: @regulation.close_time
    fill_in "Interval e", with: @regulation.interval_e
    fill_in "Interval s", with: @regulation.interval_s
    fill_in "Unit minute", with: @regulation.unit_minute
    fill_in "Version", with: @regulation.version
    click_on "Create Regulation"

    assert_text "Regulation was successfully created"
    click_on "Back"
  end

  test "should update Regulation" do
    visit regulation_url(@regulation)
    click_on "Edit this regulation", match: :first

    fill_in "Begin time", with: @regulation.begin_time
    fill_in "Close time", with: @regulation.close_time
    fill_in "Interval e", with: @regulation.interval_e
    fill_in "Interval s", with: @regulation.interval_s
    fill_in "Unit minute", with: @regulation.unit_minute
    fill_in "Version", with: @regulation.version
    click_on "Update Regulation"

    assert_text "Regulation was successfully updated"
    click_on "Back"
  end

  test "should destroy Regulation" do
    visit regulation_url(@regulation)
    click_on "Destroy this regulation", match: :first

    assert_text "Regulation was successfully destroyed"
  end
end
