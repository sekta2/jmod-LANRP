local force_workshop = CreateConVar("jmod_forceworkshop", 1, {FCVAR_ARCHIVE}, "Force clients to download JMod + its content? (requires a restart upon change)")

if force_workshop:GetBool() then
    resource.AddWorkshop("1919689921")
    resource.AddWorkshop("1919703147")
    resource.AddWorkshop("1919692947")
    resource.AddWorkshop("1919694756")
end

local function JackaSpawnHook(ply)
	ply.JModFriends=ply.JModFriends or {}
	if(ply.EZarmor and ply.EZarmor.suited)then
		ply:SetColor(Color(255,255,255))
	end
	ply.EZarmor={
		items={},
		speedFrac=nil,
		effects={},
		mskmat=nil,
		sndlop=nil,
		suited=false,
		bodygroups=nil
	}
	JModEZarmorSync(ply)
	ply.EZhealth=nil
	ply.EZirradiated=nil
	ply.EZoxygen=100
	ply.EZbleeding=0
	timer.Simple(0,function() ply.EZoriginalPlayerModel=ply:GetModel() end)
	net.Start("JMod_PlayerSpawn")
	net.WriteBit(JMOD_CONFIG.Hints)
	net.Send(ply)
end
hook.Add("PlayerSpawn","JMod_PlayerSpawn",JackaSpawnHook)
hook.Add("PlayerInitialSpawn","JMod_PlayerInitialSpawn",JackaSpawnHook)

function JMod_SyncBleeding(ply)
	net.Start("JMod_Bleeding")
	net.WriteInt(ply.EZbleeding,8)
	net.Send(ply)
end

hook.Add("PlayerLoadout","JMod_PlayerLoadout",function(ply)
	if((JMOD_CONFIG)and(JMOD_CONFIG.QoL.GiveHandsOnSpawn))then
		ply:Give("wep_jack_gmod_hands")
	end
end)

hook.Add("GetPreferredCarryAngles","JMOD_PREFCARRYANGS",function(ent)
	if(ent.JModPreferredCarryAngles)then return ent.JModPreferredCarryAngles end
end)

hook.Add("AllowPlayerPickup","JMOD_PLAYERPICKUP",function(ply,ent)
	if(ent.JModNoPickup)then return false end
end)

