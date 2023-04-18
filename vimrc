"
"------------------------------------------------------------------------------
" vimrc - vim resource file.
"
" Copyright (c) 2000-2023 by John Yancey, All rights reserved.
"
" September 2008 John Yancey <john.w.yancey@gmail.org>
"
" $Id$
"------------------------------------------------------------------------------
"
fun! MySys()
   return "$1"
endfun
set runtimepath=~/.vim_runtime,~/.vim_runtime/after,\$VIMRUNTIME
source ~/.vim_runtime/vimrc
helptags ~/.vim_runtime/doc
