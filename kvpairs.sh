get_value()
{
    local kvl="$1"
    local key=$2
    local p

    for p in $kvl; do
        if [[ $key =~ ${p%=*} ]]; then
            echo "${p#*=}"
            return
        fi
    done

    return
}

override()
{
    local ovr_kvp="$1"
    local def_kvp="$2"
    local key="$3"

    local def=$(get_value "$def_kvp" $key)
    local ovr=$(get_value "$ovr_kvp" $key)

    echo ${ovr:-$def}
}

clone()
{
    local clone_ovr="$1"
    local clone_def="user=sameerpatel dest="

    local def_user=$(get_value "$clone_def" user)
    local def_dest=$(get_value "$clone_def" dest)

    local alt_user=$(get_value "$clone_ovr" user)
    local alt_dest=$(get_value "$clone_ovr" dest)

    echo "def_user: ($def_user) def_dest: ($def_dest)"
    echo "alt_user: ($alt_user) alt_dest: ($alt_dest)"

    user=${alt_user:-$def_user}
    dest=${alt_dest:-$def_dest}

    echo "user ($user) dest ($dest)"
}

clone2()
{
    local ovr="$1"
    local def="user=sameerpatel dest="

    local user=$(override "$ovr" "$def" user)
    local dest=$(override "$ovr" "$def" dest)

    echo "user ($user) dest ($dest)"
}

clone2 "$1"
