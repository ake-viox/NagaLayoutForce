local addon_name, a = ...

local db_version_required = 1
local debug = false
local modified = {}

local _

local function dprint(...)
	if debug then print(addon_name, 'DEBUG:', ...) end
end

local defaults = {
	db_version = db_version_required,
	method = 1,
	enable = { y = 'all', x = 'none' },
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

local map = {
	[1] = 'MainMenuBar',
	[2] = 'MultiBarBottomLeft',
	[3] = 'MultiBarBottomRight',
	[4] = 'MultiBarRight',
	[5] = 'MultiBarLeft',
	[6] = 'MultiBar5',
	[7] = 'MultiBar6',
	[8] = 'MultiBar7',
}

local reverse_growth = {
	[1] = function(axis, bar)
		if axis == 'y' then
			_G[bar].addButtonsToTop = not _G[bar].addButtonsToTop
		else
			_G[bar].addButtonsToRight = not _G[bar].addButtonsToRight
		end
	end,
	[2] = function(axis, bar)
		if axis == 'y' then
			hooksecurefunc(_G[bar], 'UpdateGridLayout', function(self)
				self.addButtonsToTop = not self.addButtonsToTop
			end)
		else
			hooksecurefunc(_G[bar], 'UpdateGridLayout', function(self)
				self.addButtonsToRight = not self.addButtonsToRight
			end)
		end
	end,
}

local function modify_bars()
	for axis, enableaxis in pairs(a.db.enable) do
		if enableaxis ~= 'none' then
			for bar, enablebar in pairs(a.db[axis]) do
				if enableaxis == 'all' or enablebar then
					bar = map[bar]
					reverse_growth[a.db.method](axis, bar)
					modified[bar] = true
				end
			end
		end
	end
end


local function update_grid_layouts()
	local c = 0
	for bar, _ in pairs(modified) do
		_G[bar]:UpdateGridLayout()
		c = c + 1
	end
	wipe(modified)
	dprint('updated', c, 'modified action bars(s).')
end


local ef = CreateFrame 'Frame'
ef:RegisterEvent 'ADDON_LOADED'
ef:RegisterEvent 'PLAYER_LOGIN'

ef:SetScript('OnEvent', function(self, event, ...)
	if event == 'ADDON_LOADED' then
		self:UnregisterEvent 'ADDON_LOADED'
		if not ABBGD_db or ABBGD_db.db_version ~= db_version_required then
			ABBGD_db = defaults
		end
		a.db = ABBGD_db
		if a.db.method == 2 then
			modify_bars()
		end
	else
		if a.db.method == 1 then
			modify_bars()
		end
		update_grid_layouts()
	end
end)
