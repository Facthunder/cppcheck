# Docker image for Cppcheck

This project aims to provide a simple Docker image to encapsulate and run a Cppcheck analysis through Docker.

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

#### Run CERT checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src facthunder/cppcheck:latest "cppcheck --dump .; cert.py *.dump 2>report.xml"
```

### Versions matrix
Here is theVERs matrix of the image:

|     TAG     | CPPCHECK VERSION |                     BASE IMAGE                    |
|:-----------:|:----------------:|:-------------------------------------------------:|
|    latest   |       1.87       |  [alpine:3.9.3](https://hub.docker.com/_/alpine)  |
|     1.87    |       1.87       |  [alpine:3.9.3](https://hub.docker.com/_/alpine)  |

### How to contribute
If you experienced a problem with the plugin please open an issue. Inside this issue please explain us how to reproduce this issue and paste the log.

If you want to do a PR, please put inside of it the reason of this pull request. If this pull request fix an issue please insert the number of the issue or explain inside of the PR how to reproduce this issue.

### License
Copyright 2019 Facthunder.

Licensed under the [GNU General Public License, Version 3.0](https://www.gnu.org/licenses/gpl.txt)
