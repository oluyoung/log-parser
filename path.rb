class Path
  attr_accessor :visits, :visitors_list

  def initialize
    @visits = 0
    @visitors_list = []
  end

  def add_visit
    @visits = @visits + 1
  end

  def unique_views
    @visitors_list.length
  end

  def average_views
    @visits / unique_views
  end

  def add_uniqiue_visitor(ip)
    @visitors_list << ip unless @visitors_list.include? ip
  end
end
