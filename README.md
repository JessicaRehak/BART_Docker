# BART Dockerfile

This is the dockerfile used to generate the docker container used by
[BART](https://github.com/SlaybaughLab/BART) to build on
travis.ci, or any machine running it.

The docker image can be retrieved using `docker pull jsrehak/bart`
with a specified tag. Tags are based on the version of deal.II used,
with values following `-` to indicate updates of other
dependencies. BART is designed to work with specific versions of
deal.II, but should work with any versions of the other
dependencies. 

|BART Branch/Release           | Docker Tag(s)        | Ubuntu   | gcc | Deal II | GTest | ProtoBuff |FFTW   |FMT  |DocOpt|
|------------------------------|----------------------|----------|-----|---------|-------|-----------|-------|-----|------|
|                              | `v9.2.0-1`           | 20.04    | 10  |9.2.0    | 1.10.0| 3.13.0          | 3.8.8 |7.1.0|0.6.3 |
| `dev`, `master`, `v0.2.0`    | `v9.2.0`, `latest`   | 20.04    | 9   |9.2.0    | 1.10.0| 3.13.0          | 3.8.8 |
| `v0.1.0`                     | `v9.1.1`             | 20.04    | 9   |9.1.1    | 1.10.0| 3.11.2          |       |

Links:

- [dockerhub](https://hub.docker.com/r/jsrehak/bart/)
- [deal-ii docker containers](https://hub.docker.com/r/dealii/dealii/tags/)
- [BART](https://github.com/SlaybaughLab/BART)
