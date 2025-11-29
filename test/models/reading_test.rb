require "test_helper"

class ReadingTest < ActiveSupport::TestCase
  setup do
    @reading = readings(:one)
  end

  test "should be valid with valid attributes" do
    assert @reading.valid?
  end

  test "should require user_id" do
    @reading.user_id = nil
    assert_not @reading.valid?
  end

  test "should require book_id" do
    @reading.book_id = nil
    assert_not @reading.valid?
  end

  test "should not allow duplicate user_book combinations" do
    reading = Reading.new(user_id: @reading.user_id, book_id: @reading.book_id)
    assert_not reading.valid?
  end

  test "should validate progress between 0 and 100" do
    @reading.progress = 50
    assert @reading.valid?
    
    @reading.progress = 101
    assert_not @reading.valid?
    
    @reading.progress = -1
    assert_not @reading.valid?
  end

  test "should set finished when progress is 100" do
    @reading.progress = 100
    @reading.save
    assert @reading.finished?
  end
end
