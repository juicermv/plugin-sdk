--! NuMake Project

function AddTables(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

local shared_paths = {
    "shared",
    "shared/game",
    "shared/bass",
    "shared/comp",
    "shared/dxsdk",
    "shared/extender",
    "shared/extensions",
    "shared/rwd3d9",
}

local filter = {"cpp", "h", "rc"}

function Get3DGameDirs(game)
    return {
        "plugin_" .. game,
        "plugin_" .. game .. "/game_" .. game,
        "plugin_" .. game .. "/game_" .. game .. "/meta",
        "plugin_" .. game .. "/game_" .. game .. "/rw",
        "hooking"
    }
end

local msvc_flags_compiler = {
    "/std:c++latest",
    "/Ox",
    "/W3",
    "/sdl-",
    "/GF",
    "/Gy",
    "/Oi",
    "/MT",
}

local msvc_flags_linker = {
    "/SUBSYSTEM:WINDOWS",
    "/LTCG",
}

local mingw_flags_compiler = {
    "-std=gnu++23",
    "-O2",
    "-static",
    "-fpermissive",
    "-fcommon",
    "-mhard-float",
    "-ffunction-sections",
    "-fdata-sections"
}

local mingw_flags_linker = {
    "--subsystem,windows",
    "--gc-sections"
}

local plugin_sa = Project(
    "plugin_sa",
    "c++",
    "plugin.lib",
    AddTables(
        filesystem:walk("hooking", false, filter),
        AddTables(
            filesystem:walk("shared", true, filter),
            filesystem:walk("plugin_sa", true, filter)
        )
    ),
    nil,
    AddTables(Get3DGameDirs("sa"), shared_paths),
    shared_paths,
    nil,
    {
        "_HAS_CXX17",
        "_CRT_SECURE_NO_WARNINGS",
        "_CRT_NON_CONFORMING_SWPRINTFS",
        "_USE_MATH_DEFINES",
        "_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING",
        "_DX9_SDK_INSTALLED",
        "GTASA",
        "PLUGIN_SGV_10US",
        "RW"
    },
    msvc_flags_compiler,
    msvc_flags_linker,
    nil,
    nil,
    "x86",
    "staticlibrary"
)

local plugin_3 = Project(
    "plugin_3",
    "c++",
    "plugin_iii.lib",
    AddTables(
        filesystem:walk("hooking", false, filter),
        AddTables(
            filesystem:walk("shared", true, filter),
            filesystem:walk("plugin_III", true, filter)
        )
    ),
    nil,
    AddTables(Get3DGameDirs("III"), shared_paths),
    shared_paths,
    nil,
    {
        "_HAS_CXX17",
        "_CRT_SECURE_NO_WARNINGS",
        "_CRT_NON_CONFORMING_SWPRINTFS",
        "_USE_MATH_DEFINES",
        "_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING",
        "_DX9_SDK_INSTALLED",
        "GTA3",
        "PLUGIN_SGV_10EN",
        "RW"
    },
    msvc_flags_compiler,
    msvc_flags_linker,
    nil,
    nil,
    "x86",
    "staticlibrary"
)

local plugin_vc = Project(
    "plugin_vc",
    "c++",
    "plugin_vc.lib",
    AddTables(
        filesystem:walk("hooking", false, filter),
        AddTables(
            filesystem:walk("shared", true, filter),
            filesystem:walk("plugin_vc", true, filter)
        )
    ),
    nil,
    AddTables(Get3DGameDirs("vc"), shared_paths),
    shared_paths,
    nil,
    {
        "_HAS_CXX17",
        "_CRT_SECURE_NO_WARNINGS",
        "_CRT_NON_CONFORMING_SWPRINTFS",
        "_USE_MATH_DEFINES",
        "_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING",
        "_DX9_SDK_INSTALLED",
        "GTAVC",
        "PLUGIN_SGV_10EN",
        "RW"
    },
    msvc_flags_compiler,
    msvc_flags_linker,
    nil,
    nil,
    "x86",
    "staticlibrary"
)

function MSVC_SA() 
    msvc:build(plugin_sa)
end

function MSVC_III() 
    msvc:build(plugin_3)
end

function MSVC_VC() 
    msvc:build(plugin_vc)
end

function MINGW_SA()
    plugin_sa.arch = "i686"
    plugin_sa.compiler_flags = mingw_flags_compiler
    plugin_sa.linker_flags = mingw_flags_linker
    plugin_sa.output = "libplugin.a"

    mingw:build(plugin_sa)
end

function MINGW_III()
    plugin_3.arch = "i686"
    plugin_3.compiler_flags = mingw_flags_compiler
    plugin_3.linker_flags = mingw_flags_linker
    plugin_3.output = "libplugin_iii.a"

    mingw:build(plugin_3)
end

function MINGW_VC()
    plugin_vc.arch = "i686"
    plugin_vc.compiler_flags = mingw_flags_compiler
    plugin_vc.linker_flags = mingw_flags_linker
    plugin_vc.output = "libplugin_vc.a"
    mingw:build(plugin_vc)
end

tasks:create("msvc_sa", MSVC_SA)
tasks:create("msvc_iii", MSVC_III)
tasks:create("msvc_vc", MSVC_VC)

tasks:create("mingw_sa", MINGW_SA)
tasks:create("mingw_iii", MINGW_III)
tasks:create("mingw_vc", MINGW_VC)

tasks:create("mingw_all", 
    function()
        MINGW_SA()
        MINGW_III()
        MINGW_VC()
    end
)


tasks:create("msvc_all", 
    function()
        MSVC_SA()
        MSVC_III()
        MSVC_VC()
    end
)

tasks:create("all", 
    function()
        MINGW_SA()
        MINGW_III()
        MINGW_VC()

        MSVC_SA()
        MSVC_III()
        MSVC_VC()
    end
)

