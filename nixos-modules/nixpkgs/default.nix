{ lib, ... }: {
  nixpkgs = {
    config = {
      cudaSupport = true;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        # Steam
        "steam"
        "steam-unwrapped"
        "steam-original"
        "steam-run"
        # nvidia drivers
        "nvidia-x11"
        "nvidia-settings"
        # CUDA support
        "cudnn"
        "cudatoolkit"
        "cuda-merged"
        "cuda_cuobjdump"
        "cuda_gdb"
        "cuda_nvcc"
        "cuda_nvdisasm"
        "cuda_nvprune"
        "cuda_cccl"
        "cuda_cudart"
        "cuda_cupti"
        "cuda_cuxxfilt"
        "cuda_nvml_dev"
        "cuda_nvrtc"
        "cuda_nvtx"
        "cuda_profiler_api"
        "cuda_sanitizer_api"
        "libcublas"
        "libcufft"
        "libcurand"
        "libcusolver"
        "libcusparse"
        "libcusparse_lt"
        "libnpp"
        "libnvjitlink"
        # Tools
        "vault-bin"
        "netdata"
        "jetbrains-toolbox"
        "rust-rover"
        "goland"
        "parsec-bin"
        "teamspeak6-client"
      ];
    };
  };
}
