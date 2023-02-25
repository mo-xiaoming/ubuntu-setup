## download source

```bash
LLVM_VER=15.0.3
git clone --depth=1 https://github.com/llvm/llvm-project.git llvm-${LLVM_VER} -b llvmorg-${LLVM_VER} --single-branch
```

```bash
cmake -G Ninja -S llvm -B build -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_INSTALL_PREFIX=$PWD/install -DLLVM_USE_SPLIT_DWARF=ON -DCMAKE_BUILD_TYPE=Debug -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON
cmake -G Ninja -S llvm -B build -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_INSTALL_PREFIX=$PWD/install -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_USE_SANITIZER="Address"
cmake -G Ninja -S llvm -B build -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_INSTALL_PREFIX=$PWD/install -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_BUILD_TYPE=Debug -DLLVM_ENABLE_RTTI=ON
```

#git fetch --unshallow # to contribute?

## build libc++ with clang itself

```bash
TARGET_TRIPLE=x86_64-unknown-linux-gnu

#cmake -G Ninja -S llvm -B build -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lldb;compiler-rt;lld;polly" \  #Configure
#                                -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
#                                -DLLVM_RUNTIME_TARGETS=${TARGET_TRIPLE} \
#                                -DLLVM_OPTIMIZED_TABLEGEN=ON \
#                                -DLLVM_TARGETS_TO_BUILD=X86 \
#                                -DCMAKE_BUILD_TYPE=Release \
#                                -DCMAKE_INSTALL_PREFIX=$PWD/install
#cmake --build build
#ninja check-all
#ninja install

cmake -G Ninja -S llvm -B build -DLLVM_ENABLE_PROJECTS="clang"                      \  # Configure
                                -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
                                -DCMAKE_BUILD_TYPE=Release                          \
                                -DLLVM_RUNTIME_TARGETS=${TARGET_TRIPLE}
ninja -C build runtimes                                                                # Build
ninja -C build check-runtimes                                                          # Test
ninja -C build install-runtimes
```

```bash
clang++ -nostdinc++ -nostdlib++ -isystem $LLVM_PATH/include/c++/v1 -isystem $LLVM_PATH/include/${TARGET_TRIPLE}/c++/v1 -L $LLVM_PATH/lib/${TARGET_TRIPLE} -Wl,-rpath,$LLVM_PATH/lib/${TARGET_TRIPLE} -lc++
```
