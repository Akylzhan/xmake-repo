package("slint")
    set_description("Slint C++ SDK")
    set_homepage("https://slint.dev/")
    set_description("Slint is a declarative GUI toolkit to build native user interfaces for Rust, C++, or JavaScript apps. ")
    set_license("Slint License")

    add_urls("https://github.com/slint-ui/slint/releases/download/v$(version)/Slint-cpp-$(version)-Linux-x86_64.tar.gz")
    add_versions("1.10.0", "a424290f69ffa32f09384ef53a17c006fb04a39c52173603675ba0c7be161800")

    add_bindirs("bin")
    add_includedirs("include/slint")

    on_install(function (package)
        os.cp("*", package:installdir())
        package:addenv("LD_LIBRARY_PATH", package:installdir("lib"))
    end)

    on_test(function (package)
        os.vrun("slint-compiler --version")
    end)
