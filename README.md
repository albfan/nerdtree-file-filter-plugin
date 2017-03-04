nerdtree-file-filter-plugin
===================
[![Build Status](https://travis-ci.org/albfan/nerdtree-file-filter-plugin.svg?branch=master)](https://travis-ci.org/albfan/nerdtree-file-filter-plugin)

A plugin of NERDTree to filter files by regexp.

## Installation

For Vundle

```
Plugin 'scrooloose/nerdtree'
Plugin 'albfan/nerdtree-file-filter-plugin'
```

For NeoBundle

```
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'albfan/nerdtree-file-filter-plugin'
```


## Usage
Set the regular expression match with:

    let g:NERDTreeFileFilterRegexp = '\(spec\.rb\)$'

Toggle filter in NERDTree

    ff

## Testing

The test suite only needs vim installed

    $ [pacman|apt-get|yum] install vim

Given that, you need to provide a failed test with three files:

 - testN.sh: bash script to generate scenario
 - testN.vim: source for vim where you do whatever operations in vim
 - testN.ok: Expected output for test

1. When reporting new issues, add `""""failed` to testN.vim to allow suite to detect expected failed test
2. When fixing issues, remove the failed mark from the related test.

Please see files on t directory for examples

More info on [TDD](https://en.wikipedia.org/wiki/Test-driven_development) 

### Running test suite
 
    $ cd t
    $ ./suite.sh

