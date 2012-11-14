class nodejs ( $version, $logoutput = 'on_failure' ) {

  if ! defined(Package['curl']) {
    package { 'curl':
      ensure => present,
    }
  }

  package { 'openssl-devel':
    ensure => present,
  }
  package { 'make':
    ensure => present,
  }
  package { 'glibc-devel':
    ensure => present,
  }
  package { 'gcc':
    ensure => present,
  } 
  package { 'gcc-c++':
    ensure => present,
  }
  # use nave, yo
  exec { 'nave' :
    command     => "bash -c \"\$(curl -s 'https://raw.github.com/isaacs/nave/master/nave.sh') usemain $version \"",
    path        => [ "/usr/local/bin", "/bin" , "/usr/bin" ],
    require     => [ Package[ 'curl' ], Package[ 'openssl-devel' ], Package[ 'make' ], Package[ 'glibc-devel' ], Package[ 'gcc' ], Package[ 'gcc-c++'] ],
    environment => [ 'HOME=""', 'PREFIX=/usr/local/lib/node', 'NAVE_JOBS=1' ],
    logoutput   => $logoutput,
    # btw, this takes forever....
    timeout     => 0,
    unless      => "test \"v$version\" = \"\$(node -v)\""
  }

}