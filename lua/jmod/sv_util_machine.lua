function JMod.DamageSpark(ent)
	local effectdata = EffectData()
	effectdata:SetOrigin(ent:GetPos() + ent:GetUp() * 10 + VectorRand() * math.random(0, 10))
	effectdata:SetNormal(VectorRand())
	effectdata:SetMagnitude(math.Rand(2, 4)) --amount and shoot hardness
	effectdata:SetScale(math.Rand(.5, 1.5)) --length of strands
	effectdata:SetRadius(math.Rand(2, 4)) --thickness of strands
	util.Effect("Sparks", effectdata, true, true)
	ent:EmitSound("snd_jack_turretfizzle.ogg", 70, 100)
end

function JMod.EMP(pos, range)
	--debugoverlay.Sphere(pos, range, 5, Color(0, 0, 255), true)
	for k, ent in pairs(ents.FindInSphere(pos, range)) do
		if ent.IsJackyEZmachine and ent.SetState and ent.GetState and (ent:GetState() > 0) then
			if ent.TurnOff then 
				ent:TurnOff() 
			else
				ent:SetState(JMod.EZ_STATE_OFF)
			end
			ent.EZstayOn = nil
		end
		if ent.LVS and ent.StopEngine then
			ent:StopEngine()
			ent.EZengineNextStartTime = CurTime() + 30
		end
	end
end

hook.Add( "LVS.IsEngineStartAllowed", "JMod_DisableEMPedEngines", function(veh)
	if veh.EZengineNextStartTime and (veh.EZengineNextStartTime > CurTime()) then
		return false
	else
		veh.EZengineNextStartTime = nil 
	end
end)

function JMod.EZinstallMachine(machine, install)
	if not(IsValid(machine)) then return end
	if ((machine.EZinstalled or false) == install) then return end
	if (install == nil) then install = true end
	if not(IsValid(machine)) then return end
	local Phys = machine:GetPhysicsObject()
	if not(IsValid(Phys)) then return end

	machine.EZinstalled = install
	Phys:EnableMotion(not install)
end

function JMod.StartResourceConnection(machine, ply)
	if not(IsValid(machine)) then return end
	if IsValid(machine.EZconnectorPlug) then 
		if machine.EZconnectorPlug:IsPlayerHolding() then return end
		SafeRemoveEntity(machine.EZconnectorPlug)
	end
	if not(JMod.ShouldAllowControl(machine, ply, true)) then return end
	if not IsValid(ply) then return end

	local Plugy = ents.Create("ent_jack_gmod_ezhook")
	if not IsValid(Plugy) then return end
	Plugy:SetPos(machine:GetPos() + Vector(0, 0, 50)) -- Adjust the position as needed
	Plugy:SetAngles(machine:GetAngles())
	Plugy.Model = "models/props_lab/tpplug.mdl"
	Plugy.EZhookType = "Plugin"
	Plugy.EZconnector = machine
	Plugy:Spawn()
	Plugy:Activate()
	machine.EZconnectorPlug = Plugy

	local ropeLength = machine.MaxConnectionRange or 1000
	local Rope = constraint.Rope(machine, Plugy, 0, 0, machine.EZpowerSocket or Vector(0,0,0), Vector(10,0,0), ropeLength, 0, 1000, 2, "cable/cable2", false)
	Plugy.Chain = Rope

	ply:DropObject()
	ply:PickupObject(Plugy)
end

--[[function JModResourceCable(Machine1, Connection, connectionData)
	local Machine2 = connectionData.EntToConnect
	if not(IsValid(Machine1) and IsValid(Machine2) and IsValid(Connection)) then return end
	Ent1.EZconnections = Ent1.EZconnections or {}
	Ent2.EZconnections = Ent2.EZconnections or {}


	constraint.AddConstraintTable( Machine1, Connection, Machine2 )

	Ent2:SetTable( {
		Type = "JModResourceCable",
		Ent1 = Machine1,
		Ent2 = Connection,
		MyCoolData = MyCoolData
	} )

	return Connection
end
duplicator.RegisterConstraint("JModResourceCable", JModResourceCable, "Machine1", "Connection", "MyCoolData")--]]

