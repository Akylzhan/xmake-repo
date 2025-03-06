rule("compiler")
    set_extensions(".slint")

    on_config(function (target)
        local r = target:rule("c++.build")
        if r then
            r = r:clone()
            r:add("deps", "@slint/compiler", {order = true})
            target:rule_add(r)
        end

        local autogendir = path.join(target:autogendir(), "slint")
        os.mkdir(autogendir)
        target:add("includedirs", autogendir)

        import("lib.detect.find_program")
        local slint_compiler = find_program("slint-compiler", {envs = os.joinenvs(os.getenvs(), target:pkgenvs())})
        assert(slint_compiler, "could not find slint-compiler")
    end)

    on_buildcmd_file(function (target, batchcmds, sourcefile, opt)
        import("lib.detect.find_program")
        local slint_compiler = find_program("slint-compiler", {envs = os.joinenvs(os.getenvs(), target:pkgenvs())})

        local abs_path = path.join(target:scriptdir(), sourcefile)
        local autogendir = path.join(target:autogendir(), "slint")
        local output_path = path.join(autogendir, path.basename(abs_path) .. ".h")

        batchcmds:vrunv(slint_compiler, {abs_path, "-o", output_path})
        batchcmds:add_depfiles(sourcefile)
    end)