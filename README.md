# RISCV-HYP-TESTS

The origin repo [josecm/riscv-hyp-tests](https://github.com/josecm/riscv-hyp-tests) use syscall, and [defermelowie/riscv-hyp-tests](https://github.com/defermelowie/riscv-hyp-tests) \(sail branch\) replace it with htif to support sail-model

This fork fixed some tests and try to add more tests

---

## About
This repository hosts unit tests for riscv hypervisor extension.

Testing is done by executing bare metal applications, which *set up the environment at different privilege levels*, *execute the testing code or trigger traps* and *check the execution results and processor status* to determine if specific features of the target platform is compliant with the hypervisor extension specification.

## Building
We assume that the RISC-V toolchain is installed and is added to the PATH.

### Target platform

The target platform on which the test will run should be specified by setting the PLAT environment variable. Platforms that are currently supported are listed in the table below:

| Platform               | `${target_platform}` | Example usage
|:-----------------------|:---------------------|:------------------
| *QEMU*                 | `qemu`               | [`run_on_qemu.sh`](./scripts/run_on_qemu.sh)
| *Rocket Chip Emulator* | `rocket_emul`        | /
| *Rocket Chip FPGA*     | `rocket_fpga`        | /
| *Spike Emulator*       | `spike`              | [`run_on_spike.sh`](./scripts/run_on_spike.sh)

### Output level

The output level can be specified via the `LOG_LEVEL` environment variable (default is `LOG_INFO`). 

Options include:
`LOG_NONE`, `LOG_ERROR`, `LOG_INFO`, `LOG_DETAIL`, `LOG_WARNING`, `LOG_VERBOSE`, `LOG_DEBUG`

### Compile

The build process is as follows:

```bash
$ git clone https://github.com/josecm/riscv-hyp-tests
$ cd riscv-hyp-tests
$ PLAT=${target_platform} make
```

The compilation result is located at *build/*`${target_platform}`*/rvh_test.elf* or *rvh_test.bin*.

### Run

[`scripts/run_on_spike.sh`](scripts/run_on_spike.sh) is a script to run on spike

### Trouble-shooting

#### *boot.S:6: Error: unrecognized opcode `csrwi sscratch,0xf'*

We found that in higher versions of RISC-V gcc than gcc-10, instructions such as `csrwi` are grouped separately under the *zicsr extension* and need to be specified explicitly by appending `zicsr` string to the `-march` parameter of gcc.


#### *additional relocation overflows omitted from the output* or *relocation truncated to fit: R_RISCV_HI20*
Please check if the currently used RISC-V toolchain is configured with the `--with-cmodel=medany` parameter.
This can be determined by executing command: `riscv64-unknown-elf-gcc -v`.

And look at the `Configured with: ......` line in the output.
