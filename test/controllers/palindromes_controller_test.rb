require "test_helper"

class PalindromesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @palindrome = palindromes(:one)
    @controller = PalindromesController.new
  end

  test "should get index" do
    get palindromes_url
    assert_response :success
  end

  test "should get new" do
    get new_palindrome_url
    assert_response :success
  end

  test "should show palindrome" do
    get palindrome_url(@palindrome)
    assert_response :success
  end

  test "should destroy palindrome" do
    assert_difference('Palindrome.count', -1) do
      delete palindrome_url(@palindrome)
    end

    assert_redirected_to palindromes_url
  end

  test 'should calculate different answers for different queries' do
    first_result = @controller.send :output, '100'
    second_result = @controller.send :output, '121'
    assert_not_equal first_result, second_result
  end
end
