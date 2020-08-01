require_relative 'test_helper'
require 'pathname'

class PrinterTest < Minitest::Test
  def setup
    @printer = Printer.new
    @pn = Pathname
    @paths = Paths.new
    @paths.paths['/about'] = Path.new
    @paths.paths['/about'].visits = 1
    @paths.paths['/about'].visitors_list = ['1.1.1.1']
  end

  def test_dont_write_visitations_if_paths_empty
    @printer.write_visitations({})
    refute Pathname.new('_most_visited.txt').exist?
  end

  def test_write_visitations_if_paths
    @printer.write_visitations @paths.paths
    assert Pathname.new('_most_visited.txt').exist?
  end

  def test_dont_write_unique_views_if_path_empty
    @printer.write_unique_views({})
    refute Pathname.new('_most_visited.txt').exist?
  end

  def test_write_unique_views
    @printer.write_unique_views @paths.paths
    assert Pathname.new('_unique_views.txt').exist?
  end

  def teardown
    pn = Pathname.new('_most_visited.txt')
    pn.unlink if pn.exist?

    pn2 = Pathname.new('_unique_views.txt')
    pn2.unlink if pn2.exist?
  end
end
