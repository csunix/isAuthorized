return function(user: Player, permissionType: string)
	if tonumber(permissionType) then
		if user.UserId == tonumber(permissionType) then
			return true
		end
	else
		if user.Name == permissionType then
			return true
		end
	end
	
	return false
end
