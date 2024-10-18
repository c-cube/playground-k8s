FROM ocaml/opam:debian-12-ocaml-5.2 AS base
WORKDIR /build/myecho/
RUN sudo chown opam: /build/myecho/
COPY dune-project myecho.opam ./
COPY src/ ./src/
RUN eval `opam env` && opam install . --deps-only
RUN eval `opam env` && dune build .
RUN cp _build/default/src/main.exe myecho.exe

FROM debian:12 AS run
COPY --from=base /build/myecho/myecho.exe . 
ENTRYPOINT ["./myecho.exe"]
