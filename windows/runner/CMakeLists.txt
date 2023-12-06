cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME} WIN32
  "flutter_window.cpp"
  "main.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
  "Runner.rc"
  "runner.exe.manifest"
)

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# Add dependency libraries and include directories. Add any application-specific
# dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)


get_filename_component(P1 ${CMAKE_CURRENT_BINARY_DIR} DIRECTORY)
message(STATUS "P1 ==> " ${P1})

#  not good at CMakeLists
get_filename_component(_parent ${P1} DIRECTORY)
get_filename_component(_grandparent ${_parent} DIRECTORY)
get_filename_component(_grandgrandparent ${_grandparent} DIRECTORY)

message(STATUS "_grandgrandparent ==> " ${_grandgrandparent})



add_custom_target(copy-runtime-files ALL
  COMMAND ${CMAKE_COMMAND} -E copy ${_grandgrandparent}/fsb.dll ${P1}/runner/Debug/fsb.dll
  COMMAND ${CMAKE_COMMAND} -E copy ${_grandgrandparent}/fsb.dll ${P1}/runner/Release/fsb.dll


  COMMAND ${CMAKE_COMMAND} -E copy ${_grandgrandparent}/icon.png ${P1}/runner/Debug/icon.png
  COMMAND ${CMAKE_COMMAND} -E copy ${_grandgrandparent}/icon.png ${P1}/runner/Release/icon.png
)