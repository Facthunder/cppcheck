# Docker image for Cppcheck

This project aims to provide a simple Docker image to encapsulate and run a [Cppcheck](https://github.com/danmar/cppcheck) analysis through Docker.

### Run Cppcheck

#### Run core checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src facthunder/cppcheck:latest "cppcheck -v --xml --enable=all . 2> report.xml"
```

#### Run MISRA C 2012 checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src facthunder/cppcheck:latest "cppcheck --dump .; misra.py *.dump 2>report.xml"
```
Or simplier:
```Dockerfile
docker run --rm -v ${PWD}:/src facthunder/cppcheck misra
```

#### Run CERT checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src facthunder/cppcheck:latest "cppcheck --dump .; cert.py *.dump 2>report.xml"
```

### Versions matrix
Here is the versions matrix of the image:

|                          TAG                           |                       CPPCHECK VERSION                       |                        BASE IMAGE                      |
|:------------------------------------------------------:|:------------------------------------------------------------:|:------------------------------------------------------:|
| [latest](https://hub.docker.com/r/facthunder/cppcheck) |  [2.0](https://github.com/danmar/cppcheck/releases/tag/2.0)  | [python:3.8.5-slim-buster](https://hub.docker.com/_/python) |
|  [2.0](https://hub.docker.com/r/facthunder/cppcheck)   |  [2.0](https://github.com/danmar/cppcheck/releases/tag/2.0)  | [python:3.8.5-slim-buster](https://hub.docker.com/_/python) |
|  [1.90](https://hub.docker.com/r/facthunder/cppcheck)  | [1.90](https://github.com/danmar/cppcheck/releases/tag/1.90) | [python:3.8.1-alpine](https://hub.docker.com/_/python) |
|  [1.89](https://hub.docker.com/r/facthunder/cppcheck)  | [1.89](https://github.com/danmar/cppcheck/releases/tag/1.89) | [python:3.7.4-alpine](https://hub.docker.com/_/python) |
|  [1.88](https://hub.docker.com/r/facthunder/cppcheck)  | [1.88](https://github.com/danmar/cppcheck/releases/tag/1.88) | [python:3.7.4-alpine](https://hub.docker.com/_/python) |
|  [1.87](https://hub.docker.com/r/facthunder/cppcheck)  | [1.87](https://github.com/danmar/cppcheck/releases/tag/1.87) | [python:3.7.3-alpine](https://hub.docker.com/_/python) |

### How to contribute
If you experienced a problem with the plugin please open an issue. Inside this issue please explain us how to reproduce this issue and paste the log.

If you want to do a PR, please put inside of it the reason of this pull request. If this pull request fix an issue please insert the number of the issue or explain inside of the PR how to reproduce this issue.

### License
Copyright 2020 Facthunder.

Licensed under the [GNU General Public License, Version 3.0](https://www.gnu.org/licenses/gpl.txt)
