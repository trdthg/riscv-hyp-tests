# Run tests on C based emulator extracted from sail model
# 
# Assumes sail model sits next to this repository 
# and that C based emulator is build

csim=sail_riscv_sim;

# Build tests
export PLAT=sail LOG_LEVEL=LOG_WARNING;
make

# Run tests
# $csim --enable-hext --ram-size 256 -t log/sail_term.log --enable-dirty-update --mtval-has-illegal-inst-bits --pmp-count 16 build/sail/rvh_test.elf > log/sail_trace.log
$csim --config ../rv64d_v128_e64.json ./build/sail/rvh_test.elf --trace-output log/sail_trace.log --trace-all
