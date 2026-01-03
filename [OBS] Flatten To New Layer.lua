--[[
[OBS] Flatten To New Layer
By: Bryan Miller
License: MIT

An Aseprite script...
Flattens all selected layers into a new layer without modifying original layers.
Should work across multiple frames
]]

local dlg = Dialog("[OBS] Flatten to Layer")
local default_layer_name = "Flattened"

function _flatten_layer_group(cel, glayers, frame_id, only_visible, only_selected)
    local spr = cel.sprite
    
    for _, layer in ipairs(glayers) do
        local skip = layer.isTilemap or (only_visible and not layer.isVisible)
        if cel.layer ~= layer and not skip then
            if layer.isGroup then
                _flatten_layer_group(cel, layer.layers, frame_id, only_visible, only_selected)
            else
                local lcel = layer:cel(frame_id)
                if lcel ~= nil then
                    cel.image:drawImage(lcel.image, lcel.bounds.origin)
                end
            end
        end
    end
end

function flatten_to_layer(layer_name, only_visible, only_selected)
    local spr = app.sprite
    if spr == nil then
        app.alert("Failed to find active sprite.")
        return
    end
    
    local frame_count = #spr.frames
    local nlayer = spr:newLayer()
    nlayer.name = layer_name
    --nlayer.stackIndex = 1
    
    for fid = 1, frame_count do
        local cel = spr:newCel(nlayer, fid)
        if cel ~= nil then
            _flatten_layer_group(cel, spr.layers, fid, only_visible, only_selected)
        end
    end
end


dlg:entry{
    id="layer_name",
    label = "New Layer Name:",
    text = default_layer_name
}

dlg:separator{text="Limit Layers To..."}

dlg:check{
    id="only_visible",
    label="Visible"
}

dlg:separator()

dlg:button{
    text="Generate",
    onclick = function()
        if #dlg.data.layer_name <= 0 then
            app.alert("Layer name required.")
            dlg:modify{id="layer_name", text=default_layer_name}
        else
            flatten_to_layer(dlg.data.layer_name, dlg.data.only_visible, false)
            dlg:close()
        end
    end
}

dlg:show()



