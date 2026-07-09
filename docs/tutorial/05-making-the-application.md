---
id: making-the-application
title: Making the CLI Application
---

In this chapter, we'll write the CLI logic, starting with a simple echo, then the
"hello" detector we planned from the start.

## Creating the Skeleton

Let's add some simple boilerplate using `argparse`. This program will print back anything
we pass as arguments back into the console:

```lua title="src/main.lua"
local argparse = require("argparse")

-- Create an argument parser
local parser = argparse("script", "An example.")
parser:argument("input", "Input file.")

local args = parser:parse()

-- Directly print out the "input" argument
print(args.input)
```

`lx run` executes our project's entrypoint, the file we configured in the
`[run]` section of `lux.toml`, and passes any arguments along to it.
Run the following to see your code in action:

```sh
lx run "Testing our code!"
```

You should see `Testing our code!` printed right back at you in the console!

## Expanding the Code

Now we'll add the feature we set out to build: checking whether the input contains "hello".
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

Well done! Our code is ready. Next up: testing.
