#!/usr/bin/env ruby
require_relative 'error_handler'
require_relative 'parse'

log_file = ARGV.first

ErrorHandler.check_multiple_args(ARGV.length)
ErrorHandler.validate_file(log_file)

Parse.new(log_file)
