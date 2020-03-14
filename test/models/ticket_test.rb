require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "user_id must be present" do
    ticket = Ticket.new(user_id: '', title: 'Test Tag')
    assert_not ticket.valid?
  end

  test "title must be present" do
    ticket = Ticket.new(user_id: '1', title: '')
    assert_not ticket.valid?
  end

  test "all_tags cannot exceed 5" do
    ticket = Ticket.new(user_id: '1', title: 'Test Tag', all_tags: ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6"])
    assert_not ticket.valid?
  end

  test "ticket can save with no tags" do
    ticket = Ticket.new(user_id: '1', title: 'Test Tag')
    assert ticket.save, "Saved the ticket without tags"
  end
end
