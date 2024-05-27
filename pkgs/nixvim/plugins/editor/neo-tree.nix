{
  plugins.neo-tree = {
    enable = true;
    # addBlankLineAtTop = true;
    window.mappings."<left>".__raw = ''
      function(state)
        local node = state.tree:get_node()
        if node.type == "directory" and node:is_expanded() then
          require("neo-tree.sources.filesystem").toggle_directory(state, node)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end
    '';
    window.mappings."<right>".__raw = ''
      function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          if not node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          elseif node:has_children() then
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else
          if require("neo-tree.sources.common.preview").is_active() then
            print('preview is active')
          else
            print('preview is not active')
          end
          require("neo-tree.sources.common.preview").show(state)
        end
      end
    '';
    # window.mappings."<right>" = "open";
    window.mappings."s" = "";
    window.mappings."<space>" = "";
    window.mappings."<C-b>" = "";
    # window.mappingOptions.nowait = false;
  };
  keymaps = [{
    mode = [ "n" "v" ];
    key = "<C-b>";
    # key = "<leader>e";
    action = ''
      function()
        require("neo-tree.command").execute({ toggle = true })
      end
    '';
    lua = true;
    options = { desc = "Toggle Neo-Tree"; };
  }];
}
