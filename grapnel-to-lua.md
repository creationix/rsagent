If we target either lua or luajit bytecode, grapnel can be compiled in
JavaScript and execute in lua!

The plan is to start out without any design constraints imposed by the lua VM,
but later minor modifications can be made to make it optimize better.

- For example, lua doesn't have 64-bit integers, but luajit can represent them
  using the FFI interface.

- Also with FFI we have fast typed access to C standard libraries.
- And we can define our own C structs, but deal with them in JIT optimized lua.
