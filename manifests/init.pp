class vim() {
  class{'vim::install': } ->
  class{'vim::cleanup': } ->
  class{'vim::plugins': } ->
  class{'vim::config': } ->
  Class['vim']
}

class vim::install {
  $home = '/home/vagrant'

  $vimPackages = [
    'gcc',
    'make',
    'ncurses',
    'ncurses-devel',
    'lua',
    'lua-devel',
    'ruby',
    'ruby-devel',
    'python',
    'python-devel',
    'perl',
    'wget',
    ]
  package { $vimPackages: ensure => installed} ->
  exec {"wget -q ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2":
    creates =>  '/usr/local/bin/vim',
  } ->
  file {'/home/vagrant/vim-7.3.tar.bz2':
    owner => 'root',
    group => 'root',
    mode => '0664',
  } ->
  exec {"tar xvjf ${home}/vim-7.3.tar.bz2":
    creates =>  '/usr/local/bin/vim',
  } ->
  file {'/home/vagrant/vim73':
    owner => 'root',
    group => 'root',
    recurse => true,
  } ->
  exec {"cd /home/vagrant/vim73 && ./configure --disable-selinux --enable-luainterp --enable-perlinterp --enable-pythoninterp --enable-tclinterp --enable-rubyinterp --enable-multibyte --disable-gui --with-features=huge --with-python-config-dir=/usr/local/lib/python2.7/config && make && make install":
    provider => 'shell',
    creates => '/usr/local/bin/vim',
  }
}

class vim::cleanup {
  exec {'rm -rf /home/vagrant/vim73 ; rm -rf /home/vagrant/vim-7.3.tar.bz2':
    onlyif => "test -f /home/vagrant/vim73"
  }
}

class vim::plugins {
  file {'/home/vagrant/.vim/autoload':
    ensure => directory,
    owner => 'vagrant',
    group => 'vagrant',
    mode => 0664,
  }
  file {'/home/vagrant/.vim/bundle':
    ensure => directory,
    owner => 'vagrant',
    group => 'vagrant',
    recurse => true,
    mode => 0664,
  }
  exec { "/usr/bin/curl 'www.vim.org/scripts/download_script.php?src_id=19375' > /home/vagrant/.vim/autoload/pathogen.vim":
    creates => '/home/vagrant/.vim/autoload/pathogen.vim',
    require => File['/home/vagrant/.vim/autoload']
  }
  file {'/home/vagrant/.vim':
    owner => 'vagrant',
    group => 'vagrant',
    recurse => true,
  }
  exec {'git clone https://github.com/tpope/vim-surround.git /home/vagrant/.vim/bundle/vim-surround':
    creates => '/home/vagrant/.vim/bundle/vim-surround',
  }
  exec {'git clone https://github.com/joonty/vdebug.git /home/vagrant/.vim/bundle/vdebug':
    creates => '/home/vagrant/.vim/bundle/vdebug',
  }
  exec {'git clone https://github.com/scrooloose/syntastic.git /home/vagrant/.vim/bundle/syntastic':
    creates => '/home/vagrant/.vim/bundle/syntastic',
  }
  exec {'git clone https://github.com/tpope/vim-repeat.git /home/vagrant/.vim/bundle/vim-repeat':
    creates => '/home/vagrant/.vim/bundle/vim-repeat',
  }
  exec {'git clone https://github.com/bkad/CamelCaseMotion.git /home/vagrant/.vim/bundle/CamelCaseMotion':
    creates => '/home/vagrant/.vim/bundle/CamelCaseMotion',
  }
  exec {'git clone https://github.com/tpope/vim-eunuch.git /home/vagrant/.vim/bundle/vim-eunuch':
    creates => '/home/vagrant/.vim/bundle/vim-eunuch',
  }
  exec {'git clone https://github.com/tpope/vim-unimpaired.git /home/vagrant/.vim/bundle/vim-unimpaired':
    creates => '/home/vagrant/.vim/bundle/vim-unimpaired',
  }
  exec {'git clone https://github.com/garbas/vim-snipmate.git /home/vagrant/.vim/bundle/vim-snipmate':
    creates => '/home/vagrant/.vim/bundle/vim-snipmate',
  }
  exec {'git clone https://github.com/tpope/vim-fugitive.git /home/vagrant/.vim/bundle/vim-fugitive':
    creates => '/home/vagrant/.vim/bundle/vim-fugitive',
  }
  exec {'git clone https://github.com/Lokaltog/vim-powerline.git /home/vagrant/.vim/bundle/vim-powerline':
    creates => '/home/vagrant/.vim/bundle/vim-powerline',
  }
  exec {'git clone https://github.com/altercation/vim-colors-solarized.git /home/vagrant/.vim/bundle/vim-colors-solarized':
    creates => '/home/vagrant/.vim/bundle/vim-colors-solarized',
  }
  exec {'git clone https://github.com/MarcWeber/vim-addon-mw-utils.git /home/vagrant/.vim/bundle/vim-addon-mw-utils':
    creates => '/home/vagrant/.vim/bundle/vim-addon-mw-utils',
  }
}

class vim::config {
  file {'/home/vagrant/.vimrc':
    source => 'puppet:///modules/vim/.vimrc',
    owner => 'vagrant',
    group => 'vagrant',
    mode => 0664,
  }
}
