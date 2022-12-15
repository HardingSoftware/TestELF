ScriptPath=$(cd "$(dirname "$0")";pwd)

BUILD_TYPE=Debug
BUILD_DIR=build-macos-${BUILD_TYPE}

CMAKE_ARGS="-DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE" 
CMAKE_ARGS="${CMAKE_ARGS} -G Xcode" 

cd ${ScriptPath}/App

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS}
cmake --build . --target TestELF -j 4

echo

./App/$BUILD_TYPE/TestELF