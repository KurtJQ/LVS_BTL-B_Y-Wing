AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua ")
include("shared.lua")

ENT.SpawnNormalOffset = 100

function ENT:OnSpawn( PObj )
    PObj:SetMass( 1000 )

    self:AddDriverSeat( Vector(305 ,0 , 60), Angle(0,-90 ,0) )

    local Pod = self:AddPassengerSeat( Vector(255.72, 0, 85), Angle(0, -90, 0))

    self:SetTailGunnerSeat( Pod )

    self:AddEngine( Vector(-580,239.94,59.39) )
    self:AddEngine( Vector(-580,-239.94,59.39) )
    self:AddEngineSound( Vector(-620.53,239.94,59.39) )
    self:AddEngineSound( Vector(-620.53,-239.94,59.39) )

    self.PrimarySND = self:AddSoundEmitter( Vector(513.2, 0, 45.66), "vanilla/ywing/vanilla_ywing_wep2.wav", "vanilla/ywing/vanilla_ywing_wep2.wav")
    self.PrimarySND:SetSoundLevel(110)

    self.GunnerSND = self:AddSoundEmitter( Vector(255.72, 0, 99.32), "vanilla/ywing/fire_gunner.mp3", "vanilla/ywing/fire_gunner.mp3")
    self.GunnerSND:SetSoundLevel(110)
end

function ENT:OnEngineActiveChanged( Active )
    if Active then
        self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/start.wav" )
    else
        self:EmitSound( "lvs/vehicles/naboo_n1_starfighter/stop.wav" )
    end
end