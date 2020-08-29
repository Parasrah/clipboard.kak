provide-module clipboard %§

declare-option -docstring 'The register used to interface with the system clipboard' str clipboard_register 'p'

declare-option -docstring 'Command used to set contents of system clipboard' str set_clipboard_cmd 'xsel --input --clipboard'
declare-option -docstring 'Command used to get contents of system clipboard' str get_clipboard_cmd 'xsel --output --clipboard'

define-command get-system-clipboard -docstring 'get the contents of the system clipboard' %{
    echo %sh{
        $kak_opt_get_clipboard_cmd
    }
}

hook global RegisterModified p %{ nop %sh{
    printf %s "$kak_reg_p" | $kak_opt_set_clipboard_cmd
} }

define-command -hidden propagate-clipboard -docstring 'Propagate clipboard contents to clipboard register' %{
    evaluate-commands -no-hooks %{
        set-register p %sh{ $kak_opt_get_clipboard_cmd }
    }
}

hook global FocusIn .* propagate-clipboard
hook global KakBegin .* propagate-clipboard

§
