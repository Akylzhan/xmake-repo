package("adaptivecpp")
    set_kind("toolchain")
    set_homepage("https://adaptivecpp.github.io/")
    set_description("Compiler for multiple programming models (SYCL, C++ standard parallelism, HIP/CUDA) for CPUs and GPUs from all vendors: The independent, community-driven compiler for C++-based heterogeneous programming models.")
    set_license("BSD-2-Clause")

    set_urls("https://github.com/AdaptiveCpp/AdaptiveCpp/archive/refs/tags/v$(version).tar.gz")
    add_versions("24.10.0", "3bcd94eee41adea3ccc58390498ec9fd30e1548af5330a319be8ce3e034a6a0b")

    add_deps("cmake", "python", "openmp", "opencl")
    add_deps("llvm >=14.0")
    add_deps("boost", {configs = {fiber = true, context = true, filesystem = false, exception = true, regex = true}})

    add_includedirs("include/AdaptiveCpp")

    on_install(function (package)
        local configs = {}
        import("package.tools.cmake").install(package, configs)
    end)

    on_check(function (toolchain)
        return import("lib.detect.find_tool")("acpp")
    end)

    on_test(function (package)
        os.vrunv("acpp", {"--version"})
    end)
