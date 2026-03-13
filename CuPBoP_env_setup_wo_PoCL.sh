
source ../vortex/build/ci/toolchain_env.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export VORTEX_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export LLVM_VORTEX="$VORTEX_HOME/llvm/build"
export CuPBoP_PATH="$SCRIPT_DIR"
export VORTEX_PATH="$VORTEX_HOME/vortex/build"

########## USER DEFINED VARIABLES ##########
export VORTEX_ARCHITECTURE=64     #(32 or 64)
export VORTEX_SCHEDULE_FLAG=2     #(0(TM) or 1(CM) or 2(1:1 mapping, default)
export VORTEX_LOCALMEM_FLAG="${VORTEX_LOCALMEM_FLAG:-1}"     # Switch for Vortex Localmem HW (only works for schedule=2)
#############################################

if [ -z "${TOOLDIR}" ]; then
  echo "Error: TOOLDIR(Vortex Toolchain) is not defined. Please check your Vortex environment."
  #exit 1
fi

if [ -z "${VORTEX_HOME}" ]; then
  echo "Error: VORTEX_HOME is not defined. Please check whether Vortex is built and installed."
  #exit 1
fi

if [ -z "${LLVM_VORTEX}" ]; then
  echo "Error: LLVM_VORTEX is not defined. Please check whether Vortex LLVM is built and installed."
  #exit 1
fi

if [ -z "${CuPBoP_PATH}" ]; then
  echo "Error: CuPBoP_PATH is not defined. Please check whether CuPBoP is built and installed."
  #exit 1
fi

if [ -z "${VORTEX_PATH}" ]; then
  echo "Error: VORTEX_PATH is not defined. Please check where vortex build are located"
  #exit 1
fi


# if vortex architecture is 64bit
if [ $VORTEX_ARCHITECTURE -eq 64 ]; then
    export RISCV_TOOLCHAIN_PATH=$TOOLDIR/riscv64-gnu-toolchain
    export RISCV_TOOLCHAIN=${TOOLDIR}/riscv64-gnu-toolchain
    export GNU_RISCV_ROOT=${TOOLDIR}/riscv64-gnu-toolchain
else
    export RISCV_TOOLCHAIN_PATH=$TOOLDIR/riscv32-gnu-toolchain
    export RISCV_TOOLCHAIN=${TOOLDIR}/riscv32-gnu-toolchain
    export GNU_RISCV_ROOT=${TOOLDIR}/riscv32-gnu-toolchain
fi

export VORTEX_DRIVER_INC=$VORTEX_HOME/runtime/include
export VORTEX_DRIVER_LIB=$VORTEX_PATH/runtime/libvortex.so

export LLVM_PREFIX=${LLVM_VORTEX}
export PATH="$LLVM_PREFIX/bin:$PATH"

export VERILATOR_ROOT=${TOOLDIR}/verilator
export SV2V_PATH=$TOOLDIR/sv2v
export YOSYS_PATH=$TOOLDIR/yosys
export PATH=$YOSYS_PATH/bin:$SV2V_PATH/bin:$VERILATOR_ROOT/bin:$PATH

export CUDA_PATH=$CuPBoP_PATH/cuda-12.1
export PATH="$CUDA_PATH:$PATH"

export LD_LIBRARY_PATH="${GNU_RISCV_ROOT}:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${VORTEX_PATH}/runtime:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${CuPBoP_PATH}/build/runtime:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${CuPBoP_PATH}/build/runtime/threadPool:$LD_LIBRARY_PATH"
