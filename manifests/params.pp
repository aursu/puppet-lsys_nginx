# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include lsys_nginx::params
class lsys_nginx::params {
  include bsys::webserver::params
  include nginx::params

  $osmaj = $bsys::params::osmaj

  # nginx
  $libdir          = '/var/lib/nginx'
  $cachedir        = '/var/cache/nginx'
  $proxy_temp_path = "${cachedir}/proxy_temp"
  $user_home       = '/var/lib/nginx'
  $conf_dir        = $nginx::params::conf_dir

  # directory to store configuration snippets to include into map directive
  $map_dir         = "${conf_dir}/conf.d/mapping"

  $ssl_settings = {
    'ssl'                         => true,
    'http2'                       => true,
    'ssl_session_timeout'         => '1d',
    'ssl_cache'                   => 'shared:SSL:50m',
    'ssl_session_tickets'         => false,
    'ssl_protocols'               => 'TLSv1.2 TLSv1.3',
    'ssl_ciphers'                 => 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384', # lint:ignore:140chars
    'ssl_prefer_server_ciphers'   => false,
    'ssl_stapling'                => true,
    'ssl_stapling_verify'         => true,
    'ssl_add_header'              => {
      'Strict-Transport-Security' => 'max-age=63072000',
    },
  }

  case $bsys::params::osfam {
    'Debian': {
      $oscode = $bsys::params::oscode

      $version = "1.27.3-1~${oscode}"
    }
    'RedHat': {
      $version = $osmaj ? {
        '6'     => '1.19.5-1.el6.ngx',
        default => "1.27.0-2.el${osmaj}.ngx",
      }
    }
    default: {
      $version = undef
    }
  }
}
