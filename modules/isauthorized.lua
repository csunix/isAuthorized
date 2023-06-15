local hasPermission = game:GetService("ReplicatedStorage"):WaitForChild("Permissions")
local permissions = {}

local utilityModule = require(script.Parent.UtilModule)
local array = utilityModule("Array")

local Cache = game:GetService("ReplicatedStorage"):WaitForChild("Cache")
local permsTypes = Cache:FindFirstChild("Permissions")

function permissions.has(user: Player, metaTag: { string })
	if typeof(metaTag) == "string" then
		metaTag = { metaTag }
	elseif metaTag == true then
		return true
	end
	
	if not user then
		error("Impossible user.")
	end
	
	local hasPermissionBool = false
	local requireAll = metaTag and (metaTag.requireAll)
	
	for _, tag in pairs(metaTag) do
		if typeof(tag) == "string" then
			local permissionType = array(tag:split(":")):findFirstElement(permsTypes, "ModuleScript")
			if permissionType then
				permissionType = require(permissionType)
				local permissionBit = permissionType(user, tag:split(":")[#tag:split(":")])
				if requireAll then
					hasPermissionBool = permissionBit
				elseif permissionBit then
					return true
				end
			end
		end
	end
end

return permissions.has
