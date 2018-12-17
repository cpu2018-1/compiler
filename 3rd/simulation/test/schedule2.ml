
let rec rad x = x in

let rec read_screen_settings _ =

  (* スクリーン中心の座標 *)
  screen.(0) <- 0.0;
  screen.(1) <- 1.0;
  screen.(2) <- 2.0;
  (* 回転角 *)
  let v1 = rad (3.0) in
  let cos_v1 = cos v1 in
  let sin_v1 = sin v1 in
  let v2 = rad (4.0) in
  let cos_v2 = cos v2 in
  let sin_v2 = sin v2 in
  (* スクリーン面の奥行き方向のベクトル 注視点からの距離200をかける *)
  screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0;
  screenz_dir.(1) <- sin_v1 *. -200.0;
  screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0;
  (* スクリーン面X方向のベクトル *)
  screenx_dir.(0) <- cos_v2;
  screenx_dir.(1) <- 0.0;
  screenx_dir.(2) <- fneg sin_v2;
  (* スクリーン面Y方向のベクトル *)
  screeny_dir.(0) <- fneg sin_v1 *. sin_v2;
  screeny_dir.(1) <- fneg cos_v1;
  screeny_dir.(2) <- fneg sin_v1 *. cos_v2;
  (* 視点位置ベクトル(絶対座標) *)
  viewpoint.(0) <- screen.(0) -. screenz_dir.(0);
  viewpoint.(1) <- screen.(1) -. screenz_dir.(1);
  viewpoint.(2) <- screen.(2) -. screenz_dir.(2)

in 
viewpoint.(0) <- viewpoint.(1);

read_screen_settings ()
