require 'uri'
require 'ipaddr'

module LogValidator
  def valid_path(path)
    begin
      URI.parse("http://test.com#{path}")
      true
    rescue
      false
    end
  end

  def valid_ip(ip)
    begin
      IPAddr.new ip
      true
    rescue
      false
    end
  end
end
