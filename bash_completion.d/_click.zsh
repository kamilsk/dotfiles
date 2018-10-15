#compdef click

_arguments \
  '1: :->level1' \
  '2: :->level2' \
  '3: :_files'
case $state in
  level1)
    case $words[1] in
      click)
        _arguments '1: :(completion ctl help migrate run version)'
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
  ;;
  level2)
    case $words[2] in
      ctl)
        _arguments '2: :(create delete read schema update)'
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
  ;;
  *)
    _arguments '*: :_files'
  ;;
esac
