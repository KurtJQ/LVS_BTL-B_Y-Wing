AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "Proton Bomb"
ENT.Author = "KurtJQ"
ENT.Description = "LVS Proton Bomb"
ENT.Category = "[LVS]"

ENT.ExplosionEffect = "lvs_explosion"

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Active" )
end

if SERVER then
	function ENT:SetAttacker( ent ) self._attacker = ent end
	function ENT:GetAttacker() return self.attacker or NULL end

	function ENT:Initialize()
		self:SetModel( "models/props_phx/ww2bomb.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )

		self.DieTime = CurTime() + 30

		local PhysObj = self:GetPhysicsObject()

		PhysObj:SetMass( 1000 )
		PhysObj:EnableDrag( true )
		PhysObj:EnableGravity( false )

		self:PhysWake()
	end

	function ENT:Drop()
		local vehicle = self:GetParent()

		local PhysObj = self:GetPhysicsObject()

		if not IsValid( vehicle ) or not IsValid( PhysObj ) then return end

		self:SetParent( NULL )

		PhysObj:SetVelocityInstantaneous( vehicle:GetVelocity() )

		timer.Simple(0.1, function()
			if not IsValid( self ) or not IsValid( PhysObj ) then return end

			self:SetActive( true )
			PhysObj:EnableGravity( true )
		end )
	end

	function ENT:OnTakeDamage( dmginfo )
		self:Detonate()
	end

	function ENT:Think()
		local T = CurTime()

		self:NextThink( T + 0.5 )

		if self.DieTime < T then
			self:Detonate()
		end
	end

	function ENT:UpdateTransmitState()
		return TRANSMIT_ALWAYS
	end

	function ENT:PhysicsCollide( data, physobj )
		if data.Speed > 300 then
			self:Detonate()
		end
	end

	function ENT:Detonate()
		if self.IsDetonated then return end

		self.IsDetonated = true

		local Pos = self:GetPos()

		local effectdata = EffectData()
		effectdata:SetOrigin( Pos )
		util.Effect (self.ExplosionEffect, effectdata)

		local attacker = self:GetAttacker()

		util.BlastDamage( self, IsValid( attacker) and attacker or game.GetWorld(), Pos, 500, 250)

		SafeRemoveEntityDelayed( self, FrameTime() )
	end
end

function ENT:Draw()
	if not self:GetActive() then return end

	self:DrawModel()
end