require "application_system_test_case"

class CustomerInfosTest < ApplicationSystemTestCase
  setup do
    @customer_info = customer_infos(:one)
  end

  test "visiting the index" do
    visit customer_infos_url
    assert_selector "h1", text: "Customer Infos"
  end

  test "creating a Customer info" do
    visit customer_infos_url
    click_on "New Customer Info"

    fill_in "Address", with: @customer_info.address
    fill_in "City", with: @customer_info.city
    fill_in "County", with: @customer_info.county
    fill_in "Customername", with: @customer_info.customerName
    fill_in "Postcode", with: @customer_info.postcode
    fill_in "Telephone", with: @customer_info.telephone
    fill_in "User", with: @customer_info.user_id
    click_on "Create Customer info"

    assert_text "Customer info was successfully created"
    click_on "Back"
  end

  test "updating a Customer info" do
    visit customer_infos_url
    click_on "Edit", match: :first

    fill_in "Address", with: @customer_info.address
    fill_in "City", with: @customer_info.city
    fill_in "County", with: @customer_info.county
    fill_in "Customername", with: @customer_info.customerName
    fill_in "Postcode", with: @customer_info.postcode
    fill_in "Telephone", with: @customer_info.telephone
    fill_in "User", with: @customer_info.user_id
    click_on "Update Customer info"

    assert_text "Customer info was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer info" do
    visit customer_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer info was successfully destroyed"
  end
end