function JMod.CreateResourceConnection(machine, ent, resType, plugPos, dist, newCable)
	dist = dist or 1000
	if not (IsValid(machine) and IsValid(ent) and resType) then return false end
	if not IsValid(ent) or (ent == machine) then return false end
	if not (ent.EZconsumes and table.HasValue(ent.EZconsumes, resType)) and not (resType == JMod.EZ_RESOURCE_TYPES.POWER and (ent.EZpowerProducer and not machine.EZpowerProducer)) then return false end
	if ent.IsJackyEZcrate and ent.GetResourceType and not(ent:GetResourceType() == resType or ent:GetResourceType() == "generic") then return false end
	if not JMod.ShouldAllowControl(ent, JMod.GetEZowner(machine), true) then return false end
	local PluginPos = ent.EZpowerSocket or plugPos or ent:OBBCenter()
	if not IsValid(newCable) then
		local DistanceBetween = (machine:GetPos() - ent:LocalToWorld(PluginPos)):Length()
		if (DistanceBetween > dist) then return false end
	end
	--
	machine.EZconnections = machine.EZconnections or {}
	local AlreadyConnected = false
	local EntID = ent:EntIndex()
	for entID, cable in pairs(machine.EZconnections) do
		if entID == EntID then
			AlreadyConnected = true

			break
		end
	end
	if AlreadyConnected then return false end
	
	ent.EZconnections = ent.EZconnections or {}
	local MachineIndex = machine:EntIndex()
	for entID, cable in pairs(ent.EZconnections) do
		if (EntID == MachineIndex) then
			if IsValid(cable) then
				cable:Remove()
			end
			ent.EZconnections[entID] = nil
		end
	end
	--
	if not IsValid(newCable) then
		newCable = constraint.Rope(machine, ent, 0, 0, machine.EZpowerSocket or Vector(0, 0, 0), PluginPos, dist + 20, 10, 100, 2, "cable/cable2")
	end
	ent.EZconnections[MachineIndex] = newCable
	machine.EZconnections[EntID] = newCable

	return true
end

function JMod.RemoveResourceConnection(machine, connection)
	if not IsValid(machine) then return end
	-- Check if connection is a entity first
	if type(connection) == "Entity" and IsValid(connection) then
		-- Check if it is connected
		connection = connection:EntIndex()
	end
	if not(machine.EZconnections[connection]) then return end
	local ConnectedEnt = Entity(connection)
	local Cable = machine.EZconnections[connection]
	if IsValid(Cable) then
		Cable:Remove()
	end
	machine.EZconnections[connection] = nil
end

function JMod.ConnectionValid(machine, otherMachine)
	if not(IsValid(machine) and IsValid(otherMachine)) then return false end
	if not(machine.EZconnections and otherMachine.EZconnections) then return false end
	if not(IsValid(machine.EZconnections[otherMachine:EntIndex()])) then return false end
	return true
end

