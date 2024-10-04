-- Jackarunda 2021
AddCSLuaFile()
ENT.Base = "ent_jack_gmod_ezgrenade"
ENT.Author = "Jackarunda, TheOnly8Z"
ENT.Category = "JMod - EZ Explosives"
ENT.PrintName = "EZ Stick Grenade"
ENT.Spawnable = true
ENT.Model = "models/jmod/explosives/grenades/sticknade/stick_grenade.mdl" -- "models/mechanics/robotics/a2.mdl"
ENT.Material = "models/mats_jack_nades/stick_grenade"
--ENT.ModelScale=1.25
ENT.SpoonModel = "models/jmod/explosives/grenades/sticknade/stick_grenade_cap.mdl"
ENT.HardThrowStr = 800
ENT.SoftThrowStr = 400
ENT.JModPreferredCarryAngles = Angle(0, 0, 0)
ENT.EZspinThrow = true
ENT.PinBodygroup = nil
ENT.SpoonBodygroup = {4, 1}
ENT.DetDelay = 4

ENT.Hints = {"frag sleeve"}

ENT.EZstorageVolumeOverride = 2
ENT.Splitterring = false
local BaseClass = baseclass.Get(ENT.Base)

if SERVER then
	--[[function ENT:ShiftAltUse(activator, onOff)
		if not onOff then return end
		self.Splitterring = not self.Splitterring

		if self.Splitterring then
			self:SetMaterial("models/mats_jack_nades/stick_grenade_frag")
			self:EmitSound("snds_jack_gmod/metal_shf.ogg", 60, 120)
		else
			self:SetMaterial("models/mats_jack_nades/stick_grenade")
			self:EmitSound("snds_jack_gmod/metal_shf.ogg", 60, 80)
		end
	end]]

	function ENT:Detonate()
		if self.Exploded then return end
		self.Exploded = true
		local SelfPos = self:GetPos()
		JMod.Sploom(self.EZowner, self:GetPos(), math.random(10, 20), 254)
		self:EmitSound("snd_jack_fragsplodeclose.ogg", 90, 100)
		local plooie = EffectData()
		plooie:SetOrigin(SelfPos)
		plooie:SetScale(.5)
		plooie:SetRadius(1)
		plooie:SetNormal(vector_up)
		util.Effect("eff_jack_minesplode", plooie, true, true)
		util.ScreenShake(SelfPos, 20, 20, 1, 1000)

		local GroundTr = util.QuickTrace(SelfPos + Vector(0, 0, 5), Vector(0, 0, -15), {self})

		--              shooter, origin, fragNum, fragDmg, fragMaxDist, attacker, direction, spread, zReduction
		if GroundTr.Hit then
			JMod.FragSplosion(self, SelfPos + Vector(0, 0, 5), 3000, 100, 2500, JMod.GetEZowner(self), GroundTr.HitNormal, .8, 40)
		else
			JMod.FragSplosion(self, SelfPos, 3000, 100, 2500, JMod.GetEZowner(self), nil, nil, 2)
		end
		self:Remove()
	end
elseif CLIENT then
	language.Add("ent_jack_gmod_ezsticknade", "EZ Stick Grenade")
end
