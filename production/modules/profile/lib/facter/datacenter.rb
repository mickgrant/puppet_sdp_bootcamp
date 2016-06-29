Facter.add('datacenter') do
  confine :kernel => 'Linux'
  setcode do
    hostname = Facter.value(:hostname)
  
    if hostname =~ /^lon/
      answer = "London"
    elsif hostname =~ /^pdx/
      answer = "Portland"
    elsif hostname =~ /^nyc/
      answer = "New_York"
    end
  end
end
