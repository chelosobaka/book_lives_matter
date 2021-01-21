require "application_system_test_case"

class BookListsTest < ApplicationSystemTestCase
  setup do
    @book_list = book_lists(:one)
  end

  test "visiting the index" do
    visit book_lists_url
    assert_selector "h1", text: "Book Lists"
  end

  test "creating a Book list" do
    visit book_lists_url
    click_on "New Book List"

    fill_in "Book", with: @book_list.book_id
    fill_in "List", with: @book_list.list_id
    click_on "Create Book list"

    assert_text "Book list was successfully created"
    click_on "Back"
  end

  test "updating a Book list" do
    visit book_lists_url
    click_on "Edit", match: :first

    fill_in "Book", with: @book_list.book_id
    fill_in "List", with: @book_list.list_id
    click_on "Update Book list"

    assert_text "Book list was successfully updated"
    click_on "Back"
  end

  test "destroying a Book list" do
    visit book_lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book list was successfully destroyed"
  end
end
