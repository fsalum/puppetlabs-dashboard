# Class: dashboard::passenger
#
# This class configures parameters for the puppet-dashboard module.
#
# Parameters:
#   [*dashboard_site*]
#     - The ServerName setting for Apache
#
#   [*dashboard_iface*]
#     - The address on which puppet-dashboard should listen
#
#   [*dashboard_port*]
#     - The port on which puppet-dashboard should run
#
#   [*dashboard_config*]
#     - The Dashboard configuration file
#
#   [*dashboard_root*]
#     - The path to the Puppet Dashboard library
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class dashboard::passenger (
  $dashboard_site,
  $dashboard_iface,
  $dashboard_port,
  $dashboard_config,
  $dashboard_root
) inherits dashboard {

  require ::passenger
  include apache

  apache::vhost { $dashboard_site:
    vhost_name => $dashboard_iface ? {
      '0.0.0.0' => '*',
      default   => $dashboard_iface,
    },
    port       => $dashboard_port,
    priority   => '50',
    docroot    => "${dashboard_root}/public",
    template   => 'dashboard/passenger-vhost.erb',
  }
}
