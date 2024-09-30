-- Jackarunda 2021
AddCSLuaFile()
ENT.Base = "ent_jack_gmod_ezresource"
ENT.PrintName = "Ore Uranium"
ENT.Category = "JMod - EZ Resources"
ENT.IconOverride = "materials/ez_resource_icons/uranium ore.png"
ENT.Spawnable = true
ENT.AdminSpawnable = true
---
ENT.EZsupplies = JMod.EZ_RESOURCE_TYPES.URANIUMORE
ENT.JModPreferredCarryAngles = Angle(0, 0, 0)
ENT.Model = "models/jmod/resources/resourcecube.mdl"
ENT.Material = "models/mat_jack_gmod_uraniumore"
ENT.ModelScale = 1
ENT.Mass = 50
ENT.ImpactNoise1 = "Rock.ImpactHard"
ENT.DamageThreshold = 120
ENT.BreakNoise = "Boulder.ImpactHard"

if SERVER then

	function ENT:CustomThink()
		if math.random(1, 200) <= self:GetResource() then
			local Ent = ents.Create("ent_jack_gmod_ezfalloutparticle")
			Ent:SetPos(self:GetPos() + Vector(0, 0, 50))
			Ent.EZowner = self.EZowner
			Ent.MaxLife = 15
			Ent.AffectRange = 250
			Ent:Spawn()
			Ent:Activate()
			Ent.CurVel = self:GetVelocity()
		end

		self:NextThink(CurTime() + math.Rand(10, 20))

		return true
	end
else
    local drawvec, drawang = Vector(0, -12, 1), Angle(90, 0, 90)
	function ENT:Draw()
		self:DrawModel()

		JMod.HoloGraphicDisplay(self, drawvec, drawang, .04, 300, function()
			JMod.StandardResourceDisplay(JMod.EZ_RESOURCE_TYPES.URANIUMORE, self:GetResource(), nil, 0, 0, 200, true)
		end)
	end

	--language.Add(ENT.ClassName, ENT.PrintName)
end
