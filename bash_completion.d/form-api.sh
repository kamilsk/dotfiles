# bash completion for form-api                             -*- shell-script -*-

__form-api_debug()
{
    if [[ -n ${BASH_COMP_DEBUG_FILE} ]]; then
        echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
    fi
}

# Homebrew on Macs have version 1.3 of bash-completion which doesn't include
# _init_completion. This is a very minimal version of that function.
__form-api_init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref "$@" cur prev words cword
}

__form-api_index_of_word()
{
    local w word=$1
    shift
    index=0
    for w in "$@"; do
        [[ $w = "$word" ]] && return
        index=$((index+1))
    done
    index=-1
}

__form-api_contains_word()
{
    local w word=$1; shift
    for w in "$@"; do
        [[ $w = "$word" ]] && return
    done
    return 1
}

__form-api_handle_reply()
{
    __form-api_debug "${FUNCNAME[0]}"
    case $cur in
        -*)
            if [[ $(type -t compopt) = "builtin" ]]; then
                compopt -o nospace
            fi
            local allflags
            if [ ${#must_have_one_flag[@]} -ne 0 ]; then
                allflags=("${must_have_one_flag[@]}")
            else
                allflags=("${flags[*]} ${two_word_flags[*]}")
            fi
            COMPREPLY=( $(compgen -W "${allflags[*]}" -- "$cur") )
            if [[ $(type -t compopt) = "builtin" ]]; then
                [[ "${COMPREPLY[0]}" == *= ]] || compopt +o nospace
            fi

            # complete after --flag=abc
            if [[ $cur == *=* ]]; then
                if [[ $(type -t compopt) = "builtin" ]]; then
                    compopt +o nospace
                fi

                local index flag
                flag="${cur%=*}"
                __form-api_index_of_word "${flag}" "${flags_with_completion[@]}"
                COMPREPLY=()
                if [[ ${index} -ge 0 ]]; then
                    PREFIX=""
                    cur="${cur#*=}"
                    ${flags_completion[${index}]}
                    if [ -n "${ZSH_VERSION}" ]; then
                        # zsh completion needs --flag= prefix
                        eval "COMPREPLY=( \"\${COMPREPLY[@]/#/${flag}=}\" )"
                    fi
                fi
            fi
            return 0;
            ;;
    esac

    # check if we are handling a flag with special work handling
    local index
    __form-api_index_of_word "${prev}" "${flags_with_completion[@]}"
    if [[ ${index} -ge 0 ]]; then
        ${flags_completion[${index}]}
        return
    fi

    # we are parsing a flag and don't have a special handler, no completion
    if [[ ${cur} != "${words[cword]}" ]]; then
        return
    fi

    local completions
    completions=("${commands[@]}")
    if [[ ${#must_have_one_noun[@]} -ne 0 ]]; then
        completions=("${must_have_one_noun[@]}")
    fi
    if [[ ${#must_have_one_flag[@]} -ne 0 ]]; then
        completions+=("${must_have_one_flag[@]}")
    fi
    COMPREPLY=( $(compgen -W "${completions[*]}" -- "$cur") )

    if [[ ${#COMPREPLY[@]} -eq 0 && ${#noun_aliases[@]} -gt 0 && ${#must_have_one_noun[@]} -ne 0 ]]; then
        COMPREPLY=( $(compgen -W "${noun_aliases[*]}" -- "$cur") )
    fi

    if [[ ${#COMPREPLY[@]} -eq 0 ]]; then
		if declare -F __form-api_custom_func >/dev/null; then
			# try command name qualified custom func
			__form-api_custom_func
		else
			# otherwise fall back to unqualified for compatibility
			declare -F ___custom_func >/dev/null && __custom_func
		fi
    fi

    # available in bash-completion >= 2, not always present on macOS
    if declare -F __ltrim_colon_completions >/dev/null; then
        __ltrim_colon_completions "$cur"
    fi

    # If there is only 1 completion and it is a flag with an = it will be completed
    # but we don't want a space after the =
    if [[ "${#COMPREPLY[@]}" -eq "1" ]] && [[ $(type -t compopt) = "builtin" ]] && [[ "${COMPREPLY[0]}" == --*= ]]; then
       compopt -o nospace
    fi
}

# The arguments should be in the form "ext1|ext2|extn"
__form-api_handle_filename_extension_flag()
{
    local ext="$1"
    _filedir "@(${ext})"
}

__form-api_handle_subdirs_in_dir_flag()
{
    local dir="$1"
    pushd "${dir}" >/dev/null 2>&1 && _filedir -d && popd >/dev/null 2>&1
}

__form-api_handle_flag()
{
    __form-api_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    # if a command required a flag, and we found it, unset must_have_one_flag()
    local flagname=${words[c]}
    local flagvalue
    # if the word contained an =
    if [[ ${words[c]} == *"="* ]]; then
        flagvalue=${flagname#*=} # take in as flagvalue after the =
        flagname=${flagname%=*} # strip everything after the =
        flagname="${flagname}=" # but put the = back
    fi
    __form-api_debug "${FUNCNAME[0]}: looking for ${flagname}"
    if __form-api_contains_word "${flagname}" "${must_have_one_flag[@]}"; then
        must_have_one_flag=()
    fi

    # if you set a flag which only applies to this command, don't show subcommands
    if __form-api_contains_word "${flagname}" "${local_nonpersistent_flags[@]}"; then
      commands=()
    fi

    # keep flag value with flagname as flaghash
    # flaghash variable is an associative array which is only supported in bash > 3.
    if [[ -z "${BASH_VERSION}" || "${BASH_VERSINFO[0]}" -gt 3 ]]; then
        if [ -n "${flagvalue}" ] ; then
            flaghash[${flagname}]=${flagvalue}
        elif [ -n "${words[ $((c+1)) ]}" ] ; then
            flaghash[${flagname}]=${words[ $((c+1)) ]}
        else
            flaghash[${flagname}]="true" # pad "true" for bool flag
        fi
    fi

    # skip the argument to a two word flag
    if __form-api_contains_word "${words[c]}" "${two_word_flags[@]}"; then
        c=$((c+1))
        # if we are looking for a flags value, don't show commands
        if [[ $c -eq $cword ]]; then
            commands=()
        fi
    fi

    c=$((c+1))

}

__form-api_handle_noun()
{
    __form-api_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    if __form-api_contains_word "${words[c]}" "${must_have_one_noun[@]}"; then
        must_have_one_noun=()
    elif __form-api_contains_word "${words[c]}" "${noun_aliases[@]}"; then
        must_have_one_noun=()
    fi

    nouns+=("${words[c]}")
    c=$((c+1))
}

__form-api_handle_command()
{
    __form-api_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    local next_command
    if [[ -n ${last_command} ]]; then
        next_command="_${last_command}_${words[c]//:/__}"
    else
        if [[ $c -eq 0 ]]; then
            next_command="_form-api_root_command"
        else
            next_command="_${words[c]//:/__}"
        fi
    fi
    c=$((c+1))
    __form-api_debug "${FUNCNAME[0]}: looking for ${next_command}"
    declare -F "$next_command" >/dev/null && $next_command
}

__form-api_handle_word()
{
    if [[ $c -ge $cword ]]; then
        __form-api_handle_reply
        return
    fi
    __form-api_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"
    if [[ "${words[c]}" == -* ]]; then
        __form-api_handle_flag
    elif __form-api_contains_word "${words[c]}" "${commands[@]}"; then
        __form-api_handle_command
    elif [[ $c -eq 0 ]]; then
        __form-api_handle_command
    elif __form-api_contains_word "${words[c]}" "${command_aliases[@]}"; then
        # aliashash variable is an associative array which is only supported in bash > 3.
        if [[ -z "${BASH_VERSION}" || "${BASH_VERSINFO[0]}" -gt 3 ]]; then
            words[c]=${aliashash[${words[c]}]}
            __form-api_handle_command
        else
            __form-api_handle_noun
        fi
    else
        __form-api_handle_noun
    fi
    __form-api_handle_word
}

_form-api_completion()
{
    last_command="form-api_completion"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--format=")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")

    must_have_one_flag=()
    must_have_one_flag+=("--format=")
    must_have_one_flag+=("-f")
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_ctl_create()
{
    last_command="form-api_ctl_create"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--dry-run")
    flags+=("--filename=")
    two_word_flags+=("-f")
    flags+=("--grpc-host=")
    flags+=("--output=")
    two_word_flags+=("-o")
    flags+=("--timeout=")
    two_word_flags+=("-t")
    flags+=("--token=")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_ctl_delete()
{
    last_command="form-api_ctl_delete"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--dry-run")
    flags+=("--filename=")
    two_word_flags+=("-f")
    flags+=("--grpc-host=")
    flags+=("--output=")
    two_word_flags+=("-o")
    flags+=("--timeout=")
    two_word_flags+=("-t")
    flags+=("--token=")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_ctl_read()
{
    last_command="form-api_ctl_read"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--dry-run")
    flags+=("--filename=")
    two_word_flags+=("-f")
    flags+=("--grpc-host=")
    flags+=("--output=")
    two_word_flags+=("-o")
    flags+=("--timeout=")
    two_word_flags+=("-t")
    flags+=("--token=")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_ctl_schema()
{
    last_command="form-api_ctl_schema"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--for=")
    local_nonpersistent_flags+=("--for=")
    flags+=("--dry-run")
    flags+=("--filename=")
    two_word_flags+=("-f")
    flags+=("--grpc-host=")
    flags+=("--output=")
    two_word_flags+=("-o")
    flags+=("--timeout=")
    two_word_flags+=("-t")
    flags+=("--token=")

    must_have_one_flag=()
    must_have_one_flag+=("--for=")
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_ctl_update()
{
    last_command="form-api_ctl_update"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--dry-run")
    flags+=("--filename=")
    two_word_flags+=("-f")
    flags+=("--grpc-host=")
    flags+=("--output=")
    two_word_flags+=("-o")
    flags+=("--timeout=")
    two_word_flags+=("-t")
    flags+=("--token=")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_ctl()
{
    last_command="form-api_ctl"

    command_aliases=()

    commands=()
    commands+=("create")
    commands+=("delete")
    commands+=("read")
    commands+=("schema")
    commands+=("update")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--dry-run")
    flags+=("--filename=")
    two_word_flags+=("-f")
    flags+=("--grpc-host=")
    flags+=("--output=")
    two_word_flags+=("-o")
    flags+=("--timeout=")
    two_word_flags+=("-t")
    flags+=("--token=")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_migrate()
{
    last_command="form-api_migrate"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--db-conn-max-lt=")
    local_nonpersistent_flags+=("--db-conn-max-lt=")
    flags+=("--db-idle-conn=")
    local_nonpersistent_flags+=("--db-idle-conn=")
    flags+=("--db-open-conn=")
    local_nonpersistent_flags+=("--db-open-conn=")
    flags+=("--dry-run")
    local_nonpersistent_flags+=("--dry-run")
    flags+=("--dsn=")
    local_nonpersistent_flags+=("--dsn=")
    flags+=("--limit=")
    two_word_flags+=("-l")
    local_nonpersistent_flags+=("--limit=")
    flags+=("--schema=")
    two_word_flags+=("-s")
    local_nonpersistent_flags+=("--schema=")
    flags+=("--table=")
    two_word_flags+=("-t")
    local_nonpersistent_flags+=("--table=")
    flags+=("--with-demo")
    local_nonpersistent_flags+=("--with-demo")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_run()
{
    last_command="form-api_run"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--base-url=")
    local_nonpersistent_flags+=("--base-url=")
    flags+=("--cpus=")
    two_word_flags+=("-C")
    local_nonpersistent_flags+=("--cpus=")
    flags+=("--db-conn-max-lt=")
    local_nonpersistent_flags+=("--db-conn-max-lt=")
    flags+=("--db-idle-conn=")
    local_nonpersistent_flags+=("--db-idle-conn=")
    flags+=("--db-open-conn=")
    local_nonpersistent_flags+=("--db-open-conn=")
    flags+=("--dsn=")
    local_nonpersistent_flags+=("--dsn=")
    flags+=("--grpc-host=")
    local_nonpersistent_flags+=("--grpc-host=")
    flags+=("--host=")
    two_word_flags+=("-H")
    local_nonpersistent_flags+=("--host=")
    flags+=("--idle-timeout=")
    local_nonpersistent_flags+=("--idle-timeout=")
    flags+=("--monitoring-host=")
    local_nonpersistent_flags+=("--monitoring-host=")
    flags+=("--profiling-host=")
    local_nonpersistent_flags+=("--profiling-host=")
    flags+=("--read-header-timeout=")
    local_nonpersistent_flags+=("--read-header-timeout=")
    flags+=("--read-timeout=")
    local_nonpersistent_flags+=("--read-timeout=")
    flags+=("--tpl-dir=")
    local_nonpersistent_flags+=("--tpl-dir=")
    flags+=("--with-monitoring")
    local_nonpersistent_flags+=("--with-monitoring")
    flags+=("--with-profiling")
    local_nonpersistent_flags+=("--with-profiling")
    flags+=("--write-timeout=")
    local_nonpersistent_flags+=("--write-timeout=")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_version()
{
    last_command="form-api_version"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()


    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_form-api_root_command()
{
    last_command="form-api"

    command_aliases=()

    commands=()
    commands+=("completion")
    commands+=("ctl")
    commands+=("migrate")
    commands+=("run")
    commands+=("version")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()


    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

__start_form-api()
{
    local cur prev words cword
    declare -A flaghash 2>/dev/null || :
    declare -A aliashash 2>/dev/null || :
    if declare -F _init_completion >/dev/null 2>&1; then
        _init_completion -s || return
    else
        __form-api_init_completion -n "=" || return
    fi

    local c=0
    local flags=()
    local two_word_flags=()
    local local_nonpersistent_flags=()
    local flags_with_completion=()
    local flags_completion=()
    local commands=("form-api")
    local must_have_one_flag=()
    local must_have_one_noun=()
    local last_command
    local nouns=()

    __form-api_handle_word
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_form-api form-api
else
    complete -o default -o nospace -F __start_form-api form-api
fi

# ex: ts=4 sw=4 et filetype=sh
