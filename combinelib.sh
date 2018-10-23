cat lib_tegaki.s > lib.s

for i in $(cat ourlib.txt);
do
  sed "s/${i}\.[0-9]*/${i}/g" genlib.s > ___hoge
  cat ___hoge > genlib.s
  rm ___hoge
done

f=0
cat genlib.s | while IFS= read line
do
  if [ "${line}" = "_min_caml_start: # main entry point" ]; then
    f=$((f + 1))
  fi

  if [ ${f} -eq 2 ]; then
    break
  fi

  if [ ${f} -eq 1 ]; then
    echo "${line}" >> lib.s
  fi

  if [ "${line}" = "# library ends" ]; then
    f=$((f + 1))
  fi
done
