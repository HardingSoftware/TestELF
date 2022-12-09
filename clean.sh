set -vx

ScriptPath=$(cd "$(dirname "$0")";pwd)

# SDK1

cd ${ScriptPath}/SDK1
rm -rf build-*

# SDK2

cd ${ScriptPath}/SDK2
rm -rf build-*

# App

cd ${ScriptPath}/App
rm -rf build-*
rm -rf 3rd/*