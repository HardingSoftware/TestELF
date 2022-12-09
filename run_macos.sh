ScriptPath=$(cd "$(dirname "$0")";pwd)

BUILD_TYPE=Release
BUILD_DIR=build-macos-${BUILD_TYPE}

CMAKE_ARGS="-DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE" 
CMAKE_ARGS="${CMAKE_ARGS} -G Xcode" 

# SDK1

cd ${ScriptPath}/SDK1

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS}
cmake --build . --target SDK1 -j 4

# SDK2

cd ${ScriptPath}/SDK2

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS}
cmake --build . --target SDK2 -j 4

cp ${ScriptPath}/SDK1/libSDK1.h ${ScriptPath}/App/3rd 
cp ${ScriptPath}/SDK1/$BUILD_DIR/$BUILD_TYPE/*SDK1* ${ScriptPath}/App/3rd 

cp ${ScriptPath}/SDK2/libSDK2.h ${ScriptPath}/App/3rd 
cp ${ScriptPath}/SDK2/$BUILD_DIR/$BUILD_TYPE/*SDK2* ${ScriptPath}/App/3rd 

# App

cd ${ScriptPath}/App

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS}
cmake --build . --target TestELF -j 4

echo

./$BUILD_TYPE/TestELF