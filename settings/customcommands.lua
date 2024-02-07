-- Custom commands
vim.cmd [=[command! AddJsonProperties execute "%s/public \\(.*\\) \\(.*\\);/@JsonProperty(\\\"\\2\\\")\\r\\tpublic \\1 \\2;/g"]=]
vim.cmd [=[command! FormatOnComma execute '%s/,/,\r/g']=]
vim.cmd [=[command! ConvertJsonPropertyToCamelCase %!python3 ~/.config/lvim/scripts/convert_to_camel_case.py]=]
vim.cmd [=[command! ConvertJsonPropertyToSnakeCase %!python3 ~/.config/lvim/scripts/convert_to_snake_case.py]=]
vim.cmd [=[command! ToJavaJson %!python3 ~/.config/lvim/scripts/convert_json_to_java_variable.py]=]
vim.cmd [=[command! AddApiProperties %!python3 ~/.config/lvim/scripts/add_api_properties.py]=]
vim.cmd [=[command! TransformToDto %!python3 ~/.config/lvim/scripts/transform_to_dto.py]=]

vim.cmd [[
  command! -nargs=0 NeoAut execute "normal :.!~/.config/lvim/scripts/set_neogen_author_info.py " . line('.')\<CR>
]]
