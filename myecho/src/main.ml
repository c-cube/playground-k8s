module H = Tiny_httpd
module Html = Tiny_httpd_html

let () =
  let port = 8090 in
  let server = H.create ~addr:"0.0.0.0" ~port () in
  H.add_route_handler server
    H.Route.(exact "status" @/ return)
    (fun _req -> H.Response.make_string @@ Ok "ok");
  H.add_route_handler server
    H.Route.(exact "echo" @/ return)
    (fun req ->
      let html =
        Html.(p [] [ txt @@ Format.asprintf "req: %a" H.Request.pp_ req ])
      in
      H.Response.make_string @@ Ok (Html.to_string_top html));
  Printf.printf "run on http://127.0.0.1:%d/\n%!" port;
  H.run_exn server
