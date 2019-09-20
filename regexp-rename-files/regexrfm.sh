_fromPattern=$1
if [ -z "$_fromPattern" ]
then
      _fromPattern="(.*)"
fi
_toPattern=$2
if [  -z "$_toPattern" ]
then
      _toPattern="\1"
fi

_prefix='s/'
_delim='/'
_postfix='/'
_pattern="${_prefix}${_fromPattern}${_delim}${_toPattern}${_postfix}"
echo $_pattern
for old in $(find . -regextype posix-extended -regex "$_fromPattern" ); do
    echo "- $old"
    new=$(echo $old | sed -E $_pattern)
    mv -v "$old" "$new"
done

