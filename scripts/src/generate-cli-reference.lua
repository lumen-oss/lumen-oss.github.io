#!/usr/bin/env -S nix develop .# -c lua

---@class Option
---@field flag string
---@field description string

---@class Subcommand
---@field name string
---@field description string

---@class SubcommandHelp
---@field description string
---@field usage string
---@field arguments string
---@field subcommands Subcommand[]
---@field options Option[]

---@return string
local function usage()
  return [[Usage: scripts/src/generate-cli-reference.lua]]
end

---@return boolean
local function build_lux_cli()
  local ok = os.execute("nix build .#lux-cli 2>/dev/null")
  return ok and true or false
end

---@return string
local function read_lux_version()
  local pipe = io.popen("result/bin/lx --version 2>/dev/null", "r")
  if not pipe then return "unknown" end
  local version = pipe:read("*l")
  pipe:close()
  return version or "unknown"
end

---@param manpage string
---@return string
local function read_rendered_manpage(manpage)
  local pipe = io.popen(
    "gunzip -c " .. manpage .. " 2>/dev/null | groff -man -Tutf8 2>/dev/null | sed 's/\\x1b\\[[0-9;]*m//g'",
    "r"
  )
  if not pipe then
    io.stderr:write(usage() .. "\nFailed to read man page. Ensure groff is available.\n")
    os.exit(1)
    return ""
  end
  local content = pipe:read("*a")
  pipe:close()
  return content
end

---@param text string
---@return string
local function strip_groff_hyphens(text)
  text = text:gsub("\194\173", "")
  text = text:gsub("\226\128\144", "")
  text = text:gsub("\226\128\145", "")
  return text
end

---@param text string
---@return string[]
local function split_lines(text)
  if text == "" then return {} end
  local lines = {}
  for line in text:gmatch("([^\n]*)\n?") do
    table.insert(lines, line)
  end
  if #lines > 1 and lines[#lines] == "" then
    table.remove(lines)
  end
  return lines
end

---@param line string?
---@return string?
local function trimmed(line)
  if not line then return nil end
  return line:match("^%s*(.-)%s*$")
end

---@param lines string[]
---@return integer
local function find_man_section(lines, header)
  for i, line in ipairs(lines) do
    local t = trimmed(line)
    if t == header then
      return i
    end
  end
  return 0
end

---@param lines string[]
---@param start_line integer
---@return string[]
local function collect_man_section(lines, start_line)
  local result = {}
  for i = start_line, #lines do
    local line = lines[i]
    if not line then break end
    local t = trimmed(line)
    if t and t ~= "" and t:match("^[A-Z][A-Z ]*$") then
      break
    end
    if t and t ~= "" then
      table.insert(result, line)
    end
  end
  return result
end

---@param line string?
---@return boolean
local function is_flag_line(line)
  if not line then return false end
  return line:find("^     +%-") ~= nil
end

---@param line string?
---@return boolean
local function is_continuation_line(line)
  if not line then return false end
  return line:find("^           +") ~= nil
end

