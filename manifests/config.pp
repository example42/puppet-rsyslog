# = Define: rsyslog::config
#
# This defines places a config file in rsyslog.d
#
# == Parameters
#
# [*source*]
#   Sets the value of source parameter for the rsyslog fragment
#
# [*template*]
#   Sets the value of content parameter for the rsyslog fragment
#   Note: This option is alternative to the source one
#
# [*ensure*]
#   Define if the fragment should be present (default) or 'absent'
#
# [*order*]
#   Sets the order of the fragment inside /etc/rsyslogers or /etc/rsyslogers.d
#   Default 20
#
define rsyslog::config (
  $ensure  = present,
  $content = '',
  $source  = '',
  $order   = '20',
) {

  include rsyslog

  # rsyslog skipping file names that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  $manage_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_content = $content ? {
    ''        => undef,
    default   => $content,
  }


  file { "${rsyslog::config_dir}/${order}_${dname}.conf":
    ensure  => $ensure,
    mode    => $rsyslog::config_file_mode,
    owner   => $rsyslog::config_file_owner,
    group   => $rsyslog::config_file_group,
    content => $manage_content,
    source  => $manage_source,
    notify  => $rsyslog::manage_service_autorestart,
    require => Package[$rsyslog::package],
    replace => $rsyslog::manage_file_replace,
    audit   => $rsyslog::manage_audit,
  }

}
