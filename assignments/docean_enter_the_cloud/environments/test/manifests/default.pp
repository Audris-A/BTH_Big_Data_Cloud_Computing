class baseconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }
}

class nodejs {  
  exec { 'apt-get install -y curl':
    command => '/usr/bin/apt-get install -y curl';
  }
 
  exec { 'curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -':
    command => '/usr/bin/curl update -sL https://deb.nodesource.com/setup_12.x | sudo -E /bin/bash -';
  }
  
  exec { 'apt-get install -y nodejs':
    command => '/usr/bin/apt-get install -y nodejs';
  }
}

class mysql {
  package { ['mysql-server']:
    ensure => present;
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'];
  }
}

include baseconfig

node 'appserver' {
  include nodejs
}

node 'dbserver' {
  include mysql
}
