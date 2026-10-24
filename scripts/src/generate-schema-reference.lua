#!/usr/bin/env -S nix develop .# -c lua

---@param cmd string
---@return string?
local function capture(cmd)
  local pipe = io.popen(cmd .. " 2>/dev/null", "r")
  if not pipe then return nil end
  local content = pipe:read("*a")
  pipe:close()
  return content
end

---@param kind string
---@param format string
---@return string?
local function schema(kind, format)
  return capture(
    string.format("lx util schema --kind %s --output-format %s", kind, format)
  )
end

---@param text string
---@return string
local function escape_mdx(text)
  local spans = {}
  local count = 0
  text = text:gsub("`[^`]*`", function(span)
    count = count + 1
    spans[count] = span
    return "\0" .. count .. "\0"
  end)
  text = text:gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("{", "&#123;"):gsub("}", "&#125;")
  return (text:gsub("\0(%d+)\0", function(index)
    return spans[tonumber(index)]
  end))
end

---@param body string
---@param see_also string
---@return string
local function insert_see_also(body, see_also)
  local heading, rest = body:match("^(# [^\n]+\n\n)(.*)$")
  return (heading or "") .. see_also .. "\n\n" .. (rest or body)
end

---@param id string
---@param title string
---@param body string
---@param version string
---@return string
local function render_page(id, title, body, version)
  return string.format(
    [[---
id: %s
title: %s
---

<!-- This file is auto-generated from the Lux schema. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-schema-reference.lua -->
<!-- Generated from %s -->

%s
]],
    id,
    title,
    version,
    escape_mdx(body)
  )
end

---@param path string
---@param content string
local function write_file(path, content)
  local file = assert(io.open(path, "w"), "Failed to open output file: " .. path)
  file:write(content)
  file:close()
end

---@param version string
local function generate_markdown_pages(version)
  local pages = {
    {
      kind = "lux-toml",
      id = "lux-toml",
      title = "lux.toml reference",
      output = "docs/reference/lux-toml.md",
      see_also = "Download the [JSON Schema](/schemas/lux-toml.schema.json).",
    },
    {
      kind = "config",
      id = "config",
      title = "config.toml reference",
      output = "docs/reference/config.md",
      see_also = "Download the [JSON Schema](/schemas/config.schema.json).",
    },
  }
  for _, page in ipairs(pages) do
    local body = schema(page.kind, "text")
    assert(body and body ~= "", "Failed to generate schema for " .. page.kind)
    write_file(
      page.output,
      render_page(page.id, page.title, insert_see_also(body, page.see_also), version)
    )
    print("Generated: " .. page.output)
  end
end

local function generate_json_schemas()
  local schemas = {
    { kind = "lux-toml", output = "static/schemas/lux-toml.schema.json" },
    { kind = "config", output = "static/schemas/config.schema.json" },
  }
  for _, item in ipairs(schemas) do
    local body = schema(item.kind, "json")
    assert(body and body ~= "", "Failed to generate schema for " .. item.kind)
    write_file(item.output, body)
    print("Generated: " .. item.output)
  end
end

local version = (capture("lx --version") or "unknown"):gsub("%s+$", "")
generate_markdown_pages(version)
generate_json_schemas()
