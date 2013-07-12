setlocal foldmethod=manual
setlocal foldexpr=VimSystemVerilogFoldExpr(v:lnum)

let g:currentIndentLevel = 1 
let g:beginLevel = 0


function! PrevNonBlankLine(lnum)
    let current = a:lnum - 1
    
    while current > 0 
        if getline(current) =~? '^\s*\(\/\/\)\@!\S\+.*$'
        "if getline(current) =~? '^\s*\S\+.*$'
            return current
        endif
        let current -= 1
    endwhile

    return 0 
endfunction


function! VimSystemVerilogFoldExpr(lnum)
    if a:lnum < 2
        return 1
    endif

	"if getline(a:lnum) =~? '\v^\s*$\|^\s*\/\/.*$'
	if getline(a:lnum) =~? '\v^\s*$'
		return '-1'
    elseif getline(a:lnum) =~? '^\s*\/\/'
        return '-1'
    endif

    let PrevNonBlankLineNum = PrevNonBlankLine(a:lnum)
            
    if getline(PrevNonBlankLineNum) =~? '^\s*class.*$\|^\s*virtual\s*class.*$'
        let g:currentIndentLevel += 1
        return '>' . g:currentIndentLevel 
    elseif getline(PrevNonBlankLineNum) =~? '^\s*endclass.*$'
        let g:currentIndentLevel -= 1
        return g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*task.*$\|^\s*virtual\s*task.*$'
        let g:currentIndentLevel += 1
        return '>' . g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*endtask.*$'
        let g:currentIndentLevel -= 1
        return g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*function.*$\|^\s*virtual\s*function.*$'
        let g:currentIndentLevel += 1
        return '>' . g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*endfunction.*$'
        let g:currentIndentLevel -= 1
        return g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*case.*$'
        let g:currentIndentLevel += 1
        return '>' . g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*endcase.*$'
        let g:currentIndentLevel -= 1
        return g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*fork.*$'
        let g:currentIndentLevel += 1
        return '>' . g:currentIndentLevel
    elseif getline(PrevNonBlankLineNum) =~? '^\s*join.*$'
        let g:currentIndentLevel -= 1
        return g:currentIndentLevel
"    elseif getline(PrevNonBlankLineNum) =~? '^\s*end.*else.*begin.*$'
"        return '='
"    elseif getline(PrevNonBlankLineNum) =~? '^.*begin.*$'
"        "let beginLevel += 1
"        "if beginLevel < 2
"            let g:currentIndentLevel += 1
"            return '>' . g:currentIndentLevel
"        "elseif
"        "    return '='
"        "endif
"    elseif getline(PrevNonBlankLineNum) =~? '\<end\>'
"        "let beginLevel -= 1
"        "if beginLevel < 1
"            let g:currentIndentLevel -= 1
"            return g:currentIndentLevel
"        "elseif
"        "    return '='
"        "endif
    else
        return '='
    endif
endfunction

