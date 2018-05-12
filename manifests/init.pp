# Class: eclipse
#
# This module installs Eclipse
#
# Sample Usage:
#
#  include eclipse
#
class eclipse (
  $package         = 'java',
  $release_name    = 'oxygen',
  $service_release = '3a',
  $method          = 'download',
  $owner_group     = undef,
  $ensure          = present
) {

  include eclipse::params

  $repository = "http://download.eclipse.org/releases/${release_name}"

  case $method {
    download: {
      class { 'eclipse::install::download':
        package         => $package,
        release_name    => $release_name,
        service_release => $service_release,
        owner_group     => $owner_group,
        ensure          => $ensure
      }
      $bin = $eclipse::params::download_bin
    }
    package: {
      class { 'eclipse::install::package':
        ensure => $ensure
      }
      $bin = $eclipse::params::package_bin
    }
    default: {
      fail("Installation method ${method} is not supported")
    }
  }

}
