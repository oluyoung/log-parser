require_relative 'test_helper'

class PathsTest < Minitest::Test

  def setup
    @paths = Paths.new
    @path = '/about'
    @ip = '1.1.1.1'
  end

  def test_add_new_path
    @paths.add_path(@path, @ip)

    assert @paths.paths[@path]
    assert_equal 1, @paths.paths[@path].visits
    assert_equal 1, @paths.paths[@path].visitors_list.length
  end

  def test_add_existing_path
    @paths.add_path(@path, @ip)
    lengthWithNewPath = @paths.paths.length

    @paths.add_path(@path, @ip)
    lengthWithAddedExistingPath = @paths.paths.length

    assert_equal lengthWithNewPath, lengthWithAddedExistingPath
    assert_equal 2, @paths.paths[@path].visits
    assert_equal 1, @paths.paths[@path].visitors_list.length
  end

  def test_add_nil_path
    @paths.add_path(nil, @ip)
    lengthWithNewPath = @paths.paths.length

    assert_equal 0, lengthWithNewPath
  end

  def test_add_nil_ip
    @paths.add_path(@path, nil)
    lengthWithNewPath = @paths.paths.length

    assert_equal 0, lengthWithNewPath
  end

  def test_add_empty_path
    @paths.add_path('', @ip)
    lengthWithNewPath = @paths.paths.length

    assert_equal 0, lengthWithNewPath
  end

  def test_add_empty_ip
    @paths.add_path(@path, '')
    lengthWithNewPath = @paths.paths.length

    assert_equal 0, lengthWithNewPath
  end

  def test_add_invalid_path
    @paths.add_path('\\path', @ip)
    lengthWithNewPath = @paths.paths.length

    assert_equal 0, lengthWithNewPath
  end

  def test_get_sorted_paths_by_visitations
    add_multiple_paths

    sorted = @paths.paths_by_visitations

    assert_equal 4, sorted.first[1].visits
    assert_equal '/page/18', sorted.first[0]
  end

  def test_get_sorted_paths_by_unique_views
    add_multiple_paths
    sorted = @paths.paths_by_unique_views

    assert_equal 3, sorted.first[1].unique_views
    assert_equal '/page/18', sorted.first[0]
  end

  protected
  def add_multiple_paths
    for i in 1..20
      @paths.add_path("/page/#{i}", "1.1.1.#{i}")
      @paths.add_path("/page/#{i}", "1.1.1.#{i+1}") if i % 2 == 0
      @paths.add_path("/page/#{i}", "1.1.1.#{i+2}") if i % 18 == 0
      @paths.add_path("/page/#{i}", "1.1.1.#{i+1}") if i % 18 == 0
    end
  end
end
