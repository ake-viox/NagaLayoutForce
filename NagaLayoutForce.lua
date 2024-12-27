local addon_name, a = ...

local db_version_required = 1
local debug = false
local modified = {}

local function dprint(...)
    if debug then
        print(addon_name, "DEBUG:", ...)
    end
end

local defaults = {
    db_version = db_version_required,
    -- 1 = direct toggle, 2 = hooking
    -- We'll use 2 so it "hooks" each bar's UpdateGridLayout.
    method = 2,

    enable = { 
        y = "all",
        x = "none"
    },

    y = {
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [5] = false,
        [6] = false,
        [7] = false,
        [8] = false,
    },
    x = {
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [5] = false,
        [6] = false,
        [7] = false,
        [8] = false,
    },
}

-- Map bar indices to Blizzard bar frame names
local map = {
    [1] = "MainMenuBar",         -- Action Bar 1
    [2] = "MultiBarBottomLeft",  -- Action Bar 2
    [3] = "MultiBarBottomRight", -- Action Bar 3
    [4] = "MultiBarRight",       -- Action Bar 4
    [5] = "MultiBarLeft",        -- Action Bar 5
    [6] = "MultiBar5",           -- Action Bar 6
    [7] = "MultiBar6",           -- Action Bar 7
    [8] = "MultiBar7",           -- Action Bar 8
}

-- These two methods: 
-- Method 1 toggles once, 
-- Method 2 hooks and toggles on each UpdateGridLayout call.
local reverse_growth = {
    [1] = function(axis, bar)
        if axis == "y" then
            _G[bar].addButtonsToTop = not _G[bar].addButtonsToTop
        else
            _G[bar].addButtonsToRight = not _G[bar].addButtonsToRight
        end
    end,
    [2] = function(axis, bar)
        if axis == "y" then
            hooksecurefunc(_G[bar], "UpdateGridLayout", function(self)
                self.addButtonsToTop = not self.addButtonsToTop
            end)
        else
            hooksecurefunc(_G[bar], "UpdateGridLayout", function(self)
                self.addButtonsToRight = not self.addButtonsToRight
            end)
        end
    end,
}

local function modify_bars()
    for axis, enableaxis in pairs(a.db.enable) do
        if enableaxis ~= "none" then
            for barIndex, enablebar in pairs(a.db[axis]) do
                if enableaxis == "all" or enablebar then
                    local barName = map[barIndex]
                    reverse_growth[a.db.method](axis, barName)
                    modified[barName] = true
                end
            end
        end
    end
end

-- After toggling/hooking, we force the bars to recalc
local function update_grid_layouts()
    local c = 0
    for barName in pairs(modified) do
        if _G[barName] and _G[barName].UpdateGridLayout then
            _G[barName]:UpdateGridLayout()
            c = c + 1
        end
    end
    wipe(modified)
    dprint("updated", c, "modified action bar(s).")
end

-------------------------------------------------------------------------------
-- Main Event Frame
-------------------------------------------------------------------------------
local ef = CreateFrame("Frame")
ef:RegisterEvent("ADDON_LOADED")
ef:RegisterEvent("PLAYER_LOGIN")

ef:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        self:UnregisterEvent("ADDON_LOADED")
        if not ABBGD_db or ABBGD_db.db_version ~= db_version_required then
            ABBGD_db = defaults
        end
        a.db = ABBGD_db

        -- If hooking method=2, do the hooking right after addon load
        if a.db.method == 2 then
            modify_bars()
        end

    else
        -- On PLAYER_LOGIN, if we’re using method=1 (direct toggle), we do it here
        if a.db.method == 1 then
            modify_bars()
        end
        -- Finally, refresh the layouts for all bars
        update_grid_layouts()
    end
end)
