require "test_helper"

class BookTest < ActiveSupport::TestCase
  setup do
    @book = books(:one)
  end

  test "should be valid with valid attributes" do
    assert @book.valid?
  end

  test "should require title" do
    @book.title = nil
    assert_not @book.valid?
  end

  test "should require author" do
    @book.author = nil
    assert_not @book.valid?
  end

  test "should require api_id" do
    @book.api_id = nil
    assert_not @book.valid?
  end

  test "should have unique api_id" do
    book = Book.new(title: "Test", author: "Author", api_id: @book.api_id)
    assert_not book.valid?
  end

  test "should have many readings" do
    assert_respond_to @book, :readings
  end
end
