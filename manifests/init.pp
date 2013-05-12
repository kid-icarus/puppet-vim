class vim($home = '/home/vagrant') {
  class{'vim::install': } ->
  class{'vim::config': } ->
  Class['vim']
}

class vim::install {
  Package { ensure => installed }
  $vimPackages = [
    'gcc',
    'make',
    'make-install',
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
  package { $vimPackages: } ->
  exec {"wget -o $home/vagrant/vim-7.3.tar.bz2 ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2": 
    creates =>  '/usr/local/bin/vim'
  } ->
  exec {"tar xvjf $home/vim-7.3.tar.bz2": 
    creates =>  '/usr/local/bin/vim'
  } ->
  exec {"${home}/vim73/configure --disable-selinux --enable-luainterp \
  --enable-perlinterp \
  --enable-pythoninterp \
  --enable-python3interp \
  --enable-tclinterp \
  --enable-rubyinterp \
  --enable-multibyte \
  --disable-gui \
  --with-features=huge":
    creates =>  '/usr/local/bin/vim'
    } ->
  exec {"${home}/vim73/make && ${home}/vim73/make install":}
}
