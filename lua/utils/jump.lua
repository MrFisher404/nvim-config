local ts_utils = require("nvim-treesitter.ts_utils")


local elements = {
	jsx = { 'jsx_element', 'jsx_self_closing_element', 'jsx_fragment' },
	html = { 'element' },
	cs = {'element'},
}
local tag_names = { jsx = { 'identifier' }, html = { 'tag_name' } }

local function coerce_ft()
	local ft = vim.bo.filetype
	if ft == 'javascriptreact' or ft == 'typescriptreact' then return 'jsx' end
	if ft == 'html' or ft == 'vue' then return 'html' end
	if ft == 'cs' then return 'cs' end
end

local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local get_master_node = function()
	local node = ts_utils.get_node_at_cursor()
	if node == nil then error("No Treesitter parser found.") end
	return node
end

-- Gets enclosing HTML/JSX Element
local get_enclosing_element = function(ft, node)
	if (node == nil) then return end
	local parent = node:parent()
	if (parent == nil) then return end

	while not has_value(elements[ft], parent:type()) do
		parent = parent:parent()
		if (parent == nil) then return nil end
	end
	return parent
end



local function is_name_node(ft, type)
	return has_value(tag_names[ft], type)
end

local get_parent = function(node)
	if node == nil then return end
	return node:parent()
end

local get_child = function(ft, node)
	if node == nil then return end
	for child in node:iter_children() do
		if has_value(elements[ft], child:type()) then
			return child
		end
	end
end

-- Gets tag name to jump to
local get_tag_name_from_element
get_tag_name_from_element = function(ft, node)
	if (node == nil) then return end
	for child in node:iter_children() do
		if (child == nil) then
			error("That node has no children")
			return nil
		end
		if is_name_node(ft, child:type()) then
			return child
		end
		if child:child_count() ~= 0 then
			return get_tag_name_from_element(ft, child)
		else
		end
	end

	-- If node does not have children and is a valid top-level node
	if (node:type() == 'jsx_fragment') then return node end
end


local jumpChild = function()
	local ft = coerce_ft()
	local node = get_master_node()
  print(node)
	local element = get_enclosing_element(ft, node)
  print(element)
	local child = get_child(ft, element)
  print(child)
	local tag_name = get_tag_name_from_element(ft, child)
  print(tag_name)
	ts_utils.goto_node(tag_name)
end

return {
--	jumpParent = jumpParent,
--	jumpNextSibling = jumpNextSibling,
--	jumpPrevSibling = jumpPrevSibling,
	jumpChild = jumpChild
}
