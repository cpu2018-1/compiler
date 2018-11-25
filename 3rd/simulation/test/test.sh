
for i in $(ls *.ml | sed 's/\.[^\.]*$//');
do
  echo $i
  utop ${i}.ml > ${i}_utop
  sed -E 's/.*MINE.*//g' ${i}.ml > ${i}_mine.ml
  make SOURCE=${i}_mine > /dev/null 2> ${i}_mine
  diff ${i}_utop ${i}_mine > ${i}_diff
  rm ${i}_mine.ml
  rm ${i}_mine.s
done

rm *_mine
rm *_utop

wc *_diff
