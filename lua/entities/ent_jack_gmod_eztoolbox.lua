﻿-- Jackarunda 2021
AddCSLuaFile()
ENT.Type = "anim"
ENT.Author = "Jackarunda"
ENT.Category = "JMod - EZ Misc."
ENT.Information = "glhfggwpezpznore"
ENT.PrintName = "EZ Toolbox"
ENT.NoSitAllowed = true
ENT.Spawnable = true
ENT.AdminSpawnable = true
---
ENT.JModPreferredCarryAngles = Angle(0, 0, 0)
ENT.DamageThreshold = 120
ENT.JModEZstorable = true

---
local Props = {
	"models/props_c17/tools_wrench01a.mdl", 
	"models/props_c17/tools_pliers01a.mdl", 
	"models/props_forest/circularsaw01.mdl", 
	--"models/props_silo/welding_torch.mdl", 
	"models/props_mining/pickaxe01.mdl", 
	--"models/props_silo/welding_helmet.mdl", 
	"models/props_forest/axe.mdl", 
	"models/weapons/w_defuser.mdl", 
	"models/weapons/w_defuser.mdl", 
	"models/props_c17/tools_wrench01a.mdl", 
	"models/props_c17/tools_pliers01a.mdl"
}

if SERVER then
	function ENT:SpawnFunction(ply, tr)
		local SpawnPos = tr.HitPos + tr.HitNormal * 40
		local ent = ents.Create(self.ClassName)
		ent:SetAngles(Angle(0, 0, 0))
		ent:SetPos(SpawnPos)
		JMod.SetEZowner(ent, ply)
		if JMod.Config.Machines.SpawnMachinesFull then
			ent.SpawnFull = true
		end
		ent:Spawn()
		ent:Activate()
		return ent
	end

	function ENT:Initialize()
		self:SetModel("models/weapons/w_models/w_tooljox.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(true)
		self:SetUseType(SIMPLE_USE)
		self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

		---
		local Phys = self:GetPhysicsObject()
		timer.Simple(.01, function()
			if not IsValid(Phys) then return end
			Phys:SetMass(50)
			Phys:Wake()
		end)
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > 0.2 then
			if data.Speed > 100 then
				self:EmitSound("Metal_Box.ImpactHard")
				self:EmitSound("Canister.ImpactHard")
			end
		end
	end

	function ENT:OnTakeDamage(dmginfo)
		self:TakePhysicsDamage(dmginfo)

		if dmginfo:GetDamage() > self.DamageThreshold then
			local Pos = self:GetPos()
			sound.Play("Metal_Box.Break", Pos)

			for k, mdl in pairs(Props) do
				if util.IsValidModel(mdl) then 
					local Item = ents.Create("prop_physics")
					Item:SetModel(mdl)
					Item:SetPos(Pos + VectorRand() * 5 + Vector(0, 0, 10))
					Item:SetAngles(VectorRand():Angle())
					Item:Spawn()
					Item:Activate()
					Item:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
					local Phys = Item:GetPhysicsObject()

					if IsValid(Phys) then
						Phys:SetVelocity(self:GetVelocity() / 2 + Vector(0, 0, 200) + VectorRand() * math.Rand(10, 600))
						Phys:AddAngleVelocity(VectorRand() * math.Rand(10, 3000))
					end

					SafeRemoveEntityDelayed(Item, math.random(10, 20))
				end
			end

			self:Remove()
		end
	end

	function ENT:Use(activator)

		local WepGetSlot = ents.Create("wep_jack_gmod_eztoolbox")
		WepGetSlot:Spawn()
		local slot = WepGetSlot:GetSlot()
		WepGetSlot:Remove()

		if activator:KeyDown(JMod.Config.General.AltFunctionKey) and true then
			activator:Give("wep_jack_gmod_eztoolbox")
			activator:SelectWeapon("wep_jack_gmod_eztoolbox")

			local ToolBox = activator:GetWeapon("wep_jack_gmod_eztoolbox")

			self:Remove()
		else
			activator:PickupObject(self)
		end
	end

elseif CLIENT then
	function ENT:Initialize()
	end
	function ENT:Draw()
		self:DrawModel()
	end

	language.Add("ent_jack_gmod_eztoolbox", "EZ Toolbox")
end
