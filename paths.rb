require_relative 'path'
require_relative 'log_validator'

class Paths
  include LogValidator
  attr_accessor :paths

  def initialize
    @paths = {}
  end

  def add_path(path, ip)
    if !(path_exists path) && !(is_invalid_line path, ip)
      @paths[path] = Path.new
    end
    if path_exists path
      @paths[path].add_visit
      @paths[path].add_uniqiue_visitor(ip)
    end
  end

  def paths_by_visitations
    @paths.sort_by {|path, values| -values.visits }.to_h
  end

  def paths_by_unique_views
    @paths.sort_by {|path, values| -values.unique_views }.to_h
  end

  def paths_by_average_views
    @paths.sort_by {|path, values| -values.average_views }.to_h
  end

  protected
  def path_exists(path)
    !!@paths[path]
  end

  def is_invalid_line(path, ip)
    # not checking ip validity because the ips in the sample log are invalid
    path.nil? or ip.nil? or path.empty? or ip.empty? or !valid_path(path)
  end
end
