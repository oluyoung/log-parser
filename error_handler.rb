require 'pathname'

class ErrorHandler
  def check_multiple_args(argument_size)
    if argument_size > 1
      raise ArgumentError, "Only 1 file can be parsed at a time"
    end
  end

  def validate_file(file)
    raise ArgumentError, "A file must be passed" unless file

    pn = Pathname.new(file)
    raise ArgumentError, "File does not exist" unless pn.exist?
    raise ArgumentError, "Enter a file not a directory" if pn.directory?
    # NOTE: assuming that any x.log has content like this /about 1.1.1.1
    # So content in any x.log will not be verified later on
    raise NameError, "File is not a log file" unless pn.extname == '.log'
    raise ArgumentError, "File is empty" unless pn.size?
    raise ArgumentError, "Parser cannot read the file, check its permissions" unless pn.readable?
  end
end
