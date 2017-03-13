if exists('g:loaded_nerdtree_file_filter')
    finish
endif

let g:loaded_nerdtree_file_filter = 1

if !exists('g:NERDTreeMapToggleFileFilter')
    let g:NERDTreeMapToggleFileFilter = "ff"
endif

if !exists('g:NERDTreeUpdateOnWrite')
    let g:NERDTreeUpdateOnWrite = 1
endif

if !exists('g:NERDTreeUpdateOnCursorHold')
    let g:NERDTreeUpdateOnCursorHold = 1
endif

if !exists('g:NERDTreeFileFilterRegexp')
    let g:NERDTreeFileFilterRegexp = '\(\)$'
endif

if !exists('g:NERDTreeFileFilterRegexpNegated')
    let g:NERDTreeFileFilterRegexpNegated = '\(\)$'
endif

if !exists('g:NERDTreeFileFilterEnabled')
    let g:NERDTreeFileFilterEnabled = 0
endif

function! NERDTreeDirectoryFilter(params)
    if g:NERDTreeFileFilterEnabled != 1
        return 0
    endif

    let path = a:params['path']

    if path.isDirectory
        let tree = a:params['nerdtree']
        let node = b:NERDTreeRoot.findNode(path)
        if empty(node)
            return 0
        endif

        return s:noVisibleChildren(node, tree)
    endif

    return 0
endfunction

function! s:noVisibleChildren(node, tree)
  return !s:anyVisibleChildren(a:node, a:tree)
endfunction

function! s:anyVisibleChildren(node, tree)
    for i in a:node.children
        if !i.path.ignore(a:tree)
            return 1
        endif
    endfor

    return 0
endfunction


function! NERDTreeFileFilter(params)
    if g:NERDTreeFileFilterEnabled != 1
        return 0
    endif

    let path = a:params['path']
    if path.isDirectory
        return 0
    endif
    let filename = split(path.str(), "/")[-1]

    return s:shouldFilter(filename)
endfunction

function! s:shouldFilter(path)
    let regex_tuple = [ g:NERDTreeFileFilterRegexp, g:NERDTreeFileFilterRegexpNegated]
    let regexes = regex_tuple[0]
    let regexes_negated = regex_tuple[1]

    if regexes == '\(\)$'
        return 0
    endif

    if regexes_negated == '\(\)$'
        return a:path =~ regexes ? 0 : 1
    endif

    return a:path =~ regexes_negated ? 0 : a:path =~ regexes ? 0 : 1
endfunction

function! s:toggleFileFilter()
    let g:NERDTreeFileFilterEnabled = !g:NERDTreeFileFilterEnabled
    call b:NERDTree.ui.renderViewSavingPosition()
    call b:NERDTree.ui.centerView()
endfunction

function! s:SID()
    if !exists("s:sid")
        let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
    endif
    return s:sid
endfun

function! s:NERDTreeFileFilterMapping()
    let s = '<SNR>' . s:SID() . '_'
    call NERDTreeAddKeyMap({'key': g:NERDTreeMapToggleFileFilter, 'scope': "all", 'callback': s."toggleFileFilter", 'quickhelpText': "toggle file filter"})
endfunction

augroup nerdtreefilefilterplugin
    autocmd CursorHold * silent! call s:CursorHoldUpdate()
augroup END

function! s:CursorHoldUpdate()
    if g:NERDTreeUpdateOnCursorHold != 1
        return
    endif

    if !g:NERDTree.IsOpen()
        return
    endif

    let winnr = winnr()
    call g:NERDTree.CursorToTreeWin()
    let node = b:NERDTreeRoot.refreshFlags()
    call NERDTreeRender()
    exec winnr . "wincmd w"
endfunction

augroup nerdtreefilefilterplugin
    autocmd BufWritePost * call s:FileUpdate(expand("%:p"))
augroup END

function! s:FileUpdate(fname)
    if g:NERDTreeUpdateOnWrite != 1
        return
    endif
    if !g:NERDTree.IsOpen()
        return
    endif

    let winnr = winnr()

    call g:NERDTree.CursorToTreeWin()
    let node = b:NERDTreeRoot.findNode(g:NERDTreePath.New(a:fname))
    if node == {}
        return
    endif
    call node.refreshFlags()
    let node = node.parent
    while !empty(node)
        call node.refreshDirFlags()
        let node = node.parent
    endwhile

    call NERDTreeRender()
    exec winnr . "wincmd w"
endfunction

function! s:SetupListeners()
    call NERDTreeAddPathFilter('NERDTreeFileFilter')
    call NERDTreeAddPathFilter('NERDTreeDirectoryFilter')
endfunction

call s:NERDTreeFileFilterMapping()
call s:SetupListeners()
