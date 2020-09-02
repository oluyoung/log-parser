require_relative 'paths'
require_relative 'printer'

class Parse
  def initialize(log)
    @paths = Paths.new
    read_log(log)
  end

  def read_log(log)
    file = File.foreach(log)
    begin
      # NOTE: Assuming that any .log file is written like <path ip>\n
      file.each_entry do |line|
          add_path(line)
      end
    rescue => error
      raise error
    end

    generate_output
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
