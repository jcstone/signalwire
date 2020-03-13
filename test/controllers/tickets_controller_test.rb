require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should create ticket" do
    assert_difference('Ticket.count') do
      post tickets_url, params: { tags: ["tag1", "tag2"], ticket: { title: "test", user_id: 1 } }, as: :json
    end

    assert_response 201
  end

  test "increment running count" do
    assert_difference('Tag.last.running_count') do
      post tickets_url, params: { tags: ["tag1", "tag2"], ticket: { title: "test", user_id: 1 } }, as: :json
      post tickets_url, params: { tags: ["tag1", "tag2"], ticket: { title: "test2", user_id: 2 } }, as: :json
    end

    assert_response 201
  end
end
