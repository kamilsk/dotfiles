#compdef guardctl

_arguments \
  '1: :->level1' \
  '2: :->level2' \
  '3: :->level3' \
  '4: :_files'
case $state in
  level1)
    case $words[1] in
      guardctl)
        _arguments '1: :(completion help install license version)'
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
  ;;
  level2)
    case $words[2] in
      license)
        _arguments '2: :(create delete employee read register restore update workplace)'
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
  ;;
  level3)
    case $words[3] in
      employee)
        _arguments '3: :(add delete)'
      ;;
      workplace)
        _arguments '3: :(add delete push)'
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
