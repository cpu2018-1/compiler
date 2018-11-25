
for i in $(ls *.ml | sed 's/\.[^\.]*$//');
do
  echo $i
  utop ${i}.ml > ${i}_utop
  make SOURCE=$i > /dev/null 2> ${i}_mine
  diff ${i}_utop ${i}_mine > ${i}_diff
done

#rm *_mine
#rm *_utop

wc *_diff
