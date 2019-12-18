# BART Dockerfile

This is the dockerfile used to generate the docker container used by
[BART](https://github.com/SlaybaughLab/BART) to build on
travis.ci, or any machine running it.

The docker image can be retrieved using `docker pull jsrehak/bart`
with a specified tag. Tags are based on the version of deal.II used,
with values following `-` to indicate updates of other
dependencies. BART is designed to work with specific versions of
deal.II, but should work with any versions of the other dependencies.


| Tag                  | Deal II | GoogleTest/Mock | ProtocolBuffers |
|----------------------|---------|-----------------|-----------------|
| `v9.0.1-1`, `latest` | 9.0.1   | 1.10.0          | 3.11.2          |
| `v9.0.1`             | 9.0.1   | 1.8.0           | 3.6.0           |

Links:

- [dockerhub](https://hub.docker.com/r/jsrehak/bart/)
- [deal-ii docker containers](https://hub.docker.com/r/dealii/dealii/tags/)
- [BART](https://github.com/SlaybaughLab/BART)