function JMod.MachineSpawnResource(machine, resourceType, amount, relativeSpawnPos, relativeSpawnAngle, ejectionVector, findCrateRange)
	amount = math.Round(amount)
	if not(amount) or (amount < 1) then return end --print("[JMOD] " .. tostring(machine) .. " tried to produce a resource with 0 value") return end
	machine.NextRefillTime = CurTime() + 1
	local SpawnPos, SpawnAngle, MachineOwner = machine:LocalToWorld(relativeSpawnPos), relativeSpawnAngle and machine:LocalToWorldAngles(relativeSpawnAngle), JMod.GetEZowner(machine)
	local MachineCenter = machine:LocalToWorld(machine:OBBCenter())
	if machine:GetClass() != "ent_jack_gmod_ezpowerbank" and (resourceType == JMod.EZ_RESOURCE_TYPES.POWER) and (machine.GetState and machine:GetState() == JMod.EZ_STATE_ON) and machine.EZconnections then
		local PowerToGive = amount
		for entID, cable in pairs(machine.EZconnections) do
			local Ent, Cable = Entity(entID), cable
			if not IsValid(Ent) or not IsValid(Cable) or not(Ent.EZconsumes and table.HasValue(Ent.EZconsumes, JMod.EZ_RESOURCE_TYPES.POWER)) then
				JMod.RemoveResourceConnection(machine, Ent)
			else
				local Accepted = Ent:TryLoadResource(resourceType, PowerToGive)
				Ent.NextRefillTime = 0
				amount = math.Clamp(amount - Accepted, 0, 200)
			end
		end
	end

	if amount <= 0 then return end
	for i = 1, math.ceil(amount/100*JMod.Config.ResourceEconomy.MaxResourceMult) do
		if findCrateRange then
			findCrateRange = findCrateRange * findCrateRange -- Sqr root stuff
			local BestCrate = nil
			local IsGenericCrate = true

			for _, ent in pairs(ents.FindInSphere(machine:LocalToWorld(ejectionVector or machine:OBBCenter()), findCrateRange)) do
				if (ent.IsJackyEZcrate and table.HasValue(ent.EZconsumes, resourceType)) or (ent.IsJackyEZresource and (ent.EZsupplies == resourceType)) then
					local Dist = MachineCenter:DistToSqr(ent:LocalToWorld(ent:OBBCenter()))
					if (Dist <= findCrateRange) and (ent:GetResource() < ent.MaxResource) then
						local EntSupplies = ent:GetEZsupplies()
						if (EntSupplies[resourceType] ~= nil) then
							BestCrate = ent
							findCrateRange = Dist
							IsGenericCrate = false
						elseif (EntSupplies["generic"] == 0) and (IsGenericCrate == true) then
							BestCrate = ent
							findCrateRange = Dist
							IsGenericCrate = true
						end
					end
				end
			end
			
			if IsValid(BestCrate) then
				local Remaining = amount
				if BestCrate.TryLoadResource then
					Remaining = BestCrate:TryLoadResource(resourceType, amount, true)
				else
					local SuppliesContained = BestCrate:GetEZsupplies(resourceType)
					if not SuppliesContained then SuppliesContained = 0 end -- To fix weird bugs
					Remaining = math.min(BestCrate.MaxResource - SuppliesContained, Remaining)
					BestCrate:SetEZsupplies(resourceType, SuppliesContained + Remaining)
				end
				
				if Remaining > 0 then
					local entPos = BestCrate:LocalToWorld(BestCrate:OBBCenter())
					JMod.ResourceEffect(resourceType, machine:LocalToWorld(ejectionVector or machine:OBBCenter()), entPos, amount * 0.01, 0.1, 1)
					amount = amount - Remaining
					if amount <= 0 then 
					
						return
					end
				end
			end
		end

		local SpawnTr = util.TraceLine({
			start = MachineCenter,
			endpos = SpawnPos,
			filter = {machine},
			mask = MASK_SOLID
		})

		if SpawnTr.Hit then
			local SpawnPos = SpawnTr.HitPos + (SpawnTr.HitNormal * 40)
		end
		-- TODO: Figure out how to optimize the resource effects
		local SpawnAmount = math.min(amount, 100 * JMod.Config.ResourceEconomy.MaxResourceMult)
		if ejectionVector then
			JMod.ResourceEffect(resourceType, machine:LocalToWorld(ejectionVector), SpawnPos, SpawnAmount * 0.01, 1, 1)
		end
		timer.Simple(.3 * math.ceil(amount/(100 * JMod.Config.ResourceEconomy.MaxResourceMult)), function()
			local Resource = ents.Create(JMod.EZ_RESOURCE_ENTITIES[resourceType])
			Resource:SetPos(SpawnPos)
			Resource:SetAngles(SpawnAngle or Resource.JModPreferredCarryAngles or Angle(0, 0, 0))
			Resource:Spawn()
			JMod.SetEZowner(Resource, MachineOwner)
			Resource:SetEZsupplies(resourceType, SpawnAmount)
			Resource:Activate()
		end)

		amount = amount - SpawnAmount

		if amount <= 0 then
			
			if (resourceType == JMod.EZ_RESOURCE_TYPES.POWER) and not(machine.EZstayOn) and machine.TurnOff then
				machine:TurnOff()
			end
			return
		end
	end
