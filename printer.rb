class Printer
  def write_visitations(paths_by_visitations)
    if paths_by_visitations.length > 0
      file = File.open("_most_visited.txt", 'w')
      paths_by_visitations.each_pair do |path, values|
        file.write("#{path} #{values.visits} visits\n")
      end
    end
  end

  def write_unique_views(paths_by_unique_views)
    if paths_by_unique_views.length > 0
      file = File.open("_unique_views.txt", 'w')
      paths_by_unique_views.each_pair do |path, values|
        file.write("#{path} #{values.unique_views} unique_views\n")
      end
    end
  end
end
