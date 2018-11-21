cat lib_tegaki.s > lib.s

TEMP=$IFS
IFS='
'
for i in $(cat ourlib.txt);
do
  if [ $(echo $i | grep "\/\/") ]; then
    continue
  fi
  echo $i
  sed "s/${i}\.[0-9]*/${i}/g" genlib.s > ___hoge; mv ___hoge genlib.s
  sed -e "s/^${i}/lib_${i}/g" genlib.s > ___hoge; mv ___hoge genlib.s
  sed -e "s/\s${i}/ lib_${i}/g" genlib.s > ___hoge; mv ___hoge genlib.s
done

sed "s/lib_lib_/lib_/g" genlib.s > __hoge; mv __hoge genlib.s

for i in ble beq bne blt feq flt fle;
do
  sed "s/${i}_then/_${i}_then/g" genlib.s > ___hoge; mv ___hoge genlib.s
  sed "s/${i}_else/_${i}_else/g" genlib.s > ___hoge; mv ___hoge genlib.s
  sed "s/${i}_cont/_${i}_cont/g" genlib.s > ___hoge; mv ___hoge genlib.s
done

sed "s/__/_/g" genlib.s > ___hoge; mv ___hoge genlib.s

IFS=$TEMP

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
