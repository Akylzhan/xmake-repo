package("axslcc")
    set_homepage("")
    set_description("")

    set_license("")

    add_urls("https://github.com/Akylzhan/axslcc.git")

    set_kind("binary")

    on_install("windows", "macosx", "linux", function(package)
        import("package.tools.cmake").install(package)
    end)

    on_test(function(package)
        os.vrun("axslcc --version")
    end)
