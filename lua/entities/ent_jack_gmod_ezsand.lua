-- Jackarunda 2021
AddCSLuaFile()
ENT.Base = "ent_jack_gmod_ezresource"
ENT.PrintName = "EZ Sand"
ENT.Category = "JMod - EZ Resources"
ENT.IconOverride = "materials/ez_resource_icons/sand.png"
ENT.Spawnable = true
ENT.AdminSpawnable = true
---
ENT.EZsupplies = JMod.EZ_RESOURCE_TYPES.SAND
ENT.JModPreferredCarryAngles = Angle(0, 0, 0)
--ENT.Model = "models/hunter/blocks/cube05x075x025.mdl"
ENT.Model = "models/jmod/resources/sandbag.mdl"
--ENT.Material = "phoenix_storms/egg"
ENT.Color = Color(255, 237, 197)
ENT.ModelScale = 1
ENT.Mass = 100
ENT.ImpactNoise1 = "Dirt.Impact"
ENT.DamageThreshold = 100
ENT.BreakNoise = "Dirt.ImpactHard"

if SERVER then
	function ENT:CustomInit()
		self.LastMoved = CurTime()
		self.Gefrozen = false
	end

	function ENT:OnTakeDamage(dmginfo)
		local DmgAmt, ResourceAmt = dmginfo:GetDamage(), self:GetResource()
		local DmgVec = dmginfo:GetDamageForce()
		dmginfo:SetDamageForce(DmgVec / (ResourceAmt^2))
		self:TakePhysicsDamage(dmginfo)
		--self:SetEZsupplies(self.EZsupplies, math.Clamp(ResourceAmt - DmgAmt / 100, 0, 100))

		print(dmginfo:GetDamage())
		if dmginfo:GetDamage() >= self.DamageThreshold then
			self:GetSchmovin()
		end

		if dmginfo:GetDamage() >= (self.DamageThreshold * 3)then
			local Pos = self:GetPos()
			sound.Play(self.BreakNoise, Pos)

			JMod.ResourceEffect(self.EZsupplies, self:LocalToWorld(self:OBBCenter()), nil, self:GetResource() / self.MaxResource, 1, 1)
			if self.UseEffect then
				for i = 1, self:GetResource() / 10 do			
					self:UseEffect(Pos, game.GetWorld(), true)
				end
			end

			self:Remove()
		end
	end

	function ENT:CustomThink()
		local Time = CurTime()

		local Tr = util.TraceHull( {
			start = self:GetPos(),
			endpos = self:GetPos() - Vector(0,0,17),
			filter = self,
			mins = Vector( -5, -5, -5 ),
			maxs = Vector( 5, 5, 5 ),
		} )

		local TimeSinceMoved = Time - self.LastMoved
		local IsMovin = self:IsPlayerHolding() or not Tr.Hit

		if IsMovin then
			self.LastMoved = Time
			debugoverlay.Line( self:GetPos(), Tr.HitPos, 1, Color( 255, 0, 0),false)
			self:GetSchmovin()
		elseif TimeSinceMoved > 2 then
			self:DoTheFreeze()
		end

		self:NextThink(Time + 1)
		return true
	end

	function ENT:DoTheFreeze()
		self:GetPhysicsObject():SetMass(300)
		self:GetPhysicsObject():EnableMotion(false)
		self.Gefrozen = true
		self:DrawShadow(false)
		self:SetCollisionGroup( COLLISION_GROUP_NONE )
	end

	function ENT:GetSchmovin()
		if not(self:IsPlayerHolding()) then
			self:GetPhysicsObject():SetMass(100) --Sorse
		end
		self:GetPhysicsObject():EnableMotion(true)
		self:GetPhysicsObject():Wake()
		self.Gefrozen = false
		self:DrawShadow(true)
		self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
	end

	function ENT:PhysicsCollide( data, phys )
		if (data.Speed>80) and (data.DeltaTime>0.2)then
			if data.HitEntity:GetPhysicsObject():GetMass() >= 90 then
				print(data.HitEntity:GetPhysicsObject():GetMass())
				self:GetSchmovin()
			end
		end
	end

	function ENT:CustomUse()
		if (self.Gefrozen) then
			self:GetSchmovin()
		end
	end
elseif CLIENT then

	function ENT:Initialize()
		--self.Bag = JMod.MakeModel(self, "models/jmod/resources/sandbag.mdl", nil, .97)
		--self.ScaleVec =  Vector(1.2, 1.2, 1.2)
		--self.ColorVec = self.Color:ToVector()
	end
    local drawvec, drawang = Vector(-2, -13, 0), Angle(90, 0, 90)
	function ENT:Draw()
		local Ang, Pos = self:GetAngles(), self:GetPos()
		local Up, Right, Forward = Ang:Up(), Ang:Right(), Ang:Forward()
		self:DrawModel()
		--local BasePos = Pos
		--local JugAng = Ang:GetCopy()
		--JMod.RenderModel(self.Bag, BasePos, Ang, self.ScaleVec, self.ColorVec)

		if self:GetCollisionGroup() == COLLISION_GROUP_NONE then return end

		JMod.HoloGraphicDisplay(self, drawvec, drawang, .04, 200, function()
			JMod.StandardResourceDisplay(JMod.EZ_RESOURCE_TYPES.SAND, self:GetResource(), nil, 0, 0, 200, false, "JMod-Stencil", 220)
		end)
	end

	--language.Add(ENT.ClassName, ENT.PrintName)
end
