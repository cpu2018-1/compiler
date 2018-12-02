n=0
hp=10000
sp=0
prefix="min_caml_"

echo "  addi  r3, r0, ${sp}"
echo "  addi  r4, r0, ${hp}"

#
name="n_objects"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  sw  r0, $((n++))(r4)"


#
name="objects"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
for ((i = 0; i < 60; i++)); do
  echo "  sw  r0, $((n++))(r4)"
  echo "  sw  r0, $((n++))(r4)"
  echo "  sw  r0, $((n++))(r4)"
  echo "  sw  r0, $((n++))(r4)"
  echo "  sw  r0, $((n++))(r4) # dummy"
  echo "  sw  r0, $((n++))(r4) # dummy"
  echo "  sw  r0, $((n++))(r4) # false"
  echo "  sw  r0, $((n++))(r4) # dummy"
  echo "  sw  r0, $((n++))(r4) # dummy"
  echo "  sw  r0, $((n++))(r4) # dummy"
  echo "  sw  r0, $((n++))(r4) # dummy"
done


#
name="screen"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"

#
name="viewpoint"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"

#
name="light"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="beam"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  flup f1, 37"
echo "  fsw f1, $((n++))(r4)"


#
name="and_net"
echo "# ${name}"
echo "  addi  r1, r4, $((n++))"
echo "  addi  r2, r0, -1"
echo "  sw  r2, 0(r1)"
echo "${prefix}${name} $((n + heap))$" > table.txt
for ((i = 0; i < 50; i++)); do
  echo "  sw  r1, $((n++))(r4)"
done


#
name="or_net"
echo "# ${name}"
echo "  sw  r1, $((n++))(r4)"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  addi  r1, r4, $((n + heap - 1))"
echo "  sw  r1, $((n++))(r4)"


#
name="solver_dist"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"


#
name="intsec_rectside"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  sw r0, $((n++))(r4)"


#
name="tmin"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  flup f1, 31"
echo "  fsw f1, $((n++))(r4)"


#
name="intersection_point"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="intersected_object_id"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  sw r0, $((n++))(r4)"


#
name="nvector"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="texture_color"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="diffuse_ray"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="rgb"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="image_size"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  sw r0, $((n++))(r4)"
echo "  sw r0, $((n++))(r4)"


#
name="image_center"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  sw r0, $((n++))(r4)"
echo "  sw r0, $((n++))(r4)"


#
name="scan_pitch"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"


#
name="startp"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="startp_fast"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"

#
name="screenx_dir"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="screeny_dir"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="screenz_dir"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"


#
name="ptrace_dirvec"
echo "# ${name}"
echo "${prefix}${name} $((n + heap))$" > table.txt
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"
echo "  fsw f0, $((n++))(r4)"



echo "  addi  r4, r4, ${n}"
