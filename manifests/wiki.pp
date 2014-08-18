define mediawiki::wiki (
  $vhost       = {},
  $options     = {},
  $manage_db   = true,
  $db_settings = undef,
) {

  if !$db_settings and $manage_db {
    fail('You must specify $db_settings, since $manage_db is set to true')
  }

  include ::mediawiki
  
  create_resources('apache::vhost', $vhost)
  create_resources('mediawiki::db::mysql', $db_settings)

  $final_options = merge($mediawiki::params::options, $options)

  if $manage_db {
    include ::mediawiki::db::mysql
  }

  exec { "cp -r /var/www/${::mediawiki::package_name} /var/www/${name}}" :
    unless => "stat /var/www/${name}",
    path   => '/bin',
  } ->
  file { "/var/www/${name}/LocalSettings.php" :
    ensure  => present,
    content => template('mediawiki/LocalSettings.php.erb'),
  }
}
