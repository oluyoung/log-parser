require_relative 'test_helper'

class LogValidatorTest < Minitest::Test
  include LogValidator

  def test_valid_path
    valid_path('/good-path')
  end

  def test_valid_ip
    valid_ip('1.1.1.1')
  end

  def test_invalid_path
    valid_path('bad')
  end

  def test_invalid_ip
    valid_ip('bad')
  end
end
