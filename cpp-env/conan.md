## application configurations

get conan home: `conan config home`, or `~/.conan`

install collection of configs: `conan config install <url>`

conan application configuration: `conan config get`, or `~/.conan/conan.conf`

show some configurations items: `conan config get general.revisions_enabled`

change a single config value: `conan config set general.revisions_enabled=1`

## remotes

list remote repos: `conan remote list`, or `~/.conan/remotes.json`

add a remote: `conan remote add my_remote <url>`

## profiles

```
CROSS_GCC=arm-linux-gnueabihf

include(default)              # Can include other configurations, for example the default configuration

[settings]
os=Linux
compiler=gcc
compiler.version=6
compiler.libcxx=libstdc++11
build_type=Release
arch=armv7
os_build=Linux
arch_build=x86_64
OpenSSL:compiler.version=4.8  # Dependency-specific value

[options]
shared=True

[env]                         # Environment variables
CC=$CROSS_GCC-gcc             # Strings can be defined and substituted
CXX=$CROSS_GCC-g++

[tool_requires]               # Requirements for package builds only
cmake/3.16.3
```

list all profiles: `conan profile list`

contents of a profile (eg. default): `conan profile show default`, or `~/.conan/profiles/default`

use profile with other command: `conan <command> . -pr=<profile1> -pr=<profile2>`, last `-pr` wins for conflicts

## project configurations

display attributes of `conanfile.py`: `conan inspect <path> [-a <attribute>]`, eg. `conan inspect boost/1.79.0 -a options`

display package recipe in full: `conan get <reference>`, eg. `conan get boost/1.79.0`, list its `conanfile.py`

display dependency graph info for a recipe: `conan info <path_or_reference>`

## search for packages

`conan search zlib -r conancenter`

```bash
mkdir build && cd build
conan install ..

cmake .. && cmake --build .
```

## create a package

1. create a recipe (conanfile.py) from templates: `conan new <reference> -m <template>`
2. export the recipe to local cache(?): `conan export <path_to_conanfile>`
3. create package from recipe for one configuration, implicitly does install and export steps: `conan create . -pr <profile>`

## using packages in an application

1. write a `conanfile.txt` (`conanfile.py`?)

```
[requires]                     # The Conan packages which are used in the application
boost/1.72.0                   # Versions override versions upstream in the dependency graph
poco/1.9.4

[tool_requires]                # The Conan packages which are used to build the application
7zip/16.00

[generators]                   # Generators create build system files that capture the dependency information,
cmake                          # as well as configuration information from Conan settings and options

[options]                      # Options here override options upstream in the dependency graph
boost:shared=True              # Options can be specified on a per-package basis for dependencies
poco:shared=True

[imports]                      # Copies files from the cache to the current working directory
bin, *.dll -> ./bin            # Copies all .dll files from the packages' bin/ folder to the local bin/ folder
```

2. get dependencies and generate build system files(?),

```
conan install . [-o <package>:<option>=<value>]  # Specify options, e.g. shared=True
                [-s <package>:<setting>=<value>] # Specify settings, e.g. build_type=Debug
                                                 # <package> is optional: if not specified, the option/setting
                                                 # applies to all dependencies
                [-r=<remote ID>]                 # Download dependencies from only the specified remote
                [-g=<generator>]                 # Specify generators at the command line
```

3. include interface files to the Conan packages in the source code
4. modify the build system to use the files output from the generator
5. build the application using the build system

## upload a package

`conan upload zlib* -r remote --all`

## copy package to local project folder

`conan install zlib/1.2.11@ -g deploy`

## remove package from cache

```
conan remote 'boost/*'
```

## question

what is `path`, `reference`?

