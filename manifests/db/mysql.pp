define mediawiki::db::mysql (
  $mysqldb_hash = {},
) {

  file { '/tmp/mediawiki-tables.sql' :
    ensure => present,
    source => 'puppet:///modules/mediawiki/tables.sql',
  } ->
  file { '/tmp/mediawiki-interwiki.sql' :
    ensure => present,
    source => 'puppet:///modules/mediawiki/interwiki.sql',
  }
   
  include ::mysql::server
  create_resources('mysql::db', $mysqldb_hash, { 'require' => 'File[/tmp/mediawiki-interwiki.sql]'})

}
