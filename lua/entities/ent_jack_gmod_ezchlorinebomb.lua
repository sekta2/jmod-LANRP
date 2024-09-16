-- Jackarunda 2021
AddCSLuaFile()
ENT.Base = "ent_jack_gmod_ezbomb"
ENT.Author = "Jackarunda"
ENT.Category = "JMod - EZ Explosives"
ENT.Information = "glhfggwpezpznore"
ENT.PrintName = "EZ Big Bomb"
ENT.Spawnable = true
ENT.AdminSpawnable = true
---
ENT.JModPreferredCarryAngles = Angle(90, 0, 0)
ENT.EZRackOffset = Vector(0, 0, 30)
ENT.EZRackAngles = Angle(0, 0, 90)
ENT.EZbombBaySize = 33
ENT.EZguidable = true
---
ENT.Model = "models/props_phx/ww2bomb.mdl"
ENT.Material = "models/entities/chlorine_bomb"
ENT.Mass = 100
ENT.DetSpeed = 1000
---
local STATE_BROKEN, STATE_OFF, STATE_ARMED = -1, 0, 1

---
if SERVER then
	function ENT:Detonate()
		if self.Exploded then return end
		self.Exploded = true
		local SelfPos, Att = self:GetPos() + Vector(0, 0, 100), JMod.GetEZowner(self)
		---
		util.ScreenShake(SelfPos, 1000, 3, 2, 8000)
		local Eff = "cloudmaker_ground"

		if not util.QuickTrace(SelfPos, Vector(0, 0, -300), {self}).HitWorld then
			Eff = "cloudmaker_air"
		end

		---
		for i = 1, 100 do
			timer.Simple(i / 120, function()
				local Gas = ents.Create("ent_jack_gmod_ezchlorineparticle")
				Gas:SetPos(SelfPos)
				JMod.SetEZowner(Gas, Owner)
				Gas:Spawn()
				Gas:Activate()
				Gas.CurVel = SelfVel + VectorRand() * math.random(-100, 100)
				Gas.MaxLife = 60
			end)
		end
		---
		self:Remove()

		timer.Simple(.1, function()
			ParticleEffect(Eff, SelfPos, Angle(0, 0, 0))
		end)
	end
elseif CLIENT then
	function ENT:Initialize()
		self.Mdl = JMod.MakeModel(self, "models/jmod/mk82_gbu.mdl", nil, 1.5)
		self.Guided = false
	end

	function ENT:Think()
		if (not self.Guided) and self:GetGuided() then
			self.Guided = true
			self.Mdl:SetBodygroup(0, 1)
		end
	end

	function ENT:Draw()
		local Pos, Ang = self:GetPos(), self:GetAngles()
		Ang:RotateAroundAxis(Ang:Up(), 90)
		--self:DrawModel()
		JMod.RenderModel(self.Mdl, Pos + Ang:Up() * -15, Ang)
	end

	function ENT:OnRemove()
		if self.Mdl then
			self.Mdl:Remove()
		end
	end

	language.Add("ent_jack_gmod_ezbigbomb", "EZ Big Bomb")
end
