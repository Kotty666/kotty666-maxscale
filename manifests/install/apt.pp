# @summary adds the repo to the system configuration
#
# adds the repo to the system configuration
#
# @example
#   include maxscale::install::apt
class maxscale::install::apt (
    $repository_base_url = undef
) {

    if ($::architecture != 'amd64') {
        fail('Architectures != amd64 are not supported by the maxscale package repository!')
    }

    if $repository_base_url == undef {
      $repository_base_url = $maxscale::repository_base_url
    }

    ::apt::source { 'mariadb-maxscale' :
        architecture => 'amd64',
        location     => $repository_base_url,
        include      => {
            'src' => false,
            'deb' => true,
        },
        key          => {
            'id'     => $maxscale::gpg_key_id,
            'server' => 'hkp://keyserver.ubuntu.com:80'
        },
        repos        => 'main',
        release      => $::lsbdistcodename,
    }
}
