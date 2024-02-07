M = {}

M.plugins_path = vim.fn.stdpath("config") .. "/plugins"

local function get_directory_files(directory)
  local files = {}
  local p = io.popen('find "' .. directory .. '" -type f')
  if p then
    for file in p:lines() do
      if file:match("%.lua$") then -- Filter for Lua files
        table.insert(files, file)
      end
    end
    p:close()
  end
  return files
end

local function convert_path_to_module(path)
  local module_path = path:match(".*/lua/(plugins/.*)") or path:match(".*/(plugins/.*)")
  local module_name = module_path:gsub("%.lua$", ""):gsub("/", ".")
  return module_name
end

function M.load()
  local files = M.get_plugins()

  local has_lazy, plg = pcall(require, "lazy")
  if not has_lazy then
    print("no lazy")
    return
  end

  local plugins = {}

  -- Load plugin files
  local loaded_plugins = {}
  local test_plugin_files = get_directory_files(base_plugin_path)
  for _, file in ipairs(test_plugin_files) do
    local plugin_file = convert_path_to_module(file)
    if plugin_file ~= "plugins.init" then
      local has_plugin, plugin = pcall(require, plugin_file)
      if has_plugin and type(plugin) == "table" and not plugin["ignore"] then
        loaded_plugins[plugin_file] = plugin
      end
    end
  end

  -- Add plugins to the list
  for _, loaded_plugin in pairs(loaded_plugins) do
    if loaded_plugin and loaded_plugin.lazy then
      local plg_data = loaded_plugin.lazy()
      if plg_data then
        vim.list_extend(plugins, plg_data)
      end
    end
  end

  plg.setup(plugins, extra_opts)

  -- run settings for plugins
  for _, loaded_plugin in pairs(loaded_plugins) do
    if loaded_plugin and loaded_plugin.setup then
      loaded_plugin.setup()
    end
  end

























  -- for _, plugin in ipairs(files) do
  --   local plugin_name = plugin:match("([^/]+)$")

  --   local path = vim.fn.stdpath('config') .. '/plugins/' .. plugin_name
  --   local chunk, errorMsg = loadfile(path)

  --   if chunk then
  --     local success, plugin_module = pcall(chunk)

  --     if success then
  --       plugin_name = plugin_name:gsub(".lua", "")
  --       vim.list_extend(lvim.plugins, plugin_module.lazy())

  --       local after_functions = { "config", "init", "setup", "load" }

  --       for _, func in ipairs(after_functions) do
  --         if plugin_module[func] and type(plugin_module[func]) == 'function' then
  --           lvim[func](plugin_module[func]())
  --         end
  --       end
  --     else
  --       print("Error loading plugin: " .. plugin_name .. "\n" .. plugin_module)
  --     end
  --   else
  --     print("Error loading plugin: " .. plugin_name .. "\n" .. errorMsg)
  --   end
  -- end
end

return M
