include("shared.lua")

ENT.EngineColor = Color( 255, 0, 0 , 255)
ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EnginePos = {
    Vector( -650,239.81,58.68 ),
    Vector( -650,-239.81,58.68 )
}

function ENT:OnSpawn()
    self:RegisterTrail( Vector(-637.74, -295.15, 60.08), 0, 20, 2, 1000, 150)
    self:RegisterTrail( Vector(-637.74, 295.15, 60.08), 0, 20, 2, 1000, 150)
end

function ENT:PostDraw()
    if not self:GetEngineActive() then return end

    cam.Start3D2D( self:LocalToWorld( Vector( 0, 0, 0 ) ), self:LocalToWorldAngles( Angle( 0, 0, 0 ) ), 1)
        draw.NoTexture()
        surface.SetDrawColor( 255, 255 , 255 , 255)
        surface.DrawTexturedRectRotated(-650, 239.81, 58.68, 6, 6, 6)
    cam.End3D2D()
end

function ENT:PostDrawTranslucent()
    if not self:GetEngineActive() then return end

    local Size = 300 + self:GetThrottle() * 140 + self:GetBoost() * 4

    render.SetMaterial( self.EngineGlow )

    for _, pos in pairs( self.EnginePos ) do
        render.DrawSprite( self:LocalToWorld( pos ), Size, Size, self.EngineColor)
    end
end

function ENT:OnStartBoost()
    self:EmitSound( "lvs/vehicles/arc170/boost.wav", 85 )
end

function ENT:OnStopBoost()
    self:EmitSound( "lvs/vehicles/arc170/brake.wav", 85)
end