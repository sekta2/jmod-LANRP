-- Jackarunda 2021
AddCSLuaFile()
ENT.Base = "ent_jack_gmod_ezbomb"
ENT.Author = "Jackarunda"
ENT.Category = "JMod - EZ Explosives"
ENT.Information = "glhfggwpezpznore"
ENT.PrintName = "EZ Chlorine Bomb"
ENT.Spawnable = true
ENT.AdminSpawnable = true
---
ENT.JModPreferredCarryAngles = Angle(0, 0, 0)
ENT.EZRackOffset = Vector(0, 0, 10)
ENT.EZRackAngles = Angle(0, 0, 0)
ENT.EZbombBaySize = 5
ENT.EZguidable = false
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
		local SelfPos, Owner, SelfVel = self:LocalToWorld(self:OBBCenter()), self.EZowner or self, self:GetPhysicsObject():GetVelocity()
		local Boom = ents.Create("env_explosion")
		Boom:SetPos(SelfPos)
		Boom:SetKeyValue("imagnitude", "50")
		Boom:SetOwner(Owner)
		Boom:Spawn()
		Boom:Fire("explode", 0)
		---
		for i = 1, 100 do
			timer.Simple(i / 120, function()
				local Gas = ents.Create("ent_jack_gmod_ezchlorineparticle")
				Gas:SetPos(SelfPos)
				JMod.SetEZowner(Gas, Owner)
				Gas:Spawn()
				Gas:Activate()
				Gas.CurVel = VectorRand() * math.random(-100, 50)
				Gas.MaxLife = 60
			end)
		end
		---
		self:Remove()
	end

	function ENT:AeroDragThink()

		local Phys = self:GetPhysicsObject()

		if (self:GetState() == STATE_ARMED) and (Phys:GetVelocity():Length() > 400) and not self:IsPlayerHolding() and not constraint.HasConstraints(self) then
			self.FreefallTicks = self.FreefallTicks + 1

			if self.FreefallTicks >= 10 then
				local Tr = util.QuickTrace(self:GetPos(), Phys:GetVelocity():GetNormalized() * 100, self)

				if Tr.Hit then
					self:Detonate()
				end
			end
		else
			self.FreefallTicks = 0
		end

		JMod.AeroDrag(self, self:GetForward())
		self:NextThink(CurTime() + .1)

		return true
	end
elseif CLIENT then
	function ENT:Initialize()
	end

	function ENT:Think()
	end

	function ENT:Draw()
		local Pos, Ang = self:GetPos(), self:GetAngles()
		Ang:RotateAroundAxis(Ang:Up(), 90)
		self:DrawModel()
		JMod.RenderModel(self.Mdl, Pos + Ang:Up() * -15, Ang)
	end

	function ENT:OnRemove()
		if self.Mdl then
			self.Mdl:Remove()
		end
	end

	language.Add("ent_jack_gmod_ezbigbomb", "EZ Big Bomb")
end
