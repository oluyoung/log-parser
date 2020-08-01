require 'uri'
require 'ipaddress'

module LogValidator
  def valid_path(path)
    uri = "http://test.com#{path}"
    regex = /^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
    uri.match(regex)
    # !(uri !~ URI::regexp)
  end

  def valid_ip(ip)
    IPAddress.valid? ip
  end
end
