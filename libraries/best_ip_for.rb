module BestIpFor
  def best_ip_for(other)
    if other['cloud']
      if node['cloud'] &&
        other['cloud']['provider'] == node['cloud']['provider']
        other['cloud']['local_ipv4']
      else
        other['cloud']['public_ipv4']
      end
    else
      other['ipaddress']
    end
  end
end
