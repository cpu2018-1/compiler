
for i in $(ls ../sld/);
do
  j=${i%.*}
  ../minrt < ../sld/${j}.sld > ${j}.ppm
done