local NextMainThink,NextNutritionThink,NextArmorThink,NextSlowThink,NextSync=0,0,0,0,0
hook.Add("Think","JMOD_SERVER_THINK",function()
	local Time=CurTime()
	if(NextMainThink>Time)then return end
	NextMainThink=Time+1
	---
	for k,playa in pairs(player.GetAll())do
		local Alive=playa:Alive()
		if(Alive)then
			if(playa.EZhealth)then
				local Healin=playa.EZhealth
				if(Healin>0)then
					local Amt=1
					if(math.random(1,3)==2)then Amt=2 end
					playa.EZhealth=Healin-Amt
					local Helf,Max=playa:Health(),playa:GetMaxHealth()
					if(Helf<Max)then
						playa:SetHealth(math.Clamp(Helf+Amt,0,Max))
						if(playa:Health()==Max)then playa:RemoveAllDecals() end
					end
				end
			end
			if(playa.EZbleeding)then
				local Bleed=playa.EZbleeding
				if(Bleed>0)then
					local Amt=JMOD_CONFIG.QoL.BleedSpeedMult
					playa.EZbleeding=math.Clamp(Bleed-Amt,0,9e9)
					local Dmg=DamageInfo()
					Dmg:SetAttacker((IsValid(playa.EZbleedAttacker) and playa.EZbleedAttacker) or game.GetWorld())
					Dmg:SetInflictor(game.GetWorld())
					Dmg:SetDamage(Amt)
					Dmg:SetDamageType(DMG_GENERIC)
					Dmg:SetDamagePosition(playa:GetShootPos())
					playa:TakeDamageInfo(Dmg)
					--
					local Tr=util.QuickTrace(playa:GetShootPos()+VectorRand()*30,Vector(0,0,-150),playa)
					if(Tr.Hit)then
						util.Decal("Blood",Tr.HitPos+Tr.HitNormal,Tr.HitPos-Tr.HitNormal)
					end
				end
			end
			if(playa.EZirradiated)then
				local Rads=playa.EZirradiated
				if((Rads>0)and(math.random(1,3)==1))then
					playa.EZirradiated=math.Clamp(Rads-.5,0,9e9)
					local Dmg=DamageInfo()
					Dmg:SetAttacker(playa)
					Dmg:SetInflictor(game.GetWorld())
					Dmg:SetDamage(1)
					Dmg:SetDamageType(DMG_GENERIC)
					Dmg:SetDamagePosition(playa:GetShootPos())
					playa:TakeDamageInfo(Dmg)
				end
			end
			if(JMOD_CONFIG.QoL.Drowning)then
				if(playa:WaterLevel()>=3)then
					playa.EZoxygen=math.Clamp(playa.EZoxygen-1.67,0,100) -- 60 seconds before damage
					if(playa.EZoxygen<=25)then playa.EZneedGasp=true end
					if(playa.EZoxygen<=0)then
						local Dmg=DamageInfo()
						Dmg:SetDamageType(DMG_DROWN)
						Dmg:SetDamage(5)
						Dmg:SetAttacker(playa)
						Dmg:SetInflictor(game.GetWorld())
						Dmg:SetDamagePosition(playa:GetPos())
						Dmg:SetDamageForce(Vector(0,0,0))
						playa:TakeDamageInfo(Dmg)
					end
				elseif(playa.EZoxygen<100)then
					if(playa.EZneedGasp)then
						sound.Play("snds_jack_gmod/drown_gasp.wav",playa:GetShootPos(),60,math.random(90,110))
						playa.EZneedGasp=false
					end
					playa.EZoxygen=math.Clamp(playa.EZoxygen+25,0,100) -- recover in 4 seconds
				end
			end
		end
	end
	---
	if(NextNutritionThink<Time)then
		NextNutritionThink=Time+10/JMOD_CONFIG.FoodSpecs.DigestSpeed
		for k,playa in pairs(player.GetAll())do
			if(playa.EZnutrition)then
				if(playa:Alive())then
					local Nuts=playa.EZnutrition.Nutrients
					if(Nuts>0)then
						playa.EZnutrition.Nutrients=Nuts-1
						local Helf,Max,Nuts=playa:Health(),playa:GetMaxHealth()
						if(Helf<Max)then
							playa:SetHealth(Helf+1)
							if(playa:Health()==Max)then playa:RemoveAllDecals() end
						elseif(math.Rand(0,1)<.75)then
							local BoostMult=JMOD_CONFIG.FoodSpecs.BoostMult
							local BoostedFrac=(Helf-Max)/Max
							if(math.Rand(0,1)>BoostedFrac)then
								playa:SetHealth(Helf+BoostMult)
								if(playa:Health()>=Max)then playa:RemoveAllDecals() end
							end
						end
					end
				end
			end
		end
	end
	---
	if(NextArmorThink<Time)then
		NextArmorThink=Time+10
		for k,playa in pairs(player.GetAll())do
			if((playa.EZarmor)and(playa:Alive()))then
				if(playa.EZarmor.effects.nightVision)then
					for id,armorData in pairs(playa.EZarmor.items)do
						local Info=JMod_ArmorTable[armorData.name]
						if((Info.eff)and(Info.eff.nightVision))then
							armorData.chrg.power=math.Clamp(armorData.chrg.power-JMOD_CONFIG.ArmorChargeDepletionMult/2,0,9e9)
							if(armorData.chrg.power<=Info.chrg.power*.25)then JMod_EZarmorWarning(playa,"armor's electricity soon to be depleted!") end
						end
					end
				elseif(playa.EZarmor.effects.thermalVision)then
					for id,armorData in pairs(playa.EZarmor.items)do
						local Info=JMod_ArmorTable[armorData.name]
						if((Info.eff)and(Info.eff.thermalVision))then
							armorData.chrg.power=math.Clamp(armorData.chrg.power-JMOD_CONFIG.ArmorChargeDepletionMult/2,0,9e9)
							if(armorData.chrg.power<=Info.chrg.power*.25)then JMod_EZarmorWarning(playa,"armor's electricity soon to be depleted!") end
						end
					end
				end
				JMod_CalcSpeed(playa)
				JModEZarmorSync(playa)
			end
		end
	end
	---
	if(NextSlowThink<Time)then
		NextSlowThink=Time+2
		if(JMOD_CONFIG.QoL.ExtinguishUnderwater)then
			for k,v in pairs(ents.GetAll())do
				if((v.IsOnFire)and(v.WaterLevel))then
					if((v:IsOnFire())and(v:WaterLevel()>=3))then
						v:Extinguish()
					end
				end
			end
		end
	end
	---
	for k,v in pairs(ents.FindByClass("npc_*"))do
		if(v.EZNPCincapacitate)then
			if(v.EZNPCincapacitate>Time)then
				if not(v.EZNPCincapacitated)then
					v:SetNPCState(NPC_STATE_PLAYDEAD)
					v.EZNPCincapacitated=true
				end
			elseif(v.EZNPCincapacitated)then
				v:SetNPCState(NPC_STATE_ALERT)
				v.EZNPCincapacitated=false
			end
		end
	end
	---
	if(NextSync<Time)then
		NextSync=Time+30
		net.Start("JMod_LuaConfigSync")
		net.WriteTable((JMOD_LUA_CONFIG and JMOD_LUA_CONFIG.ArmorOffsets) or {})
		net.WriteInt(JMOD_CONFIG.AltFunctionKey,32)
		net.WriteFloat(JMOD_CONFIG.WeaponSwayMult)
		net.Broadcast()
	end
end)

