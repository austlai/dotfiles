function cgen
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    mv build/compile_commands.json ./compile_commands.json
end
