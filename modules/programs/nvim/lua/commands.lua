-- Package management ----------------------------------------------------------
-- :PackUpdate - Updates all plugins
-- :PackUpdate blink.cmp - Updates only one
-- :PackDelete oil.nvim - Removes a plugin
-- :PackClean - Removes installed plugins not present in vim.pack.add()

local function complete_packages(arg_lead)
	arg_lead = arg_lead or ""

	return vim.iter(vim.pack.get())
		:map(function(plugin)
			return plugin.spec.name
		end)
		:filter(function(name)
			return vim.startswith(name, arg_lead)
		end)
		:totable()
end

vim.api.nvim_create_user_command("PackUpdate", function(info)
	if #info.fargs ~= 0 then
		vim.pack.update(info.fargs, { force = info.bang })
	else
		local choice = vim.fn.confirm(
			"Do you want to update ALL packages?",
			"&Yes\n&No",
			2
		)

		if choice == 1 then
			vim.notify("Updating all packages...", vim.log.levels.INFO)
			vim.pack.update(nil, { force = info.bang })
		else
			vim.notify("Update cancelled.", vim.log.levels.WARN)
		end
	end
end, {
	desc = "Update vim.pack packages",
	nargs = "*",
	bang = true,
	complete = complete_packages,
})

vim.api.nvim_create_user_command("PackDelete", function(info)
	vim.pack.del(info.fargs, { force = info.bang })
end, {
	desc = "Delete vim.pack packages",
	nargs = "+",
	bang = true,
	complete = complete_packages,
})

vim.api.nvim_create_user_command("PackClean", function()
	local unused = {}

	for _, plugin in ipairs(vim.pack.get()) do
		if not plugin.active then
			table.insert(unused, plugin.spec.name)
		end
	end

	if #unused == 0 then
		vim.notify("No unused packages.", vim.log.levels.INFO)
		return
	end

	local choice = vim.fn.confirm(
		"Delete unused packages?",
		"&Yes\n&No",
		2
	)

	if choice == 1 then
		vim.pack.del(unused)
	end
end, {
	desc = "Delete inactive vim.pack packages",
})


