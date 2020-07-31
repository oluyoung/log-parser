require_relative 'test_helper'

class PathTest < Minitest::Test

  def setup
    @path = Path.new
  end

  def test_visits_increments
    assert_equal 1, @path.visits
    @path.add_visit
    assert_equal 2, @path.visits
  end

  def test_get_unique_views
    assert_equal 0, @path.unique_views
    @path.add_uniqiue_visitor('1.1.1.1')
    assert_equal 1, @path.unique_views
  end

  def test_add_unique_visitor_for_unique_ip
    @path.visitors_list = ['1.1.1.1']
    @path.add_uniqiue_visitor('1.1.1.2')
    assert_equal 2, @path.visitors_list.length
  end

  def test_add_unique_visitor_for_existing_ip
    @path.visitors_list = ['1.1.1.1']
    @path.add_uniqiue_visitor('1.1.1.1')
    assert_equal 1, @path.visitors_list.length
  end
end