concommand.Add("jacky_player_debug",function(ply,cmd,args)
	if not(GetConVar("sv_cheats"):GetBool())then return end
	if not(ply:IsSuperAdmin())then return end
	for k,v in pairs(player.GetAll())do
		if(v~=ply)then
			v:SetPos(ply:GetPos()+Vector(100*k,0,0))
			v:SetHealth(100)
		end
	end
end)

hook.Add("GetFallDamage","JMod_FallDamage",function(ply,spd)
	if(JMOD_CONFIG.QoL.RealisticFallDamage)then
		return spd^2/8000
	end
end)

hook.Add("DoPlayerDeath","JMOD_SERVER_PLAYERDEATH",function(ply)
	ply.EZnutrition=nil
	ply.EZhealth=nil
	ply.EZkillme=nil
	if(ply.JackyMatDeathUnset)then ply.JackyMatDeathUnset=false;ply:SetMaterial("") end
end)

hook.Add("PlayerLeaveVehicle","JMOD_LEAVEVEHICLE",function(ply,veh)
	if(veh.EZvehicleEjectPos)then
		local WorldPos=veh:LocalToWorld(veh.EZvehicleEjectPos)
		ply:SetPos(WorldPos)
		veh.EZvehicleEjectPos=nil
	end
end)

function JMod_EZ_Remote_Trigger(ply)
	if not(IsValid(ply))then return end
	if not(ply:Alive())then return end
	sound.Play("snd_jack_detonator.wav",ply:GetShootPos(),55,math.random(90,110))
	timer.Simple(.75,function()
		if((IsValid(ply))and(ply:Alive()))then
			for k,v in pairs(ents.GetAll())do
				if((v.JModEZremoteTriggerFunc)and(v.Owner)and(v.Owner==ply))then
					v:JModEZremoteTriggerFunc(ply)
				end
			end
		end
	end)
end

hook.Add("PlayerCanSeePlayersChat","JMOD_PLAYERSEECHAT",function(txt,teamOnly,listener,talker)
	if((talker.EZarmor)and(talker.EZarmor.effects.teamComms))then
		return JMod_PlayersCanComm(listener,talker)
	end
end)

hook.Add("PlayerCanHearPlayersVoice","JMOD_PLAYERHEARVOICE",function(listener,talker)
	if((talker.EZarmor)and(talker.EZarmor.effects.teamComms))then
		return JMod_PlayersCanComm(listener,talker)
	end
end)

