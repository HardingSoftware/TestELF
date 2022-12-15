ScriptPath=$(cd "$(dirname "$0")";pwd)

BUILD_TYPE=Debug
BUILD_DIR=build-linux-${BUILD_TYPE}

CMAKE_ARGS="-DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE" 

# SDK1

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS}
cmake --build . --target TestELF -- -j 4

echo

./App/TestELF