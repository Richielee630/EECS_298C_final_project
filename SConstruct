
env = Environment()

includes = '''
              .
              ./cost-model/include
              ./cost-model/include/base
              ./cost-model/include/tools
              ./cost-model/include/user-api
              ./cost-model/include/dataflow-analysis
              ./cost-model/include/dataflow-specification-language
              ./cost-model/include/design-space-exploration
              ./cost-model/include/cost-analysis
              ./cost-model/include/abstract-hardware-model
              ./cost-model/src
              /opt/homebrew/opt/boost/include
'''

# Append Boost library paths and flags
env.Append(CPPPATH=Split(includes))  # Include paths
env.Append(LIBPATH=['/opt/homebrew/opt/boost/lib'])  # Library paths
env.Append(LIBS=['boost_program_options', 'boost_filesystem', 'boost_system'])  # Boost libraries

# Compiler and linker flags
env.Append(CXXFLAGS=['-std=c++17'])  # Set C++17 standard
env.Append(LINKFLAGS=[])  # Leave empty if no special linker flags are needed

env.Append(CPPPATH = Split(includes))
#env.Program("maestro-top.cpp")
#env.Program('maestro', ['maestro-top.cpp', 'lib/src/maestro_v3.cpp', 'lib/src/BASE_base-objects.cpp' ])
env.Program('maestro', ['maestro-top.cpp', 'cost-model/src/BASE_base-objects.cpp' ])
#env.Library('maestro', ['maestro-top.cpp', 'lib/src/maestro_v3.cpp', 'lib/src/BASE_base-objects.cpp' ])

