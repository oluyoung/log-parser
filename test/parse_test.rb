require_relative 'test_helper'

class ParseTest < Minitest::Test
  def setup
    @file = Tempfile.new(['server', '.log'], nil)
  end

  def test_read_log_is_called_on_initialize
    paths_spy = Spy.on_instance_method(Paths, :initialize)
    read_log_spy = Spy.on_instance_method(Parse, :read_log)

    @parse = Parse.new(@file.path)

    assert paths_spy.has_been_called?
    assert read_log_spy.has_been_called?
    assert read_log_spy.has_been_called_with? @file.path
  end

  def test_read_log
    write_to_file
    generate_output_spy = Spy.on_instance_method(Parse, :generate_output)
    add_path_spy = Spy.on_instance_method(Parse, :add_path)

    @parse = Parse.new(@file.path)

    assert add_path_spy.has_been_called?
    assert add_path_spy.has_been_called_with? '/about 1.1.1.1'
    assert generate_output_spy.has_been_called?
  end

  def test_error_is_raised_on_bad_file
    assert_raises StandardError do
      Parse.new('bad-file.txt')
    end
  end

  def test_generate_output
    write_to_file
    printer_visit_spy = Spy.on_instance_method(Printer, :write_visitations)
    printer_unique_spy = Spy.on_instance_method(Printer, :write_unique_views)

    @parse = Parse.new(@file.path)

    assert printer_visit_spy.has_been_called?
    assert printer_unique_spy.has_been_called?
  end

  def teardown
    @file.close
    @file.unlink
  end

  protected
  def write_to_file
    File.open(@file.path, "w") do |f|
      f.write('/about 1.1.1.1')
    end
  end
end
