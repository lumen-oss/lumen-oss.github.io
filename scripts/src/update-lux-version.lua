#!/usr/bin/env -S nix develop .# -c lua

local DOCS_DIR = "docs"
local ACTION = "uses: lumen%-oss/gh%-actions%-lux@"

---@param path string
---@return string
local function read_file(path)
  local file = assert(io.open(path, "r"), "Failed to open file: " .. path)
  local content = file:read("*a")
  file:close()
  return content
end

---@param path string
---@param content string
local function write_file(path, content)
  local file = assert(io.open(path, "w"), "Failed to open file: " .. path)
  file:write(content)
  file:close()
end

---@return string
local function lux_version()
  local pipe = io.popen("lx --version 2>/dev/null", "r")
  local output = pipe:read("*a")
  pipe:close()
  local version = output:match("(%d+%.%d+%.%d+)")
  assert(version, "Could not determine Lux version from: " .. output)
  return version
end

---@param content string
---@param version string
---@return string, integer
local function update_version_references(content, version)
  local in_action = false
  local action_indent = 0
  local count = 0
  local lines = {}
  for line in content:gmatch("([^\n]*\n?)") do
    local updated = line
    local indent = #(updated:match("^(%s*)") or "")
    if updated:find(ACTION) then
      in_action = true
      action_indent = indent
    elseif in_action and updated:match("^%s*$") then
      in_action = false
    elseif in_action and indent <= action_indent and updated:match("^%s*%-") then
      in_action = false
    elseif in_action and updated:match("^%s*version:%s*%d") then
      updated = updated:gsub("%d+%.%d+%.%d+", version)
      in_action = false
      count = count + 1
    end
    table.insert(lines, updated)
  end
  return table.concat(lines), count
end

---@return string[]
local function markdown_files()
  local pipe = io.popen(
    "find " .. DOCS_DIR .. " -type f \\( -name '*.md' -o -name '*.mdx' \\) 2>/dev/null",
    "r"
  )
  local files = {}
  for path in pipe:lines() do
    table.insert(files, path)
  end
  pipe:close()
  return files
end

local version = lux_version()
local updated_files = 0
local references = 0
for _, path in ipairs(markdown_files()) do
  local content = read_file(path)
  local updated, count = update_version_references(content, version)
  if count > 0 then
    references = references + count
    if updated ~= content then
      write_file(path, updated)
      updated_files = updated_files + 1
      print("Updated " .. path .. " to " .. version)
    end
  end
end
assert(references > 0, "No Lux version references found")
if updated_files == 0 then
  print("Lux version references are up to date (" .. version .. ")")
end
