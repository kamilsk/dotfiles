#compdef check

_arguments \
  '1: :->level1' \
  '2: :_files'
case $state in
  level1)
    case $words[1] in
      check)
        _arguments '1: :(completion help urls version)'
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
