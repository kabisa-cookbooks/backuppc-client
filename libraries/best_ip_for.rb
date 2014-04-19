#
# The best IP address for the given node, in the context of the current node.
# Useful for choosing a local IP address over a public one to limit bandwidth on
# cloud providers.
#
# See: https://github.com/sethvargo/chef-sugar#ip
#
# @param [Chef::Node] other
#   the node to calculate the best IP address for
#
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
