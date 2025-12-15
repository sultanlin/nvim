LAZY_PLUGIN_SPEC = {}

function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
	-- Load the module containing the config function
	local pluginModule = require(item)
	-- require(item).config()
	-- testing

	-- Call the config function if it exists
	if pluginModule.config and type(pluginModule.config) == "function" then
		pluginModule.config()
	end
end
