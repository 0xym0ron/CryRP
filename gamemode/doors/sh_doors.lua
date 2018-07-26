local doors = { // thanks again DarkRP
	["func_door"] = true,
	["func_door_rotating"] = true,
	["prop_door_rotating"] = true,
	["func_movelinear"] = true,
	["prop_dynamic"] = true
}

--[[---------------------------------------------------------
	entity:isDoor()
-----------------------------------------------------------]]

function meta.Entity:isDoor()

	if !IsValid( self ) then return false end

	local class = self:GetClass()

	if doors[class] then 
	
		return true
		
	end
	
	return false
	
end