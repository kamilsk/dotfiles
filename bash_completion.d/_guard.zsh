#compdef guard

_arguments \
  '1: :->level1' \
  '2: :_files'
case $state in
  level1)
    case $words[1] in
      guard)
        _arguments '1: :(completion help migrate run version)'
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
