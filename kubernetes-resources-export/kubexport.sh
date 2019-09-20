export KUBECONFIG=$1

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' yq|grep "install ok installed")
echo Checking for yq: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "Yq will be installed"
  sudo add-apt-repository ppa:rmescandon/yq
  sudo apt update
  sudo apt install yq -y
fi

kubectl api-resources | sed -E 's/(\w+)(.*)/\1/' | sed '1d' > api-resources
mkdir ./exported


while IFS="" read -r p || [ -n "$p" ]
do
  mkdir "./exported/$p"
  cd "./exported/$p"

  kubectl get "$p" -A -o yaml > original.yaml
  sed '${/^[[:space:]]*$/d;}' original.yaml
  
  tail -n +3 "original.yaml" | head -n -4 > "tailed.yaml"
  csplit --silent --elide-empty-files "tailed.yaml" '/^- /' '{*}'
  
  find -name "xx*" | while read fname; do
    sed -E -i 's/[- ]{2}(.*)/\1/' "$fname"
    
    _name="$(yq r $fname metadata.name)"
    _namespace="$(yq r $fname metadata.namespace)"
    if [ _namespace == "null" ]
    then
      _namespace="-"
    else
      _namespace="-$_namespace-"
    fi
    mv "$fname" "$p$_namespace$_name.yaml"
    _name=
    _namespace=
  done
  cd ../..
done < api-resources
