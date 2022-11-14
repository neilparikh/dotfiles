let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:50%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

autocmd VimEnter * command! -bang -nargs=* Files
  \ call fzf#vim#files(<q-args>,
  \                    <bang>0 ? fzf#vim#with_preview('up:50%')
  \                            : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                    <bang>0)

" Mappings
nnoremap <c-p> :Files<CR>
nnoremap <c-f> :Ag <CR>
nnoremap <leader>b :Buffers<cr>
