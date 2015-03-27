# == Class: mediawiki
#
# Full description of class mediawiki here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*package_ensure*]
#   State of the package on the system. Possible value : present, absent
#   Defaults: Present
#
# [*package_name*]
#   Name of the package to install
#   Default: mediawiki119
#
# === Examples
#
#  include ::mediawiki
#
# === Authors
#
# Yanis Guenane (yguenane@gmail.com)
#
# === Copyright
#
# Copyright 2014-2015 Yanis Guenane
#
class mediawiki (
  $package_ensure = 'present',
  $package_name   = 'mediawiki119',
) inherits mediawiki::params {

  include ::epel
  include ::apache
  include ::apache::mod::php

  package { 'mediawiki' :
    ensure => $mediawiki::package_ensure,
    name   => $mediawiki::package_name,
  }

}
