require "test_helper"

class TaskListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get task_lists_index_url
    assert_response :success
  end

  test "should get new" do
    get task_lists_new_url
    assert_response :success
  end

  test "should get create" do
    get task_lists_create_url
    assert_response :success
  end

  test "should get edit" do
    get task_lists_edit_url
    assert_response :success
  end

  test "should get update" do
    get task_lists_update_url
    assert_response :success
  end

  test "should get destroy" do
    get task_lists_destroy_url
    assert_response :success
  end
end
