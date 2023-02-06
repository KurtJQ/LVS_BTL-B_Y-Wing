include("shared.lua")

ENT.EngineColor = Color( 255, 0, 0 , 255)
ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.EnginePos = {
    Vector( -633.16,239.81,58.68 ),
    Vector( -633.16,-239.81,58.68 )
}

function ENT:OnSpawn()
    self:RegisterTrail( Vector(-637.74, -295.15, 60.08), 0, 20, 2, 1000, 150)
    self:RegisterTrail( Vector(-637.74, 295.15, 60.08), 0, 20, 2, 1000, 150)
end

function ENT:PostDraw()
    if not self:GetEngineActive() then return end

    local Opacity = math.Clamp(120 + self:GetThrottle() * 100 + self:GetBoost() * 4, 0, 255)

    cam.Start3D2D( self:LocalToWorld( Vector( -613.53,239.71,58.69 ) ), self:LocalToWorldAngles( Angle( -90, 0, 0 ) ), 1)
        draw.NoTexture()
        surface.SetDrawColor( 255, 255 , 255 , Opacity)
        surface.DrawTexturedRectRotated(0, 0, 33.8, 33, 0)
    cam.End3D2D()

    cam.Start3D2D( self:LocalToWorld( Vector( -613.53,-239.71,58.69 ) ), self:LocalToWorldAngles( Angle( -90, 0, 0 ) ), 1)
        draw.NoTexture()
        surface.SetDrawColor( 255, 255 , 255 , Opacity)
        surface.DrawTexturedRectRotated(0, 0, 33.8, 33, 0)
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