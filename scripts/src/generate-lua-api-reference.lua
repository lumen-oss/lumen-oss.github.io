#!/usr/bin/env -S nix develop .# -c lua

---@return string
local function _usage()
  return [[Usage: scripts/src/generate-lua-api-reference.lua]]
end

---@return boolean
local function build_lux_luajit()
  local cmd = "nix build .#lux-luajit --out-link result-lua 2>/dev/null"
  local ok = os.execute(cmd)
  return ok and true or false
end

---@return string
local function read_lux_version()
  local pipe = io.popen(
    "grep '^Version:' result-lua/lib/pkgconfig/lux-luajit.pc 2>/dev/null | cut -d' ' -f2",
    "r"
  )
  if not pipe then return "unknown" end
  local version = pipe:read("*l")
  pipe:close()
  return version or "unknown"
end

---@param input_dir string
---@param output_dir string
---@return boolean
local function run_emmylua_doc_cli(input_dir, output_dir)
  os.execute("rm -rf " .. output_dir)
  local cmd = string.format(
    "emmylua_doc_cli --output-format markdown --output %s %s 2>/dev/null",
    output_dir,
    input_dir
  )
  local ok = os.execute(cmd)
  return ok and true or false
end

---@param path string
---@return string
local function read_file(path)
  local f = io.open(path, "r")
  if not f then return "" end
  local content = f:read("*a")
  f:close()
  return content
end

---@param text string
---@return string
local function clean_markdown(text)
  text = text:gsub("\n\n\n\n\n*", "\n\n")
  text = text:gsub("[ \t]+\n", "\n")
  text = text:gsub("^%s+", "")
  text = text:gsub("%s+$", "")
  return text
end

---@param text string
---@return string
local function bump_headings(text)
  local lines = {}
  for line in text:gmatch("([^\n]*)\n?") do
    if line:find("^#+ ") then
      line = "#" .. line
    end
    table.insert(lines, line)
  end
  return table.concat(lines, "\n")
end

---@param text string
---@return string
local function escape_mdx(text)
  local in_fence = false
  local lines = {}
  for line in text:gmatch("([^\n]*)\n?") do
    if line:find("^```") then
      in_fence = not in_fence
    elseif not in_fence then
      local spans = {}
      local n = 0
      line = line:gsub("`[^`]*`", function(span)
        n = n + 1
        spans[n] = span
        return "\x00" .. n .. "\x00"
      end)
      line = line:gsub("<", "&lt;")
      line = line:gsub(">", "&gt;")
      line = line:gsub("{", "&#123;")
      line = line:gsub("}", "&#125;")
      line = line:gsub("\x00(%d+)\x00", function(id)
        return spans[tonumber(id)]
      end)
    end
    table.insert(lines, line)
  end
  return table.concat(lines, "\n")
end

---@param output string
---@param version string
local function write_markdown(output, version)
  local tmp_dir = "/tmp/lux-lua-docs-gen"
  local input_dir = "result-lua/share/lux-lua/jit"
  local types_dir = tmp_dir .. "/docs/types"

  if not run_emmylua_doc_cli(input_dir, tmp_dir) then
    io.stderr:write("Failed to run emmylua_doc_cli. Is it available?\n")
    os.exit(1)
    return
  end

  local pipe = io.popen("ls " .. types_dir .. "/*.md 2>/dev/null", "r")
  if not pipe then
    io.stderr:write("No type documentation files generated.\n")
    os.exit(1)
    return
  end

  local type_files = {}
  for file in pipe:lines() do
    table.insert(type_files, file)
  end
  pipe:close()
  table.sort(type_files, function(a, b)
    local a_is_lux = a:match("LuxModule%.md$") ~= nil
    local b_is_lux = b:match("LuxModule%.md$") ~= nil
    if a_is_lux and not b_is_lux then return true end
    if b_is_lux and not a_is_lux then return false end
    return a < b
  end)

  local out = assert(io.open(output, "w"), "Failed to open output file: " .. output)

  out:write([[
---
id: lua-api
title: Lua API reference
---

<!-- This file is auto-generated from the lux-luajit type definitions. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-lua-api-reference.lua -->

]])

  out:write("# Lua API reference (" .. version .. ")\n\n")

  out:write([[
The entry point to the Lua API is the [`LuxModule`](#class-luxmodule), returned by `require("lux")`.
It exposes sub-modules for configuration, operations, projects, and workspaces:

- `lux.config`: [`ConfigModule`](#class-configmodule)
- `lux.operations`: [`OperationsModule`](#class-operationsmodule)
- `lux.project`: [`ProjectModule`](#class-projectmodule)
- `lux.workspace`: [`WorkspaceModule`](#class-workspacemodule)

]])

  for _, filepath in ipairs(type_files) do
    local content = read_file(filepath)
    if content ~= "" then
      content = clean_markdown(content)
      content = bump_headings(content)
      content = escape_mdx(content)
      out:write(content)
      out:write("\n\n")
    end
  end

  out:close()
  print("Generated: " .. output)
end

---@type string
local output = arg[1] or "docs/reference/lua-api.md"

if not build_lux_luajit() then
  io.stderr:write("Failed to build lux-luajit. Is nix available?\n")
  os.exit(1)
  return
end

local version = read_lux_version()
write_markdown(output, version)
