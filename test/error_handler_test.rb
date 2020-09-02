require_relative 'test_helper'

class ErrorHandlerTest < Minitest::Test

  def setup
    @file = Tempfile.new(['server', '.log'], nil)
  end

  def test_error_when_multiple_arguments_passed
    err = assert_raises ArgumentError do |error|
      ErrorHandler.check_multiple_args(3)
    end
    assert_equal "Only 1 file can be parsed at a time", err.message
  end

  def test_error_when_no_argument
    err = assert_raises ArgumentError do
      ErrorHandler.validate_file(nil)
    end
    assert_equal "A file must be passed", err.message
  end

  def test_error_if_file_does_not_exist
    err = assert_raises ArgumentError do
      ErrorHandler.validate_file('x.log')
    end
    assert_equal "File does not exist", err.message
  end

  def test_error_if_file_is_file
    err = assert_raises StandardError do
      ErrorHandler.validate_file('.')
    end
    assert_equal "Enter a file not a directory", err.message
  end

  def test_error_if_file_is_not_log_file
    file = Tempfile.new('server.txt')

    err = assert_raises StandardError do
      ErrorHandler.validate_file(file.path)
    end
    assert_equal "File is not a log file", err.message

    file.close
    file.unlink
  end

  def test_error_if_file_is_empty
    err = assert_raises StandardError do
      ErrorHandler.validate_file(@file.path)
    end
    assert_equal "File is empty", err.message
  end

  def test_error_if_file_cannot_be_read
    remove_file_permissions

    err = assert_raises StandardError do
      ErrorHandler.validate_file(@file.path)
    end
    assert_equal "Parser cannot read the file, check its permissions", err.message
  end

  def teardown
    @file.close
    @file.unlink
  end

  protected
  def remove_file_permissions
    File.open(@file.path, "w") do |f|
      f.write('hello')
      File.chmod(0000, @file.path)
    end
  end
end
