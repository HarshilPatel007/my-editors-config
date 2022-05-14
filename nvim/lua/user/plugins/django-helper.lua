local ts_utils = require('nvim-treesitter.ts_utils')
local ts_locals = require('nvim-treesitter.locals')


local function get_cls_node()
    local current_node = ts_utils.get_node_at_cursor()
    local scope = ts_locals.get_scope_tree(current_node, 0)
    local cls_node = nil

    for _, node in ipairs(scope) do
        if node:type() == 'class_definition' then
            cls_node = node
        end
    end

    return cls_node
end


function GetModelCls()
    local cls_node = get_cls_node()
    local query = vim.treesitter.query.parse_query('python',[[ 
        (class_definition
            name: (identifier) @cls_name
        ) @cap_parent
    ]])

    local tbl = {}
    for _, matches, _ in query:iter_matches(cls_node, 0) do
        local get_model_cls = vim.treesitter.query.get_node_text(matches[1], 0)
        table.insert(tbl, get_model_cls)
    end
    vim.cmd(string.format('let @+ = "%s"', table.concat(tbl, ",")))
end


function GetModelFields()
    local cls_node = get_cls_node()
    local query = vim.treesitter.query.parse_query('python',[[ 
        (assignment
            left: (identifier) @model.fields
        ) @cap_parent
    ]])

    local tbl = {}
    for _,matches, _ in query:iter_matches(cls_node, 0) do -- id, matches, metadata
        local get_fields = vim.treesitter.query.get_node_text(matches[1], 0)
        table.insert(tbl, get_fields)
    end
    vim.cmd(string.format('let @+ = "%s"', table.concat(tbl, ",")))
end

GetModelFields()
