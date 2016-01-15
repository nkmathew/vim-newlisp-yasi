## vim-newlisp-yasi

A tiny indent script for correct newlisp indentation when coding using Vim. It
relies on [yasi](http://github.com/nkmathew/yasi-sexp-indenter) for calculating a
line's correct indentation and hence will require your version of Vim to be built
with python support.

### Some shortcomings
It's a bit laggy compared to the normal indent script implemented in pure Vimscript
like the Clojure one. The slight lag is probably due to the fact that it has to call
a python function and receive the returned values through the `pyeval` or `py3eval`
functions.

The upside is that it only becomes noticeable when you try to indent more than five
lines through a command like `=5k` and even then it's only a bearable half a second
or so.

### Requirements

```
pip install yasi
```

### Installation

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/nkmathew/vim-newlisp-yasi ~/.vim/bundle/vim-newlisp-yasi`
- [Vundle](https://github.com/VundleVim/Vundle.vim)
  - Add `Plugin 'nkmathew/vim-newlisp-yasi'` to .vimrc
  - Run `:PluginInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'nkmathew/vim-newlisp-yasi'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'nkmathew/vim-newlisp-yasi'` to .vimrc
  - Run `:PlugInstall`