---@param lines string[]
---@return Option[]
local function parse_man_options(lines)
  ---@type Option[]
  local options = {}
  for _, line in ipairs(lines) do
    if is_flag_line(line) then
      local text = line:match("^%s+(.*)$") or ""
      local flag_part, desc = text:match("^(.-)  +(.*)$")
      if not flag_part then
        flag_part = text
        desc = ""
      end
      table.insert(options, { flag = flag_part, description = desc or "" })
    elseif #options > 0 and is_continuation_line(line) then
      local cont = line:match("^%s+(.*)$") or ""
      options[#options].description = options[#options].description .. " " .. cont
    end
  end
  return options
end

---@param lines string[]
---@return Subcommand[]
local function parse_subcommands_from_man(lines)
  local subcommands = {}
  for _, line in ipairs(lines) do
    local name = line:match("^%s+lux%-cli%-(%w[%w%-]-)%(1%)%s*$")
    if name then
      table.insert(subcommands, { name = name, description = "" })
    elseif #subcommands > 0 then
      local cont = line:match("^%s+(.*)$")
      if cont and cont ~= "" and not cont:match("^lux%-cli%-") then
        subcommands[#subcommands].description = subcommands[#subcommands].description .. " " .. cont
      end
    end
  end
  return subcommands
end

---@param str string
---@return string
local function collapse_groff_glyphs(str)
  str = str:gsub("{n}", " ")
  str = str:gsub("  +", " ")
  str = str:gsub("([%a])%- +([%a])", "%1%2")
  str = str:gsub("^%s+", "")
  str = str:gsub("%s+$", "")
  return str
end

---@param str string
---@return string
local function escape_mdx(str)
  return (str:gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("{", "&#123;"):gsub("}", "&#125;"))
end

---@param str string
---@return string
local function format_escaped(str)
  str = str:gsub("%[default: ([^%]]+)%]", function(val)
    return "[default: `" .. val .. "`]"
  end)
  str = str:gsub("%[possible values: ([^%]]+)%]", function(vals)
    return "[possible values: `" .. vals .. "`]"
  end)
  return str
end

---@param lines string[]
---@param start_line integer
---@param section_name string
---@return string[]
local function collect_section_lines(lines, start_line, section_name)
  local result = {}
  local in_section = false
  local header_pattern = "^" .. section_name .. ":$"
  local next_header_pattern = "^%u[%u%l ]-:$"
  for i = start_line, #lines do
    local line = lines[i]
    if not line then break end
    if not in_section then
      if line:match(header_pattern) then
        in_section = true
      end
    elseif line:match(next_header_pattern) then
      break
    else
      table.insert(result, line)
    end
  end
  return result
end

---@param lines string[]
---@return Subcommand[]
local function parse_item_list(lines)
  local items = {}
  for _, line in ipairs(lines) do
    if line == "" then
    elseif line:match("^%s+([%w%-]+)  +") then
      local name, desc = line:match("^%s+([%w%-]+)  +(.*)$")
      if name then
        table.insert(items, { name = name, description = (desc or ""):gsub("^%s+", "") })
      end
    elseif #items > 0 then
      local cont = line:match("^%s+(.*)$")
      if cont and cont ~= "" then
        items[#items].description = items[#items].description .. " " .. cont
      end
    end
  end
  return items
end

---@param lines string[]
---@return Option[]
local function parse_option_list(lines)
  local options = {}
  for _, line in ipairs(lines) do
    if line == "" then
    elseif line:match("^%s+%-") then
      local indent = line:match("^(%s+)")
      if indent and #indent <= 6 then
        local stripped = line:match("^%s+(.*)$")
        if stripped then
          local flag_part, desc = stripped:match("^(.-)  +(.*)$")
          if not flag_part then
            flag_part = stripped
            desc = ""
          end
          table.insert(options, {
            flag = flag_part,
            description = (desc or ""):gsub("^%s+", ""):gsub("%s+$", "")
          })
        end
      elseif #options > 0 then
        local cont = line:match("^%s+(.*)$")
        if cont then
          options[#options].description = options[#options].description .. " " .. cont
        end
      end
    elseif #options > 0 then
      local cont = line:match("^%s+(.*)$")
      if cont and cont ~= "" then
        options[#options].description = options[#options].description .. " " .. cont
      end
    end
  end
  return options
end

---@param name string
---@param fallback_desc string
---@return SubcommandHelp
local function get_subcommand_help(name, fallback_desc)
  local cmd
  if name == "help" then
    cmd = "result/bin/lx help help"
  else
    cmd = "result/bin/lx " .. name .. " --help"
  end
  local pipe = io.popen(cmd .. " 2>/dev/null", "r")
  if not pipe then
    return { description = fallback_desc, usage = "", arguments = "", subcommands = {}, options = {} }
  end
  local content = pipe:read("*a")
  pipe:close()
  if not content or content == "" then
    return { description = fallback_desc, usage = "", arguments = "", subcommands = {}, options = {} }
  end

  local lines = split_lines(content)
  local usage_line = ""
  local description = ""
  local desc_end = 0

  for i, line in ipairs(lines) do
    if line:find("^Usage: ") then
      usage_line = line
      desc_end = i - 1
      break
    end
  end

  if desc_end > 0 then
    local desc_parts = {}
    for i = 1, desc_end do
      if lines[i] and lines[i] ~= "" then
        table.insert(desc_parts, lines[i])
      end
    end
    description = table.concat(desc_parts, "\n")
  end

  if description == "" then
    description = fallback_desc
  end

  local after_usage = desc_end + 2
  if after_usage > #lines then
    after_usage = #lines
  end

  local arg_lines = collect_section_lines(lines, after_usage, "Arguments")
  local cmd_lines = collect_section_lines(lines, after_usage, "Commands")
  local opt_lines = collect_section_lines(lines, after_usage, "Options")

  local arguments = table.concat(arg_lines, "\n")
  local subcommands = parse_item_list(cmd_lines)
  local options = parse_option_list(opt_lines)

  return {
    description = description,
    usage = usage_line,
    arguments = arguments,
    subcommands = subcommands,
    options = options
  }
end

---@param output string
---@param global_options Option[]
---@param subcommand_names string[]
---@param version string
local function write_markdown(output, global_options, subcommand_names, version)
  local out = assert(io.open(output, "w"), "Failed to open output file: " .. output)

  out:write([[
---
id: cli
title: CLI reference
---

<!-- This file is auto-generated from the man page. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-cli-reference.lua -->

]])
  out:write("# CLI reference (" .. version .. ")\n\n")

  out:write("## Global options\n\n")
  for _, opt in ipairs(global_options) do
    local desc = collapse_groff_glyphs(opt.description)
    if desc ~= "" then
      out:write("- `" .. collapse_groff_glyphs(opt.flag) .. "` — " .. format_escaped(escape_mdx(desc)) .. "\n")
    else
      out:write("- `" .. collapse_groff_glyphs(opt.flag) .. "`\n")
    end
  end

  out:write("\n## Subcommands\n\n")
  for _, name in ipairs(subcommand_names) do
    local help = get_subcommand_help(name, "")
    out:write("### `lx " .. name .. "`\n\n")

    if help.description and help.description ~= "" then
      out:write(format_escaped(escape_mdx(help.description)) .. "\n\n")
    end

    if help.usage and help.usage ~= "" then
      local usage_text = help.usage:match("Usage: (.+)")
      if usage_text then
        out:write("**Usage:** `" .. usage_text .. "`\n\n")
      end
    end

    if help.arguments and help.arguments ~= "" then
      out:write("#### Arguments\n\n")
      out:write("```\n" .. help.arguments .. "\n```\n\n")
    end

    if #help.subcommands > 0 then
      out:write("#### Subcommands\n\n")
      for _, sub in ipairs(help.subcommands) do
        local desc = sub.description:gsub("^%s+", ""):gsub("%s+$", "")
        if desc ~= "" then
          out:write("- `" .. sub.name .. "` — " .. format_escaped(escape_mdx(desc)) .. "\n")
        else
          out:write("- `" .. sub.name .. "`\n")
        end
      end
      out:write("\n")
    end

    if #help.options > 0 then
      out:write("#### Options\n\n")
      for _, opt in ipairs(help.options) do
        local desc = opt.description:gsub("^%s+", ""):gsub("%s+$", "")
        if desc ~= "" then
          out:write("- `" .. opt.flag .. "` — " .. format_escaped(escape_mdx(desc)) .. "\n")
        else
          out:write("- `" .. opt.flag .. "`\n")
        end
      end
      out:write("\n")
    end
  end

  out:close()
  print("Generated: " .. output)
end

---@type string
local main_manpage = arg[1] or "result/share/man/man1/lux-cli.1.gz"
---@type string
local output = arg[2] or "docs/reference/cli.md"

if not build_lux_cli() then
  io.stderr:write("Failed to build lux-cli. Is nix available?\n")
  os.exit(1)
  return
end

local rendered = read_rendered_manpage(main_manpage)
rendered = strip_groff_hyphens(rendered)
local lines = split_lines(rendered)
local opt_start = find_man_section(lines, "OPTIONS")
local opt_lines = {}
if opt_start > 0 then
  opt_lines = collect_man_section(lines, opt_start + 1)
end
local man_options = parse_man_options(opt_lines)
local sub_start = find_man_section(lines, "SUBCOMMANDS")
local sub_lines = {}
if sub_start > 0 then
  sub_lines = collect_man_section(lines, sub_start + 1)
end
local subcommands = parse_subcommands_from_man(sub_lines)
-- Fallback: derive names from names list if man page parsing fails
local subcommand_names = {}
for _, sc in ipairs(subcommands) do
  table.insert(subcommand_names, sc.name)
end
if #subcommand_names == 0 then
  local ok, handle = pcall(io.popen, "ls result/share/man/man1/lux-cli-*.1.gz 2>/dev/null", "r")
  if ok and handle then
    local content = handle:read("*a")
    handle:close()
    if content and content ~= "" then
      for file in content:gmatch("[^\n]+") do
        local name = file:match("lux%-cli%-(.+)%.1%.gz$")
        if name then table.insert(subcommand_names, name) end
      end
      table.sort(subcommand_names)
    end
  end
end
local version = read_lux_version()
write_markdown(output, man_options, subcommand_names, version)
