exec { 'apt-update':
  command => 'apt update',
  path => '/usr/bin',
}
exec { 'apt-update_1':
  command => 'apt update',
  path => '/usr/bin',
}

package { 'apache2':
  ensure => installed,
}

service { 'apache2':
  ensure => running,
}

package { 'mysql-server':
  ensure => installed,
}
package { 'mysql-client':
  ensure => installed,
}
package { 'php':
  ensure => installed,
}
package { 'libapache2-mod-php':
  ensure => installed,
}
package { 'php-mysql':
  ensure => installed,
}
exec { 'mysqladmin':
  command => 'mysqladmin -u root password rootpassword',
  path => '/usr/bin',
}
exec { 'mysqlcommands':
  command => 'wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands',
  path => '/usr/bin',
  cwd => '/tmp'
}
exec { 'mysql_root_user':
  command => 'mysql -uroot -prootpassword < /tmp/mysqlcommands',
  path => '/tmp/mysqlcommands',
}
exec { 'Download_wordpress':
  command => 'wget https://wordpress.org/latest.zip',
  path => '/usr/bin',
  cwd => '/tmp'
}
package { 'unzip':
  ensure => installed,
}
exec { 'unzip_wordpress':
  command => 'unzip /tmp/latest.zip -d /var/www/html',
  path => '/usr/bin',
}
exec { 'wordpress_config':
  command => 'wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php',
  path => '/usr/bin',
  cwd => '/var/www/html/wordpress'
}
file {"/var/www/html/wordpress/wp-config.php":
ensure => present,
source => "/var/www/html/wordpress/wp-config-sample.php",
}
file {"/var/www/html/wordpress":
ensure => directory,
mode => "775",
owner => "www-data",
group => "www-data",
}
exec { 'apache2_restart':
  command => 'service apache2 restart',
  path => '/usr/sbin',
}







