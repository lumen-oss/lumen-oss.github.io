---
id: making-the-application
title: Making the CLI Application
---

`lux` expects to find code under either a `src/` or `lua/` directory.
For this series, we'll store our code under `src/`.

Inside the project directory (where your `lux.toml` resides) create a `src/main.lua` file.
This acts as the main file `lux` will execute.

Here's the output of `tree .` after creating the file:
```sh title="tree ."
.
├── lux.toml
└── src
    └── main.lua

2 directories, 2 files
```

## Ensuring the Project Runs

First, let's put some code in our `main.lua` file:

```lua title="src/main.lua"
local argparse = require("argparse")

-- Create an argument parser
local parser = argparse("script", "An example.")
parser:argument("input", "Input file.")

local args = parser:parse()

-- Directly print out the "input" argument
print(args.input)
```

We're now ready to see if our code works! Run the following command to see your code in action:

```sh
lux run "Testing our code!"
```

You should see `Testing our code!` printed right back at you in the console!

## Expanding the Code

In preparation for the next chapter, let's create some extra logic for our program:

```lua title="src/main.lua"
--- Checks whether input has the word "hello"
--- @param input string
local function has_hello(input)
    return input:lower():find("hello") ~= nil
end

local argparse = require("argparse")

-- Create an argument parser
local parser = argparse("script", "An example.")
parser:argument("input", "Input file.")

local args = parser:parse()

-- Directly print out the "input" argument
if has_hello(args.input) then
    print("Your input has the word 'hello' in it!")
else
    print("Your input does not have the word 'hello' in it!")
end
```

We've transformed our program to check if the input contains the word "hello".
Below are some example outputs:

```none title='lux run "Hello, world!"'
Your input has the word 'hello' in it!
```

```none title='lux run "Hi, world!"'
Your input does not have the word 'hello' in it!
```

We're now ready to move on to the next stage of our program's lifecycle - testing.
