require 'test_helper'

class RaceControllerTest < ActionDispatch::IntegrationTest
  test 'レース一覧を見れる' do
    get '/races'
    assert_response :success
    assert_select 'title', 'レース一覧 - ウマグラフ'
  end

  test 'レースの詳細を見れる' do
    get '/race/c201703020402'
    assert_response :success
    assert_select "title", "２歳未勝利"
  end
end
