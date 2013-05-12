class vim() {
  class{'vim::install': } ->
  class{'vim::cleanup': } ->
  class{'vim::plugins': } ->
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
  exec {"cd /home/vagrant/vim73 && ./configure --disable-selinux --enable-luainterp --enable-perlinterp --enable-pythoninterp --enable-tclinterp --enable-rubyinterp --enable-multibyte --disable-gui --with-features=huge && make && make install":
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
}