end

function JMod.BuildRecipe(results, ply, Pos, Ang, skinNum)
	if istable(results) then
		for n = 1, (results[2] or 1) do
			local Ent = ents.Create(results[1])
			Ent:SetPos(Pos + Vector(0, 0, n * 25))
			Ent:SetAngles(Ang)
			JMod.SetEZowner(Ent, ply)
			Ent:SetCreator(ply)
			Ent:Spawn()
			Ent:Activate()
			if (results[3]) then
				Ent:SetEZsupplies(Ent.EZsupplies, results[3])
			end
		end
	else
		local StringParts=string.Explode(" ", results)
		if((StringParts[1])and(StringParts[1] == "FUNC"))then
			local FuncName = StringParts[2]
			if((JMod.LuaConfig) and (JMod.LuaConfig.BuildFuncs) and (JMod.LuaConfig.BuildFuncs[FuncName]))then
				local Ent = JMod.LuaConfig.BuildFuncs[FuncName](ply, Pos, Ang)
			else
				print("JMOD WORKBENCH ERROR: JMod.LuaConfig is missing, corrupt, or doesn't have an entry for that build function")
			end
		elseif string.Right(results, 4) == ".mdl" then
			local Ent = ents.Create("prop_physics")
			Ent:SetModel(results)
			Ent:SetPos(Pos)
			Ent:SetAngles(Ang)
			JMod.SetEZowner(Ent, ply)
			Ent:SetCreator(ply)
			Ent:Spawn()
			Ent:Activate()
			if skinNum then
				if istable(skinNum) then
					Ent:SetSkin(table.Random(skinNum))
				else
					Ent:SetSkin(skinNum)
				end
			end
		else
			local Ent = ents.Create(results)
			Ent:SetPos(Pos)
			Ent:SetAngles(Ang)
			JMod.SetEZowner(Ent, ply)
			Ent:SetCreator(ply)
			Ent:Spawn()
			Ent:Activate()
			JMod.Hint(ply, results)
		end
	end
end

function JMod.BuildEffect(pos)
	local Scale = .5
	local effectdata = EffectData()
	effectdata:SetOrigin(pos + VectorRand())
	effectdata:SetNormal((VectorRand() + Vector(0, 0, 1)):GetNormalized())
	effectdata:SetMagnitude(math.Rand(1, 2) * Scale) --amount and shoot hardness
	effectdata:SetScale(math.Rand(.5, 1.5) * Scale) --length of strands
	effectdata:SetRadius(math.Rand(2, 4) * Scale) --thickness of strands
	util.Effect("Sparks", effectdata,true,true)
	sound.Play("snds_jack_gmod/ez_tools/hit.ogg", pos + VectorRand(), 60, math.random(80, 120))
	sound.Play("snds_jack_gmod/ez_tools/"..math.random(1, 27)..".ogg", pos, 60, math.random(80, 120))
	local eff = EffectData()
	eff:SetOrigin(pos + VectorRand())
	eff:SetScale(Scale)
	util.Effect("eff_jack_gmod_ezbuildsmoke", eff, true, true)
	-- todo: useEffects
end

concommand.Add("jmod_debug_destroy", function(ply, cmd, args)
	if not GetConVar("sv_cheats"):GetBool() then return end
	if not ply:IsSuperAdmin() then return end
	local Tr = ply:GetEyeTrace()

	if not Tr.Entity then
		print("No Entity to destroy")

		return
	end

	local ent = Tr.Entity

	if ent.Destroy then
		print("Destroying ent: " .. tostring(ent))
		ent:Destroy(DamageInfo())
	else
		print("Entity does not have a destroy function")
	end
end, nil, "Destroys the current JMod thing you are looking at")