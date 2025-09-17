# Cross-Unlinking: Experimental Cross-Format Binary Conversion

Cross-unlinking enables analysis of Windows PE, macOS Mach-O, and COFF object files within Linux ELF analysis environments through format conversion and procedural debugging.

## Overview

This experimental framework demonstrates cross-format binary conversion capabilities that extend the Witchcraft Compiler Collection (WCC) beyond ELF-only analysis. By converting binaries between formats while preserving functional semantics, analysts can apply unified methodologies across heterogeneous computing environments.

**Supported Conversions:**
- COFF object files → ELF shared libraries
- PE executables → ELF shared libraries  
- Mach-O object files → ELF shared libraries

## Quick Start

### Docker Environment

```bash
# Build the cross-format analysis environment
make

# Verify binary format detection
make filetypes

# Run complete validation suite
make test
```

### Expected Output

The validation demonstrates functional conversion across all three major binary formats:

```
test_math.o:   Intel amd64 COFF object file
test_math.exe: PE32+ executable (console) x86-64
test.macho:    Mach-O 64-bit x86_64 object

./test-coff.wsh
 [*] computing add_numbers(3,4)
7
PASS

./test-pe.wsh  
 [*] computing add_numbers(3,4)
7
PASS

./test-macho.wsh
 [*] computing add_numbers(3,4) 
7
PASS
```

## Technical Implementation

### Cross-Format Pipeline

1. **Source Compilation**: Target binaries compiled using platform-specific toolchains
2. **Format Conversion**: WCC transforms foreign formats into ELF object files
3. **ELF Integration**: Standard GNU tools link converted objects into shared libraries
4. **Procedural Debugging**: WSH enables direct function invocation across calling conventions

### Calling Convention Handling

The framework automatically handles platform-specific calling conventions:

- **Microsoft x64**: Arguments in RCX, RDX, R8, R9
- **System V AMD64**: Arguments in RDI, RSI, RDX, RCX, R8, R9  
- **macOS**: Standard System V conventions

### Test Cases

The validation suite includes three mathematical functions across all formats:

- `add_numbers(a, b)`: Basic integer addition
- `multiply(x, y)`: Integer multiplication  
- `fibonacci(n)`: Iterative Fibonacci computation

## Prerequisites

- Docker Engine (20.10+)
- x86_64 Linux host system
- 4GB available RAM
- 2GB disk space

## Installation

```bash
# Clone the repository
git clone https://github.com/endrazine/wcc-cross-unlinking
cd wcc-cross-unlinking

# Build Docker environment
make

# Verify installation
make filetypes
```

## Limitations and Scope

### Current Scope
- Proof-of-concept demonstration with simple mathematical functions
- Single-architecture validation (x86_64 only)
- Manual symbol recovery required for PE executables

### Known Issues
- Limited validation across diverse binary types
- Manual offset calculation required for PE symbol restoration
- Architecture-specific implementation (no cross-architecture support)
- Segmentation fault handling required for Mach-O data section parsing

### Future Work
- Automated symbol recovery for stripped PE executables
- Extended validation across complex applications
- Multi-architecture cross-unlinking support
- Improved error handling for malformed binaries

## Repository Structure

```
├── Dockerfile              # Reproducible build environment
├── Makefile                # Build and test automation
├── testcases/              # Source files for validation
│   ├── simple_math.c       # Basic mathematical functions (Mach-O)
│   └── test_math.c         # Windows-specific exports (PE/COFF)
├── test-coff.wsh          # COFF validation script
├── test-pe.wsh            # PE validation script
├── test-macho.wsh         # Mach-O validation script
└── get.binutils.sh        # Binary utilities installation
```

## Troubleshooting

### Common Issues

**Docker Build Failures:**
- Ensure sufficient disk space (2GB minimum)
- Verify Docker daemon is running
- Check internet connectivity for package downloads

**Symbol Resolution Errors:**
- PE executables require manual symbol addition via objcopy
- Verify function offset calculations match compiled binaries
- Check that calling convention adjustments are applied correctly

**Cross-Compilation Issues:**
- Ensure mingw-w64 toolchain is properly installed
- Verify clang Darwin target support is available
- Check Wine installation for PE executable generation

## Academic Context

This experimental work demonstrates the extensibility of binary libification beyond ELF-focused environments. While not production-ready, the functional cross-format conversion validates that metadata-only transformation principles apply across major executable formats.

**Related Publications:**
- Brossard, J. "Introduction to Procedural Debugging through Binary Libification." USENIX WOOT 2024.
- Brossard, J. "Toward Partial Proofs of Vulnerabilities." IEEE SecDev 2024.

## Contributing

This is experimental research code. Issues and improvements are welcome, but production deployment is not recommended without extensive additional validation.

## License

Dual MIT/BSD License (consistent with WCC framework)

## Citation

If you use this experimental work in research, please cite the parent WCC framework and note the experimental status of cross-format capabilities:

```bibtex
@inproceedings{brossard2024procedural,
  title={Introduction to Procedural Debugging through Binary Libification},
  author={Brossard, Jonathan},
  booktitle={18th USENIX Workshop on Offensive Technologies (WOOT 24)},
  year={2024}
}
```

## Disclaimer

This is experimental research software intended for academic and research purposes. The cross-format conversion capabilities are proof-of-concept demonstrations that require additional validation before production use. Use at your own risk in controlled environments only.
