set(LUASOCKET_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/luasocket)

include_directories(
  ${LUASOCKET_DIR}/src
)

  if ( WIN32 )
    set ( LUASOCKET_PLAT  
		${LUASOCKET_DIR}/src/wsocket.c 
	)
  else ( WIN32 )
    set ( LUASOCKET_PLAT 
		${LUASOCKET_DIR}/src/usocket.c 
		${LUASOCKET_DIR}/src/unix.c
		${LUASOCKET_DIR}/src/unixdgram.c
		${LUASOCKET_DIR}/src/unixstream.c
		${LUASOCKET_DIR}/src/serial.c
	)
  endif ( WIN32 )

add_library(luasocket
	${LUASOCKET_DIR}/src/auxiliar.c
	${LUASOCKET_DIR}/src/buffer.c
	${LUASOCKET_DIR}/src/compat.c
	${LUASOCKET_DIR}/src/except.c
	${LUASOCKET_DIR}/src/inet.c
	${LUASOCKET_DIR}/src/io.c
	${LUASOCKET_DIR}/src/luasocket.c
	${LUASOCKET_DIR}/src/mime.c
	${LUASOCKET_DIR}/src/options.c
	${LUASOCKET_DIR}/src/select.c
	${LUASOCKET_DIR}/src/tcp.c
	${LUASOCKET_DIR}/src/timeout.c
	${LUASOCKET_DIR}/src/udp.c

	${LUASOCKET_PLAT}
)

if (WIN32)
     target_link_libraries( luasocket Ws2_32 )
endif (WIN32)


set(EXTRA_LIBS ${EXTRA_LIBS} luasocket)
set(EXTRA_LUA ${EXTRA_LUA} 
	deps/luasocket/src/ftp.lua
	deps/luasocket/src/headers.lua
	deps/luasocket/src/http.lua
	deps/luasocket/src/ltn12.lua
	deps/luasocket/src/mbox.lua
	deps/luasocket/src/mime.lua
	deps/luasocket/src/smtp.lua
	deps/luasocket/src/socket.lua
	deps/luasocket/src/tp.lua
	deps/luasocket/src/url.lua
)

# fix a duplicate symbol clash with lrexlib
target_compile_definitions(luasocket PRIVATE buffer_init=lsocket_buffer_init )

add_definitions(-DWITH_LUASOCKET)