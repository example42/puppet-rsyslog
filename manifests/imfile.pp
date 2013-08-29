# = Define: rsyslog::imfile
#
# This defines creates an entry in rsyslod.d to manage via rsyslog
# an external log file. It's based on https://github.com/saz/puppet-rsyslog
#
# == Parameters
#
# [*file_name*]
#   The full path of the file to monitor. Required.
#
# [*file_tag*]
#   A custom tag for the file. Required.

# [*file_facility*]
#   The log facility. Default: user
#
# [*file_severity*]
#   The log severity. Default: notice
#
# [*polling_interval*]
#   Rsyslog polling interval on the log, in secords. Default: 10
#
# [*run_file_monitor*]
#   If to enable file monitoring. Default true
#
# [*template*]
#   Optional custom template to use to create the file in rsyslog.d
#   Default: 'rsyslog/imfile.erb'
#
# [*order*]
#   The order with which the file is created in rsyslog.d
#
# [*ensure*]
#   Default: present. Set to absent to remove a proviously defined file
#
# == Examples
#
#  rsyslog::imfile { 'apache-error':
#    file_name     => '/var/log/apache/error.log',
#    file_tag      => 'apache--error',
#    file_facility => 'warn',
#  }
#
define rsyslog::imfile (
  $file_name,
  $file_tag,
  $file_facility    = 'user',
  $file_severity    = 'notice',
  $polling_interval = 10,
  $run_file_monitor = true ,
  $template         = 'rsyslog/imfile.erb',
  $order            = '25',
  $ensure           = present,
  ) {

  include rsyslog

  # rsyslog skipping file names that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  file { "rsyslog_${name}":
    ensure  => $ensure,
    path    => "${rsyslog::config_dir}/${order}_${dname}.conf",
    owner   => $rsyslog::config_file_owner,
    group   => $rsyslog::config_file_group,
    mode    => $rsyslog::config_file_mode,
    content => template($template),
    require => Package[$rsyslog::package],
    notify  => $rsyslog::manage_service_autorestart,
    replace => $rsyslog::manage_file_replace,
    audit   => $rsyslog::manage_audit,
  }

}
