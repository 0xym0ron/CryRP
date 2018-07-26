AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local models = {
	["Large"] = {	
		"models/props/cs_assault/Money.mdl",		
	},
	["Small"] = {
		"models/props/cs_assault/Money.mdl",			
	}
}

function ENT:Initialize()

	self.Amount = self:GetNWInt( "Amount" ) or 0
		
	if self.Amount < 1000 then
		
		self:SetModel( table.Random( models.Small ) )
		
	else
		
		self:SetModel( table.Random( models.Large ) )
		
	end
	
	self:PhysicsInit( SOLID_VPHYSICS )
	
	self:SetMoveType( MOVETYPE_VPHYSICS )
	
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self:GetPhysicsObject()
	
	if IsValid( phys ) then
		
		phys:Wake()
		
	end
	
	self.pickedUp = false

end

function ENT:Use( activator, caller )

	if !IsValid( activator ) then return end
	
	if self.pickedUp then return end
	
	if activator.nextPickup != nil && CurTime() < activator.nextPickup then return end
	
	activator:addMoney( self.Amount )
	
	activator:Notify( "Picked up $" .. string.Comma( self.Amount ), 0, 2 )
	
	self.pickedUp = true
	
	activator.nextPickup = CurTime() + 0.5
	
	self:Remove()

end