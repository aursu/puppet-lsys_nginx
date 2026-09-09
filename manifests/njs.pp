# Install the njs dynamic module for nginx
#
# @summary Install nginx-module-njs, the NGINX JavaScript dynamic module
#
# njs is shipped by nginx.org as a dynamic module whose package hard-depends on
# an exact nginx release - `nginx-module-njs 1.31.5+1.0.1` depends on
# `nginx-r1.31.5`. The two therefore move together for the life of the host: an
# njs update is also an nginx update, and pinning one without the other makes
# the pair unsatisfiable.
#
# Declaring this class does not by itself load anything. `lsys_nginx` passes the
# module names to `nginx::dynamic_modules`, which renders the `load_module`
# directives, and orders this package before the configuration that references
# them - nginx refuses to start if `load_module` names a file that is not there.
#
# @param package_ensure
#   Version of `nginx-module-njs`. Defaults to `installed`, which lets apt pick
#   the candidate matching the pinned nginx. Prefer an explicit version in node
#   Hiera, the same way `lsys_nginx::package_ensure` pins nginx itself - the two
#   pins have to be kept in step, and an explicit pair makes that visible rather
#   than leaving it to whatever the repository offers on the day.
#
#   Note the version strings differ in shape: nginx is `1.31.5-1~noble` while
#   njs is `1.31.5+1.0.1-1~noble`, so this cannot simply reuse the nginx value.
#
# @param package_name
#   Package providing the module.
#
# @example Pinned in step with nginx
#   class { 'lsys_nginx':
#     package_ensure     => '1.31.5-1~noble',
#     njs                => true,
#     njs_package_ensure => '1.31.5+1.0.1-1~noble',
#   }
class lsys_nginx::njs (
  String[1] $package_ensure = 'installed',
  String[1] $package_name = 'nginx-module-njs',
) {
  package { $package_name:
    ensure => $package_ensure,
  }
}
