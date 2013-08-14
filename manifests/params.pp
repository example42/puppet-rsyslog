# Class: rsyslog::params
#
# This class defines default parameters used by the main module class rsyslog
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to rsyslog class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class rsyslog::params {

  ### Module specific varibale
  $mode = 'client'
  $syslog_server = ''
  $syslog_server_port = '514'

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'rsyslog',
  }

  $service = $::operatingsystem ? {
    OpenSuSE => 'syslog',
    default  => 'rsyslog',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'rsyslogd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'rsyslog',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/rsyslog.d',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/rsyslog.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/rsyslog',
    default                   => '/etc/sysconfig/rsyslog',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/run/rsyslogd.pid',
    default                   => '/var/run/rsyslog.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/rsyslog',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '',
  }

  $port = '514'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $content = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
