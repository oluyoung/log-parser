require_relative 'paths'
require_relative 'printer'

class Parse
  attr_accessor :paths

  def initialize(log)
    @paths = Paths.new
    self.read_log(log)
  end

  def read_log(log)
    File.open(log, 'r') do |file|
      begin
        for line in file.readlines()
          # NOTE: Assuming that any .log file is formatted like <path ip>\n
          self.add_path(line)
        end
      rescue => error
        raise error
      end
    end
    self.generate_output
  end

  def generate_output
    printer = Printer.new
    printer.write_visitations(@paths.paths_by_visitations)
    printer.write_unique_views(@paths.paths_by_unique_views)
  end

  def add_path(line)
    pathAndIp = line.split(' ')
    @paths.add_path(pathAndIp[0], pathAndIp[1])
  end
end
