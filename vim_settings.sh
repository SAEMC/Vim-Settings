#!/bin/bash

function installDependencies() {
  check_localtime="ls /etc/localtime >/dev/null 2>&1"
  check_curl="curl --version >/dev/null 2>&1"
  check_neovim="nvim --version >/dev/null 2>&1"
  check_nvm="nvm --version >/dev/null 2>&1"
  check_node="node --version >/dev/null 2>&1"
  check_ctags="ctags --version >/dev/null 2>&1"
  check_pip3="pip3 --version >/dev/null 2>&1"

  # Check OS
  os_type=$(echo "${OSTYPE}")
  echo -e "\n *** Check OSTYPE *** \n"

  # If Ubuntu
  if [[ "$os_type" == "linux-gnu"* ]]; then
    echo -e "\n *** Detected Ubuntu *** \n"

    sudo apt-get update

    # Check Local time
    eval "$check_localtime"
    if [[ "$?" -ne 0 ]]; then
      # Install TZdata non-interactive mode
      echo -e "\n *** Install TZdata non-interactive mode *** \n"
      export DEBIAN_FRONTEND=noninteractive

      sudo ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
      sudo apt-get install -y tzdata
      sudo dpkg-reconfigure --frontend noninteractive tzdata
    fi

    # Install Default software
    echo -e "\n *** Install Default software *** \n"
    sudo apt-get update
    sudo apt-get install -y software-properties-common

    # Check Curl
    eval "$check_curl"
    if [[ "$?" -ne 0 ]]; then
      # Install Curl
      echo -e "\n *** Install Curl *** \n"
      sudo apt-get install -y curl
    fi

    # Check NeoVIM
    eval "$check_neovim"
    if [[ "$?" -ne 0 ]]; then
      # Add NeoVIM into package
      echo -e "\n *** Add NeoVIM into package *** \n"
      sudo add-apt-repository -yu ppa:neovim-ppa/stable
      # Install NeoVIM
      echo -e "\n *** Install NeoVIM *** \n"
      sudo apt-get install -y neovim
      
      # Write NeoVIM alias into ~/.bashrc
      echo -e "\n *** Write NeoVIM alias into ~/.bashrc *** \n"
      cat >>${HOME}/.bashrc <<EOF

# NeoVIM Alias
alias vim="nvim"
EOF
    fi

    # Check Node
    eval "$check_node"
    if [[ "$?" -ne 0 ]]; then

      # Check NVM
      eval "$check_nvm"
      if [[ "$?" -ne 0 ]]; then
        # Install NVM manually
        echo -e "\n *** Install NVM manually *** \n"
        export NVM_DIR="$HOME/.nvm" && (
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh"

        # Write NVM path into ~/.bashrc
        echo -e "\n *** Write NVM path into ~/.bashrc *** \n"
        cat >>${HOME}/.bashrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"
EOF
      fi

      # Install Node LTS
      echo -e "\n *** Install Node LTS *** \n"
      nvm install --lts
      nvm alias default lts/*
      nvm use lts/*
    fi

    # Check Ctags
    eval "$check_ctags"
    if [[ "$?" -ne 0 ]]; then
      # Install Ctags
      echo -e "\n *** Install Ctags *** \n"
      sudo apt-get update
      sudo apt-get install -y universal-ctags

      # If cannot install universal-ctags => Install exuberant-ctags
      if [[ "$?" -ne 0 ]]; then
        echo -e "\n *** Install exuberant-ctags *** \n"
        sudo apt-get install -y exuberant-ctags
      fi
    fi

    # Check Pip3
    eval "$check_pip3"
    if [[ "$?" -ne 0 ]]; then
      # Install Pip3
      echo -e "\n *** Install Pip3 *** \n"
      sudo apt-get install -y python3-pip
    fi 
    
    # Install YAPF
    echo -e "\n *** Install YAPF *** \n"
    pip3 install yapf

  # If Mac
  elif [[ "$os_type" == "darwin"* ]]; then
    echo -e "\n *** Detected Mac *** \n"

    # Check NeoVIM
    eval "$check_neovim"
    if [[ "$?" -ne 0 ]]; then
      # Install NeoVIM
      echo -e "\n *** Install NeoVIM *** \n"
      /bin/zsh -c "brew install neovim"

      # Write Locale and NeoVIM alias into ~/.zshrc
      echo -e "\n *** Write Locale and NeoVIM alias into ~/.zshrc *** \n"
      cat >>${HOME}/.zshrc <<EOF

# Change Locale to en_US.UTF-8
export LANG=en_US.UTF-8

# NeoVIM Alias
alias vim="nvim"
EOF
    fi

    # Check Ctags
    eval "$check_ctags"
    if [[ "$?" -ne 0 ]]; then
      # Install Ctags
      echo -e "\n *** Install Ctags *** \n"
      /bin/zsh -c "brew install universal-ctags"
    fi

    #Check Node
    eval "$check_node"
    if [[ "$?" -ne 0 ]]; then

      # Check NVM
      eval "$check_nvm"
      if [[ "$?" -ne 0 ]]; then
        # Install NVM
        echo -e "\n *** Install NVM *** \n"
        /bin/zsh -c "brew install nvm"
        mkdir ${HOME}/.nvm

        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

        # Write NVM path into ~/.zshrc
        echo -e "\n *** Write NVM path into ~/.zshrc *** \n"
        cat >>${HOME}/.zshrc <<EOF

# NVM
export NVM_DIR="\$HOME/.nvm"
# This loads nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
EOF
      fi

      # Install Node LTS
      echo -e "\n *** Install Node LTS *** \n"
      nvm install --lts
      nvm alias default lts/*
      nvm use lts/*
    fi

    # Install YAPF
    echo -e "\n *** Install YAPF *** \n"
    pip3 install yapf

  # If not Ubuntu and Mac
  else
    echo "${os_type} is not supported!"
    exit 1
  fi
}

function installPlugins() {
  # Check OS
  os_type=$(echo "${OSTYPE}")
  # If not Ubuntu and Mac
  if [[ "$os_type" != "linux-gnu"* && "$os_type" != "darwin"* ]]; then
    echo "${os_type} is not supported!"
    exit 1
  fi

  # Clear ~/.local/share directory
  if [[ -d ${HOME}/.local/share/nvim ]]; then
    echo -e "\n *** Clear ~/.local/share directory *** \n"
    sudo rm -rf ${HOME}/.local/share/nvim
  fi

  # Clear ~/.config/nvim directory
  if [[ -d ${HOME}/.config/nvim ]]; then
    echo -e "\n *** Clear ~/.config/nvim directory *** \n"
    sudo rm -rf ${HOME}/.config/nvim
  fi
    mkdir -p ${HOME}/.config/nvim

  # Clear ~/.vimrc file
  if [[ -f ${HOME}/.vimrc ]]; then
    echo -e "\n *** Clear ~/.vimrc file *** \n"
    sudo rm ${HOME}/.vimrc
  fi

  # Clone NeoVIM Plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # Write ~/.vimrc location into ~/.config/nvim/init.vim
  echo -e "\n *** Write ~/.vimrc location into ~/.config/nvim/init.vim *** \n"
  cat >${HOME}/.config/nvim/init.vim <<EOF
set runtimepath^=\$HOME/.vim runtimepath+=\$HOME/.vim/after
let &packpath=&runtimepath
source \$HOME/.vimrc
EOF

  # Write Plugins into ~/.vimrc
  echo -e "\n *** Write Plugins into ~/.vimrc *** \n"
  cat >${HOME}/.vimrc <<EOF
set nocompatible
filetype off
call plug#begin()
Plug 'navarasu/onedark.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'blueyed/vim-diminactive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
call plug#end()
EOF

  # Execute NeoVIM PlugInstall
  echo -e "\n *** Execute NeoVIM PlugInstall *** \n"
  nvim +PlugInstall +qall
}

function writeScripts() {
  # Clear All lines after 'call plug#end()'
  last_line="call plug#end()"
  # Check OS
  os_type=$(echo "${OSTYPE}")
  # If Ubuntu
  if [[ "$os_type" == "linux-gnu"* ]]; then
    sed -i "/^${last_line}*/q" ${HOME}/.vimrc
  # If Mac
  elif [[ "$os_type" == "darwin"* ]]; then
    sed -i '' "/^${last_line}*/q" ${HOME}/.vimrc
  # If not Ubuntu and Mac
  else
    echo "${os_type} is not supported!"
    exit 1
  fi

  # Clear ~/.config/nvim/coc-settings.json file
  if [[ -f ${HOME}/.config/nvim/coc-settings.json ]]; then
    echo -e "\n *** Clear ~/.config/nvim/coc-settings.json file *** \n"
    sudo rm ${HOME}/.config/nvim/coc-settings.json
  fi

  # Check Ctags path
  ctags_path=$(which ctags)

  # Write Config into ~/.vimrc
  echo -e "\n *** Write Config into ~/.vimrc *** \n"
  cat >>${HOME}/.vimrc <<EOF

if (empty(\$TMUX))
  if (has("nvim"))
    let \$NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set autoindent
set background=dark
set backspace=indent,eol,start
set cindent
set cmdheight=2
set cursorline
set encoding=utf-8
set expandtab
set fileencodings=utf8,cp949
set foldmethod=manual
set guicursor=n-o-i-r-c-ci-cr-sm:ver1,v-ve:hor1
set hidden
set hlsearch
set incsearch
set laststatus=2
set nobackup
set nowritebackup
set re=0
set nu rnu
set ruler
set shiftwidth=2
set shortmess+=c
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitbelow
set tabstop=2
set updatetime=300

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

syntax on
colorscheme onedark

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g\`\"" |
\ endif
au BufEnter *
\ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
\ q | endif
au VimEnter *
\ :NERDTreeToggle |
\ wincmd p
au CursorHold * 
\ silent call CocActionAsync('highlight')
augroup Folds
  au!
  au BufWinLeave * mkview
  au BufWinEnter * silent! loadview
augroup END
augroup PyFormatOnSave
  au!
  au FileType python silent!
  au BufWritePre * silent! YAPF
augroup END

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:tagbar_ctags_bin = '$ctags_path'
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1

let g:AutoPairsMapCh = 0

" Check https://github.com/neoclide/coc.nvim/wiki/Language-servers
let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-html',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-sh',
  \ 'coc-yaml'
  \ ]

command! -nargs=* T split | resize 10 | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

nnoremap <silent> <Leader>b :NERDTreeToggle<CR>
nnoremap <silent> <Leader>d :bp <BAR> bd #<CR>
nnoremap <silent> <Leader>f zo
nnoremap <silent> <Leader>h :call CocAction('diagnosticToggle')<CR> \| :GitGutterBufferToggle<CR>
nnoremap <silent> <Leader>l :noh<CR> \| :set nolist<CR>
nnoremap <silent> <Leader>n :set nu! rnu!<CR>
nnoremap <silent> <Leader>t :TagbarToggle<CR>
nnoremap <silent> <Leader>v "*p
nnoremap <silent> <Leader>x :T<CR>i
nnoremap <silent> <Leader>xv :VT<CR>i
nnoremap <silent> <Leader>[ :bprevious!<CR>
nnoremap <silent> <Leader>] :bnext!<CR>
nnoremap <silent> c ciw
nnoremap <silent> ga :<C-u>CocList diagnostics<CR>
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gt <Plug>(coc-type-definition)
nnoremap <silent> g[ <Plug>(coc-diagnostic-prev)
nnoremap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> <F2> <Plug>(coc-rename)

vnoremap <silent> <Leader>c "*y
vnoremap <silent> <Leader>f zf
vmap <silent> s <S-s>

inoremap <silent> <expr> <TAB>
\ pumvisible() ? "\<C-n>" : col('.') < col('$') ? "\<Right>" : "\<Tab>"
inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<Left>"
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <silent> <expr> <C-Space> coc#refresh()
inoremap <silent> <expr> <C-d> col('.') < col('$') ? "\<C-o>x" : "\<Right>"
inoremap <silent> <C-h> <C-o>h
inoremap <silent> <C-j> <C-o>j
inoremap <silent> <C-k> <C-o>k
inoremap <silent> <C-l> <C-o>l

tnoremap <silent> <C-w>h <C-\><C-n><C-w>h
tnoremap <silent> <C-w>j <C-\><C-n><C-w>j
tnoremap <silent> <C-w>k <C-\><C-n><C-w>k
tnoremap <silent> <C-w>l <C-\><C-n><C-w>l
EOF

  # Write Config into ~/.config/nvim/coc-settings.json
  echo -e "\n *** Write Config into ~/.config/nvim/coc-settings.json *** \n"
  cat >${HOME}/.config/nvim/coc-settings.json <<EOF
{
  "coc.preferences.promptInput": false,
  "coc.preferences.formatOnSaveFiletypes": ["*"]
}
EOF
}

usage_msg="Usage:  $(basename $0) [-a] [-d] [-p] [-s]"
option_msg="Options:
  -a   Install dependencies/plugins and Write ~/.vimrc
  -d   Install dependencies only
  -p   Install plugins only
  -s   Write ~/.vimrc only"
invalid_msg="Invalid command option."
args=""

if [[ -z "$1" ]]; then
  echo "Need to enter command option."
  echo "$usage_msg"
  exit 1
fi

while getopts ':adps :h' opt; do
  case "$opt" in
    a | d | p | s)
      args+="${opt}"
      ;;
    h)
      echo -e "The way you install SAEMC Vim Settings.\n"
      echo -e "${usage_msg}\n"
      echo -e "$option_msg"
      exit 0
      ;;
    ?)
      echo "$invalid_msg"
      echo "$usage_msg"
      exit 1
      ;;
  esac
done

args=$(echo $args | grep -o . | sort | uniq | tr -d "\n")

for (( i = 0; i < ${#args}; i++ )); do
  arg="${args:$i:1}"

  if [[ "$arg" == "a" ]]; then
    installDependencies
    installPlugins
    writeScripts
    exit 0
  elif [[ "$arg" == "d" ]]; then
    installDependencies
  elif [[ "$arg" == "p" ]]; then
    installPlugins
  elif [[ "$arg" == "s" ]]; then
    writeScripts
  else
    echo "$invalid_msg"
    echo "$usage_msg"
    exit 1
  fi
done

exit 0
