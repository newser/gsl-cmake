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
