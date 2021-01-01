set number
map <S-Insert> <MiddleMouse>

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'mkarmona/materialbox'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'tomasr/molokai'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'

" Initialize plugin system
call plug#end()

" let g:nvcode_termcolors=256
let $COLORTERM="truecolor"
source ~/.config/nvim/plugins/coc.vim
" source ~/.config/nvim/plugins/guicolorscheme.vim
luafile ~/.config/nvim/plugins/treesitter.lua
source $HOME/.config/nvim/themes/onedarkch.vim



syntax on
colorscheme molokai
highlight LineNr guibg=NONE
highlight SignColumn guibg=NONE
" colorscheme desert
" set background dark 


