function(add_group dir group src_list)
    aux_source_directory(${dir} FILE)
    source_group(${group} FILES ${FILE})

    set(${src_list} ${${src_list}} ${FILE} PARENT_SCOPE)
endfunction(add_group)

function(add_group_hdr dir group hdr_list)
    file(GLOB FILE "${dir}/*.h")
    source_group(${group} FILES ${FILE})

    set(${hdr_list} ${${hdr_list}} ${FILE} PARENT_SCOPE)
endfunction(add_group_hdr)

macro(set_if src lib cmp result)
    if (NOT ${result}_CACHED)
        file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/tmp)
        set(f ${CMAKE_BINARY_DIR}/tmp/tmp.c)
        file(WRITE ${f} "${src}")

        try_run(run_result 
                compile_result 
                ${CMAKE_BINARY_DIR}/tmp 
                ${f}
                CMAKE_FLAGS -DLINK_LIBRARIES:STRING=${lib})

        if (compile_result AND (run_result EQUAL ${cmp}))
            set(${result} 1 CACHE BOOL "")
        else ()
            set(${result} 0 CACHE BOOL "")    
        endif ()
        set(${result}_CACHED 1 CACHE BOOL "") 
        mark_as_advanced(${result} ${result}_CACHED)
    endif ()
endmacro()
