nerdtree-file-filter-plugin
===================
[![Build Status](https://travis-ci.org/albfan/nerdtree-file-filter-plugin.svg?branch=master)](https://travis-ci.org/albfan/nerdtree-file-filter-plugin)

A NERDTree plugin to filter files by regexp.

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

 - `testN.sh`: bash script to generate scenario
 - `testN.vim`: source for vim where you do whatever operations in vim
 - `testN.ok`: Expected output for test

When reporting new issues, add `""""failed` to testN.vim to allow suite to detect expected failed test

    """ Some test name
    """"failed
    Do stuff here

When fixing issues, remove the failed mark from the related test.

    """ Some test name
    Do stuff here

There are some example tests in [the t directory](/t)

### Skipping tests

With an environment variable:

    SKIP_TESTS=test1 ./suite.sh

OR tag with `""""skip` e.g.

    """ Some test name
    """"skip
    NERDTree
    normal O
    let g:NERDTreeFileFilterRegexp = 'a$'
    normal ff
    5,$w ../test2.out

More info on [TDD](https://en.wikipedia.org/wiki/Test-driven_development)

### Running test suite

    $ cd t
    $ ./suite.sh

