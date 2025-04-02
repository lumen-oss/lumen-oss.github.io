---
id: making-the-application
title: Making the CLI Application
---

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

Run the following command to see your code in action:

```sh
lx run "Testing our code!"
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
