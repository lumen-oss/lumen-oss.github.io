---
id: making-the-application
title: Making the CLI Application
---

Lux expects to find code under either a `src/` or `lua/` directory.
For this series, we'll store our code under `src/`.

Inside the project directory (where your `lux.toml` resides) create a `src/main.lua` file.
This acts as the main file Lux will execute.

Here's what your project directory should look like after creating the file:
```sh title="tree ."
.
├── lux.toml
└── src
    └── main.lua

2 directories, 2 files
```

## Ensuring the Project Runs

Let us add the following boilerplate code to `src/main.lua`:

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

Now we'll finalize what we sought to achieve in this series - checking whether the input contains the word "hello".
Let's expand our code to do just that:

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

Below are some example outputs, feel free to play around with the input:

```none title='lx run "Hello, world!"'
Your input has the word 'hello' in it!
```

```none title='lx run "Hi, world!"'
Your input does not have the word 'hello' in it!
```

Well done! Our code is done and dusted. However, this isn't all there is to writing an application.
We're now ready to move on to the next stage of our program's lifecycle - testing.
