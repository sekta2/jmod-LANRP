﻿local function SetArmorPlayerModelModifications()
	JMod.LuaConfig.ArmorOffsets["models/player/urban.mdl"] = {
		["GasMask"] = {
			siz = Vector(1, 1, 1),
			pos = Vector(0, 1.7, 0),
			ang = Angle(100, 180, 90)
		}
	}
end

function JMod.InitGlobalConfig(forceNew, configToApply)
	local NewConfig = {
		Note = "radio packages must have all lower-case names, see http://wiki.garrysmod.com/page/Enums/IN for key numbers",
		Info = {
			Author = "Jackarunda & Friends",
			Version = 49.6
		},
		General = {
			Hints = false,
			AltFunctionKey = IN_WALK,
			HandGrabStrength = 1,
			AllowScrounging = true
		},
		Armor = {
			ProtectionMult = 1,
			DegradationMult = 1,
			ChargeDepletionMult = 1,
			WeightMult = 0.7
		},
		Tools = {
			Medkit = {
				HealMult = 1
			},
			Toolbox = {
				DeWeldSpeed = 1,
				UpgradeMult = 1.7,
				DeconstructSpeedMult = 1,
				SalvagingBlacklist = {"func_", "ent_jack_gmod_ezcompactbox", "prop_ragdoll"}
			},
		},
		Weapons = {
			DamageMult = 1,
			SwayMult = 0.5,
			AmmoCarryLimitMult = 1,
			WeaponAmmoBlacklist = {"XBowBolt", "AR2AltFire"},
			AmmoTypesThatAreMunitions = {"RPG_Round", "RPG_Rocket", "SMG1_Grenade", "Grenade", "GrenadeHL1", "MP5_Grenade", "slam"},
			FlamethrowerFuelDrainMult = 1
		},
		Machines = {
			Sentry = {
				PerformanceMult = 1
			},
			MedBay = {
				HealMult = 1
			},
			Blackhole = {
				GeneratorChargeSpeed = 1,
				EvaporateSpeed = 1,
				MaxAge = 100,
				GravityStrength = 1,
				Whitelist = {"func_physbox", "func_breakable"},
				Blacklist = {"func_", "_dynamic"},
				DamageEnts = {"func_breakable"}
			},
			SpawnMachinesFull = false,
			SupplyEffectMult = 1,
			DurabilityMult = 1
		},
		Explosives = {
			Mine = {
				Delay = 1,
				Power = 1
			},
			Detpack = {
				PowerMult = 1
			},
			Nuke = {
				RangeMult = 1,
				PowerMult = 0.8,
				RadiationSickness = true
			},
			BombDisarmSpeed = 1,
			DoorBreachResetTimeMult = 1,
			FragExplosions = false,
			PropDestroyPower = 0.5,
			BombOwnershipLossOnRespawn = false
		},
		Particles = {
			VirusSpreadMult = 1,
			SludgeVirusInfectChance = 0.1,
			FumigatorGasAmount = 1,
			PoisonGasDamage = 1,
			PoisonGasLingerTime = 1,
			NuclearRadiationMult = 8
		},
		ResourceEconomy = {
			ResourceRichness = 3,
			ExtractionSpeed = 4,
			MaxResourceMult = 2,
			SalvageYield = 5,
			ScroungeAreaRefreshMult = 0.1,
			ScroungeCooldownMult = 0.3,
			ScroungeDespawnTimeMult = 0.3,
			ScroungeResultAmount = 10,
			ForceLoadAllResources = true,
			GrowthSpeedMult = 10,
			WaterRequirementMult = 1
		},
		QoL = {
			RealisticLocationalDamage = true,
			ExtinguishUnderwater = true,
			RealisticFallDamage = true,
			Drowning = true,
			GiveHandsOnSpawn = false,
			JModCorpseStayTime = 0,
			JModInvDropOnDeath = true,
			BleedDmgMult = 0,
			BleedSpeedMult = 0,
			NukeFlashLightEnabled = false,
			NiceFire = false,
			ChangePitchWithHostTimeScale = false,
			AllowActiveItemsInInventory = false,
			SeasonalEventsEnabled = false,
			InventorySizeMult = 1
		},
		FoodSpecs = {
			DigestSpeed = 1,
			ConversionEfficiency = 1,
			EatSpeed = 1,
			BoostMult = 2
		},
		RadioSpecs = {
			DeliveryTimeMult = 0.1,
			ParachuteDragMult = 2,
			StartingOutpostCount = 1,
			AvailablePackages = {
				-- How to use results in radio orders
				-- String names class
				-- String starting with FUNC direct to function
				-- Table of things spawns all of those things
				-- Table starting with RAND will take a random value from the rest of the table
				-- A table with the setup {class, number} will spawn that number of class
				-- If you add a second number to that table, if the class is an EZ resource, it will attempt to set the resource to that number
				--[[["arms"] = {
					description = "buncha random guns, good luck getting what you want.",
					category = "Weapons",
					results = {
						{"RAND", "ent_jack_gmod_ezweapon_ar", "ent_jack_gmod_ezweapon_br", "ent_jack_gmod_ezweapon_bar", "ent_jack_gmod_ezweapon_bas", "ent_jack_gmod_ezweapon_car", "ent_jack_gmod_ezweapon_pocketpistol", "ent_jack_gmod_ezweapon_plinkingpistol", "ent_jack_gmod_ezweapon_pistol", "ent_jack_gmod_ezweapon_smg", "ent_jack_gmod_ezweapon_machinepistol", "ent_tacrp_bekas", 3},
						{"ent_jack_gmod_ezammo", 2},
						"ent_jack_gmod_ezmunitions"
					}
				},]]
				["armor"] = {
					description = "A random collection of armor*.\n\n *LANRP INDUSTRIES outsources package sorting. We are not liable for any unusual items.",
					category = "Apparel",
					JBuxPrice = 300,
					results = {
						{"RAND", JMod.ArmorTable["GasMask"].ent, --[[JMod.ArmorTable["BallisticMask"].ent, JMod.ArmorTable["NightVisionGoggles"].ent, JMod.ArmorTable["ThermalGoggles"].ent, --[[JMod.ArmorTable["Respirator"].ent,]] JMod.ArmorTable["Light-Helmet"].ent, --[[JMod.ArmorTable["Medium-Helmet"].ent, JMod.ArmorTable["Heavy-Helmet"].ent, JMod.ArmorTable["Riot-Helmet"].ent, JMod.ArmorTable["Heavy-Riot-Helmet"].ent, JMod.ArmorTable["Ultra-Heavy-Helmet"].ent,]] JMod.ArmorTable["Metal Bucket"].ent, JMod.ArmorTable["Metal Pot"].ent, JMod.ArmorTable["Ceramic Pot"].ent, JMod.ArmorTable["Traffic Cone"].ent, JMod.ArmorTable["Light-Vest"].ent, --[[JMod.ArmorTable["Medium-Light-Vest"].ent, JMod.ArmorTable["Medium-Vest"].ent, JMod.ArmorTable["Medium-Heavy-Vest"].ent, JMod.ArmorTable["Heavy-Vest"].ent,]] JMod.ArmorTable["Pelvis-Panel"].ent, JMod.ArmorTable["Light-Left-Shoulder"].ent, JMod.ArmorTable["Heavy-Left-Shoulder"].ent, JMod.ArmorTable["Light-Right-Shoulder"].ent, JMod.ArmorTable["Heavy-Right-Shoulder"].ent, JMod.ArmorTable["Left-Forearm"].ent, JMod.ArmorTable["Right-Forearm"].ent, JMod.ArmorTable["Light-Left-Thigh"].ent, --[[JMod.ArmorTable["Heavy-Left-Thigh"].ent,]] JMod.ArmorTable["Light-Right-Thigh"].ent, --[[JMod.ArmorTable["Heavy-Right-Thigh"].ent,]] JMod.ArmorTable["Left-Calf"].ent, JMod.ArmorTable["Right-Calf"].ent, --[[JMod.ArmorTable["Hazmat Suit"].ent,]] 6}
					}
				},
				--[[["crossbow"] = {
					description = "A crossbow and 2 boxes of arrows, enjoy.",
					category = "Weapons",
					results = {
						{"ent_jack_gmod_ezammobox_a", 2},
						"ent_jack_gmod_ezweapon_crossbow"
					}
				},]]
				["basic parts"] = {
					description = "300 units of Basic Parts, used for most crafting and machine repairs.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezbasicparts", 3}
					}
				},
				["advanced parts"] = {
					description = "20 units of Advanced Parts, used for powerful crafting and upgrading.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezadvparts", 1, 20}
					}
				},
				["precision parts"] = {
					description = "80 units of Precision Parts, used for machine upgrading and various recipes.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezprecparts", 1, 150}
					}
				},
				["advanced textiles"] = {
					description = "100 units of Advanced Textiles, used for armor.",
					category = "Resources",
					results = "ent_jack_gmod_ezadvtextiles"
				},
				--[[["batteries"] = {
					description = "130 units of Power, used for crafting and recharging electronics.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezbattery", 4}
					}
				},]]
				["ammo"] = {
					description = "300 units of Ammo, for crafting and resupplying weapons and entities.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezammo", 3}
					}
				},
				-- ["coolant"] = {
				-- 	description = "500 units of Coolant, for preventing machines from overheating.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_ezcoolant", 5}
				-- 	}
				-- },
				["munitions"] = {
					description = "200 units of Munitions, used for crafting items and reloading explosive weapons and HE grenade sentries.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezmunitions", 2}
					}
				},
				["explosives"] = {
					description = "200 units of Explosives, used for crafting explosives.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezexplosives", 2}
					}
				},
				["chemicals"] = {
					description = "200 Units of Chemicals, used for crafting items and reloading filters in HAZMAT suits, gasmasks, and respirators.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezchemicals", 2}
					}
				},
				-- ["fuel"] = {
				-- 	description = "200 units of Fuel, used for crafting items and running generators.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_ezfuel", 2}
				-- 	}
				-- },
				["coal"] = {
					description = "300 units of Coal, used for running generators.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezcoal", 3}
					}
				},
				["propellant"] = {
					description = "400 units of Propellant, used for crafting items.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezpropellant", 4}
					}
				},
				["gas"] = {
					description = "300 units of Gas, used for crafting items and powering the EZ Workbench",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezgas", 3}
					}
				},
				["toolboxes"] = {
					description = "Два ящика с инструментами для изготовления, забивания гвоздей, спасения и упаковки предметов. ",
					category = "Tools",
					 JBuxPrice = 200,
					results = {
						{"ent_jack_gmod_eztoolbox", 2}
					}
				},
				--[[["rations"] = {
					description = "500 units of Nutrients, to be eaten by players. Can overcharge health.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_eznutrients", 5}
					}
				},]]
				["medical supplies"] = {
					description = "200 units of Medical Supplies, for resupplying the EZ Automated Field Hospital and EZ Medkit.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezmedsupplies", 2}
					}
				},
				["resource crate"] = {
					description = "A box used for exclusively storing EZ Resources.",
					category = "Other",
					JBuxPrice = 120,
					results = "ent_jack_gmod_ezcrate"
				},
				["storage crate"] = {
					description = "A box used exclusively for storing Jmod items. Can hold a volume of up to 100 units.",
					category = "Other",
					JBuxPrice = 150,
					results = "ent_jack_gmod_ezcrate_uni"
				},
				["sleeping bag"] = {
					description = "A sleeping bag you can set your spawn point at.",
					category = "Other",
					JBuxPrice = 200,
					results = {"ent_jack_sleepingbag", 2}
				},
				--[[["frag grenades"] = {
					description = "10 frag grenades used for explosions.",
					category = "Explosives",
					JBuxPrice = 500,
					results = {
						{"ent_jack_gmod_ezfragnade", 10}
					}
				},]]
				["flares"] = {
					description = "15 road flares used for signalling and illumination.",
					category = "Other",
					JBuxPrice = 160,
					results = {
						{"ent_jack_gmod_ezroadflare", 15}
					}
				},
				["glowsticks"] = {
					description = "20 glowsticks for identification, low-power illumination, and raves.",
					category = "Other",
					JBuxPrice = 90,
					results = {
						{"ent_jack_gmod_ezglowstick", 20}
					}
				},
				["first-aid kits"] = {
					description = "5 Individual First Aid Kits for stopping bleeding",
					category = "Other",
					JBuxPrice = 250,
					results = {
						{"ent_jack_gmod_ezifakpacket", 5}
					}
				},
				["gas grenades"] = {
					description = "6 gas grenades that can suffocate their victims.",
					category = "Explosives",
					JBuxPrice = 650,
					results = {
						{"ent_jack_gmod_ezgasnade", 6}
					}
				},
				["tear gas grenades"] = {
					description = "Tear gas used to disperse riots.",
					category = "Other",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezcsnade", 6}
					}
				},
				--[[["impact grenades"] = {
					description = "10 grenades that explode upon impact.",
					category = "Explosives",
					JBuxPrice = 500,
					results = {
						{"ent_jack_gmod_ezimpactnade", 10}
					}
				},]]
				--[[["incendiary grenades"] = {
					description = "6 grenades that produce fire upon explosion.",
					category = "Explosives",
					JBuxPrice = 700,
					results = {
						{"ent_jack_gmod_ezfirenade", 6}
					}
				},]]
				--[[["satchel charges"] = {
					description = "4 explosives with comical detonator plungers used for making things go boom.",
					category = "Explosives",
					JBuxPrice = 600,
					results = {
						{"ent_jack_gmod_ezsatchelcharge", 4}
					}
				},]]
				["sticky bomb"] = {
					description = "6 grenades that stick to things on contact.",
					category = "Explosives",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezstickynade", 6}
					}
				},
				--[[["mini grenades"] = {
					description = "5 impact, proximity, remote, and timed grenades. These can be attached to larger explosives to override their primary functions.",
					category = "Explosives",
					JBuxPrice = 700,
					results = {
						{"ent_jack_gmod_eznade_impact", 5},
						{"ent_jack_gmod_eznade_proximity", 5},
						{"ent_jack_gmod_eznade_remote", 5},
						{"ent_jack_gmod_eznade_timed", 5}
					}
				},]]
				["timebombs"] = {
					description = "Timed explosives with configurable timers. Can be defused with parts and Toolbox.",
					category = "Explosives",
					JBuxPrice = 1000,
					results = {
						{"ent_jack_gmod_eztimebomb", 3}
					}
				},
				--[[["hl2 ammo"] = {
					description = "An assortment of ammunition for keeping your men going during battle.",
					category = "Other",
					results = {
						"item_ammo_357", "item_ammo_357_large", "item_ammo_ar2", "item_ammo_ar2_large", {"item_ammo_ar2_altfire", 3},
						"item_ammo_crossbow", "item_ammo_pistol", "item_ammo_pistol_large", {"item_rpg_round", 3},
						"item_box_buckshot", "item_ammo_smg1", "item_ammo_smg1_large", {"item_ammo_smg1_grenade", 3},
						{"weapon_frag", 3}
					}
				},]]
				["seed kit"] = {
					description = "Assorted seeds and water for starting your farm",
					category = "Other",
					JBuxPrice = 150,
					results = {
						{"RAND", "ent_jack_gmod_ezacorn", "ent_jack_gmod_ezwheatseed", "ent_jack_gmod_ezcornkernals", 4},
						{"ent_jack_gmod_ezwater", 4}
					}
				},
				["farming tools"] = {
					description = "Tools for growing crops.",
					category = "Tools",
					JBuxPrice = 200,
					results = {
						{"ent_jack_gmod_ezaxe", 2}, {"ent_jack_gmod_ezshovel", 2}, {"ent_jack_gmod_ezbucket", 2}
					}
				},
				["sentry"] = {
					description = "Consumes ammo, power and coolant. Produces casualties.",
					category = "Machines",
					results = "ent_jack_gmod_ezsentry"
				},
				["supply radio"] = {
					description = "You're looking at one. No shame in having a backup radio.",
					category = "Machines",
					results = "ent_jack_gmod_ezaidradio"
				},
				["medkits"] = {
					description = "3 medical kits that use medical supplies to heal players.",
					category = "Tools",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezmedkit", 3}
					}
				},
				["landmines"] = {
					description = "10 landmines that trigger when an enemy steps near them.",
					category = "Explosives",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezlandmine", 10}
					}
				},

				["vechicle mines"] = {
					description = "10 vechicle mines that trigger when an enemy steps near them.",
					category = "Explosives",
					JBuxPrice = 800,
					results = {
						{"ent_jack_gmod_ezatmine", 5}
					}
				},
				["mini bounding mines"] = {
					description = "8 landmines that can only be planted in soft surfaces.",
					category = "Explosives",
					JBuxPrice = 400,
					results = {
						{"ent_jack_gmod_ezboundingmine", 8}
					}
				},
				["fumigators"] = {
					description = "2 fumigators that emit poison gas.",
					category = "Other",
					JBuxPrice = 4000,
					results = {
						{"ent_jack_gmod_ezfumigator", 2}
					}
				},
				["bioweapon canister"] = {
					description = "A canister of J.I.'s premier bioweapon, a lethal and infectious airborne pathogen that can cripple the enemy (or innocents) if they are not prepared.",
					JBuxPrice = 8000,
					category = "Other",
					results = "ent_jack_gmod_ezvirusbomb"
				},
				["fougasse mines"] = {
					description = "4 fougasse mines. Blasts napalm at whoever triggers it.",
					category = "Explosives",
					JBuxPrice = 750,
					results = {
						{"ent_jack_gmod_ezfougasse", 4}
					}
				},

				["war mines"] = {
					description = "4 war mines.",
					category = "Explosives",
					JBuxPrice = 680,
					results = {
						{"ent_jack_gmod_ezwarmine", 3}
					}
				},

				
				["detpacks"] = {
					description = "8 detpacks used for breaching doors and general explosive damage.",
					category = "Explosives",
					JBuxPrice = 600,
					results = {
						{"ent_jack_gmod_ezdetpack", 8}
					}
				},
				["slams"] = {
					description = "5 SLAMs that can be planted on walls.",
					category = "Explosives",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezslam", 5}
					}
				},
				["antimatter"] = {
					description = "100 units of Antimatter. Be careful with it, unless you want to evaporate your base!",
					category = "Resources",
					results = "ent_jack_gmod_ezantimatter"
				},
				["dynamite"] = {
					description = "12 dynamite sticks for comical explosions.",
					category = "Explosives",
					JBuxPrice = 400,
					results = {
						{"ent_jack_gmod_ezdynamite", 12}
					}
				},
				["flashbangs"] = {
					description = "8 flashbangs that stun targets.",
					category = "Other",
					JBuxPrice = 400,
					results = {
						{"ent_jack_gmod_ezflashbang", 8}
					}
				},
				["powder kegs"] = {
					description = "4 powder kegs for funny explosions.",
					category = "Explosives",
					JBuxPrice = 500,
					results = {
						{"ent_jack_gmod_ezpowderkeg", 4}
					}
				},
				["smoke grenades"] = {
					description = "4 smoke grenades to signal smokes and 4 signal grenades which emit a colourable smoke to help signal positions.",
					category = "Other",
					JBuxPrice = 300,
					results = {
						{"ent_jack_gmod_ezsmokenade", 4},
						{"ent_jack_gmod_ezsignalnade", 4}
					}
				},
				["stick grenades"] = {
					description = "4 German stick grenades and one big bundle of sticks to make a fabulous explosion.",
					category = "Explosives",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezsticknade", 4},
						"ent_jack_gmod_ezsticknadebundle"
					}
				},
				["mini claymores"] = {
					description = "4 small AP mines.",
					category = "Explosives",
					JBuxPrice = 500,
					results = {
						{"ent_jack_gmod_ezminimore", 4}
					}
				},
				["tnt"] = {
					description = "WW2-era explosives with fuse.",
					category = "Explosives",
					JBuxPrice = 600,
					results = {
						{"ent_jack_gmod_eztnt", 3}
					}
				},
				["thermal goggles"] = {
					description = "2 thermal goggles that highlight heat-sources for the user. Consumes battery.",
					category = "Apparel",
					JBuxPrice = 4000,
					results = {
						{"ent_jack_gmod_ezarmor_thermals", 2}
					}
				},
				--[[["night vision goggles"] = {
					description = "4 night-vision goggles to help players see in the dark. Consumes battery.",
					category = "Apparel",
					JBuxPrice = 600,
					results = {
						{"ent_jack_gmod_ezarmor_nvgs", 4}
					}
				},]]
				--[[["headsets"] = {
					description = "8 headsets for players to communicate and make orders from linked radios. Consumes battery.",
					category = "Apparel",
					JBuxPrice = 450,
					results = {
						{"ent_jack_gmod_ezarmor_headset", 8}
					}
				},]]
				["steel"] = {
					description = "500 units of Steel, used in basic parts and some weapons.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezsteel", 5}
					}
				},
				["copper"] = {
					description = "100 units of Copper, used in basic parts.",
					category = "Resources",
					results = "ent_jack_gmod_ezcopper"
				},
				-- ["aluminum"] = {
				-- 	description = "200 units of Aluminum, used in basic parts.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_ezaluminum", 2}
				-- 	}
				-- },
				-- ["lead"] = {
				-- 	description = "200 units of Lead, very useful in ammo production for fending off other players.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_ezlead", 2}
				-- 	}
				-- },
				["silver"] = {
					description = "50 units of Silver, used for high tier stuff.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezsilver", 1, 50}
					}
				},
				["gold"] = {
					description = "50 units of Gold, used in advanced parts.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezgold", 1, 50}
					}
				},
				-- ["titanium"] = {
				-- 	description = "50 units of Titanium, used in high-tier weaponry.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_eztitanium", 1, 50}
				-- 	}
				-- },
				["tungsten"] = {
					description = "100 units of Tungsten, used in high-tier weaponry.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_eztungsten", 1, 100}
					}
				},
				-- ["platinum"] = {
				-- 	description = "10 units of Platinum, used in advanced parts.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_ezplatinum", 1, 10}
				-- 	}
				-- },
				--[[["uranium"] = {
					description = "50 units of Uranium, used in fissile material enrichment.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezuranium", 1, 50}
					}
				},]]
				--[[["diamond"] = {
					description = "10 units of Diamond, used in advanced parts.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezdiamond", 1, 10}
					}
				},]]
				-- ["water"] = {
				-- 	description = "600 units of Water, used in coolant, chemicals, and nutrients.",
				-- 	category = "Resources",
				-- 	results = {
				-- 		{"ent_jack_gmod_ezwater", 6}
				-- 	}
				-- },
				["wood"] = {
					description = "200 units of Wood, used in paper and electricity production.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezwood", 2}
					}
				},
				["paper"] = {
					description = "200 units of Paper, used in nutrients.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezpaper", 2}
					}
				},
				["plastic"] = {
					description = "200 units of Plastic, used in basic parts.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezplastic", 2}
					}
				},
				["organics"] = {
					description = "200 units of Organics, used in nutrients.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezorganics", 2}
					}
				},
				["oil"] = {
					description = "100 units of Oil, used in plastic, fuel, and rubber.",
					category = "Resources",
					results = "ent_jack_gmod_ezoil"
				},
				["cloth"] = {
					description = "200 units of Cloth, used in advanced textiles.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezcloth", 2}
					}
				},
				["rubber"] = {
					description = "200 units of Rubber, used in basic parts.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezrubber", 2}
					}
				},


				["fulton-crate"] = {
					description = "Fulton balloon crate for exporting resources.",
					category = "JSurvival",
					JBuxFree = true,
					results = {"ent_aboot_jsmod_ezcrate_fulton"}
				},
			
			
			
				["airstrike hebombs"] = {
					description = "Бомбят!!!",
					category = "Airstrikes",
					JBuxPrice = 30000,
				},
			
				["airstrike smallbombs"] = {
					description = "Бомбят!!!",
					category = "Airstrikes",
					JBuxPrice = 35000,
				},
			
				["airstrike rockets"] = {
					description = "Бомбят!!!",
					category = "Airstrikes",
					JBuxPrice = 35000,
				},





				["global message"] = {
					description = "Глобальное послание всем фракциям",
					category = ".Squad",
					JBuxPrice = 5000,
				},
			
			
			
			
			
			
			
				["drill"] = {
					description = "Надо копать масштабно.",
					category = "Machines",
					results = "ent_jack_gmod_ezaugerdrill",
					JBuxPrice = 400,
				},
			
				["pump jack"] = {
					description = "Надо сосать масштабно.",
					category = "Machines",
					results = "ent_jack_gmod_ezpumpjack",
					JBuxPrice = 400,
				},
			
				["fabricator"] = {
					description = "Нано технологии.",
					category = "Machines",
					results = "ent_jack_gmod_ezfabricator",
					JBuxPrice = 10000,
				},

				["workbench"] = {
					description = "Нано технологии.",
					category = "Machines",
					results = "ent_jack_gmod_ezworkbench",
					JBuxPrice = 1000,
				},
			
				["solar generator"] = {
					description = "Бесконечный источник энергии.",
					category = "Machines",
					results = "ent_jack_gmod_ezsolargenerator",
					JBuxPrice = 500,
				},
			
				["fluid bottler"] = {
					description = "Бесконечный источник газа.",
					category = "Machines",
					results = "ent_jack_gmod_ezfluid_bottler",
					JBuxPrice = 500,
				},

				["sentry"] = {
					description = "Consumes ammo, power and coolant. Produces casualties.",
					category = "Machines",
					results = "ent_jack_gmod_ezsentry",
					JBuxPrice = 1000,
				},

				["supply radio"] = {
					description = "You're looking at one. No shame in having a backup radio.",
					category = "Machines",
					results = "ent_jack_gmod_ezaidradio",
					JBuxPrice = 300,
				},

				--[[["glass"] = {
					description = "200 units of Glass, used in basic parts.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezglass", 2}
					}
				},]]
				--[[["ceramic"] = {
					description = "200 units of Ceramic, used in armor.",
					category = "Resources",
					results = {
						{"ent_jack_gmod_ezceramic", 2}
					}
				},]]
			},
			RestrictedPackages = {"antimatter", "bioweapon canister"},
			RestrictedPackageShipTime = 600,
			RestrictedPackagesAllowed = true
		},
		Craftables = {
			-- How to use results in craftables
			-- String names class
			-- String starting with FUNC direct to function
			-- A table with the setup {class, number} will spawn that number of class
			-- If you add a second number to that table, if the class is an EZ resource, it will attempt to set the resource to that number
			
			-- Example Prop Craftable
			["EZ Nail"] = {
				results = "FUNC EZnail",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5
				},
				oneHanded = true,
				noSound = true,
				sizeScale = .05,
				category = "Tools",
				craftingType = "toolbox",
				description = "Binds the object you're looking at to the object behind it"
			},
			["EZ Bolt"] = {
				results = "FUNC EZbolt",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 8
				},
				oneHanded = true,
				noSound = true,
				sizeScale = .05,
				category = "Tools",
				craftingType = "toolbox",
				description = "Creates a single axis bearing for conecting rotating objects"
			},
			["EZ Box"] = {
				results = "FUNC EZbox",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15
				},
				noSound = true,
				sizeScale = 1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Stores the object you're looking at in a box for transportation or storage"
			},
			["EZ Rope"] = {
				results = "FUNC EZrope",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 2
				},
				oneHanded = true,
				noSound = true,
				sizeScale = 0.1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Attaches a rope between two points"
			},
			--[[["EZ Cable"] = {
				results = "FUNC EZcable",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 2
				},
				oneHanded = true,
				noSound = true,
				sizeScale = 0.1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Attaches a strong cable between two points, and creates an electrical connection"
			},]]
			["EZ Chain"] = {
				results = "FUNC EZchain",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 5
				},
				oneHanded = true,
				noSound = true,
				sizeScale = 0.1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Attaches a very strong chain between two points"
			},
			["EZ Ground Scanner"] = {
				results = "ent_jack_gmod_ezgroundscanner",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 50,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 50,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 25
				},
				sizeScale = 2,
				category = "Machines",
				craftingType = "toolbox",
				description = "Scans the ground for resource deposits when held still on solid ground. \nDoubles as a form of psychological torture."
			},
			["EZ Electric Winch"] = {
				results = "ent_jack_gmod_ezwinch",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 50
				},
				sizeScale = 1.5,
				category = "Machines",
				craftingType = "toolbox",
				description = "Allows you to move objects up and down with ease."
			},
			["EZ Solar Panel"] = {
				results = "ent_jack_gmod_ezsolargenerator",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					--[JMod.EZ_RESOURCE_TYPES.GLASS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.SILVER] = 100,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 100
				},
				sizeScale = 2,
				category = "Machines",
				craftingType = "toolbox",
				description = "Generates power when aimed at the map's 'sun'."
			},
			["EZ Automated Field Hospital"] = {
				results = "ent_jack_gmod_ezfieldhospital",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 100,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 100,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100
				},
				sizeScale = 4,
				category = "Machines",
				craftingType = "toolbox",
				description = "Heals players so you don't have to get more blood on you."
			},
			["EZ Smelting Furnace"] = {
				results = "ent_jack_gmod_ezfurnace",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 200,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 200,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 25
				},
				sizeScale = 2,
				category = "Machines",
				craftingType = "toolbox",
				description = "Uses flex-fuel technology to refine ores into their respective ingots."
			},
			["EZ Oil Refinery"] = {
				results = "ent_jack_gmod_ezrefinery",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 200,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100
				},
				sizeScale = 5,
				category = "Machines",
				craftingType = "toolbox",
				description = "Performs fractional distillation of crude oil, creating fuel, plastic, rubber, and gas."
			},
			["EZ Power Bank"] = {
				results = "ent_jack_gmod_ezpowerbank",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 25,
				},
				sizeScale = 5,
				category = "Machines",
				craftingType = "toolbox",
				description = "Allows for power-grid construction by linking machines that either consume or produce EZ power."
			},
			["EZ Oil Rig"] = {
				results = "ent_jack_gmod_ezoil_rig",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 75,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 500,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100
				},
				sizeScale = 5,
				category = "Machines",
				craftingType = "toolbox",
				description = "A buoyant version of the EZ Pumpjack that allows for pumping oil deposits located underwater.\n Must be floating directly over an oil deposit to use."
			},
			["EZ Uranium Enrichment Centrifuge"] = {
				results = "ent_jack_gmod_ezcentrifuge",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 400,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 400,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 200,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100
				},
				sizeScale = 5,
				category = "Machines",
				craftingType = "toolbox",
				description = "Turns uranium into fissile material"
			},
			["EZ Liquid Fuel Generator"] = {
				results = "ent_jack_gmod_ezlfg",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 200,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.OIL] = 20
				},
				sizeScale = 2,
				category = "Machines",
				craftingType = "toolbox",
				description = "Produces Power from Fuel. Very noisy."
			},
			["EZ Bomb Bay"] = {
				results = "ent_jack_gmod_ezbombbay",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 400,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20
				},
				sizescale = 4,
				category = "Other",
				craftingType = "toolbox",
				description = "A bay for safely holding large amounts of bombs."
			},
			["EZ Big Bomb"] = {
				results = "ent_jack_gmod_ezbigbomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 400,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 400
				},
				sizescale = 2,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Bigger than the EZ Bomb, but smaller than the Mega."
			},
			["EZ Bomb"] = {
				results = "ent_jack_gmod_ezbomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 250,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 250
				},
				sizescale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Ol' reliable, a good way to send the enemy running for the bunkers."
			},
			["EZ Thin-Skinned Bomb"] = {
				results = "ent_jack_gmod_ezhebomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100
				},
				sizescale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Standard HE bomb with a very thin shell that produces no significant fragmentation."
			},
			["EZ Torpedo"] = {
				results = "ent_jack_gmod_eztorpedo",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 50,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 250,
					[JMod.EZ_RESOURCE_TYPES.GAS] = 100
				},
				sizescale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "The shark of death, travels in a straight path via gas propeller."
			},
			["EZ Cluster Bomb"] = {
				results = "ent_jack_gmod_ezclusterbomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 150
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "For when you need to send hundreds of tiny bombs rather than a big one."
			},
			["EZ Cluster Buster"] = {
				results = "ent_jack_gmod_ezclusterbuster",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 200,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 300
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Cluster bomb that can pierce multiple hard targets from the air."
			},
			["EZ War Mine"] = {
				results = "ent_jack_gmod_ezwarmine",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 25
				},
				sizeScale = 1,
				category = "Munitions",
				craftingType = "workbench",
				description = "Smart perimeter defense mine that warns the user of approaching enemies. Will explode violently when angered enough."
			},
			["EZ General Purpose Crate"] = {
				results = "ent_jack_gmod_ezcrate_uni",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 50
				},
				sizeScale = 1,
				category = "Other",
				craftingType = "toolbox",
				description = "It's a box, tap it with whatever you want to store. Only works with JMod items."
			},
			["EZ HE Rocket"] = {
				results = "ent_jack_gmod_ezherocket",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 50,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 50
				},
				sizescale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Pointy end goes forward towards soon to be explosion. Stay away from rear unless you want 3rd degree burns."
			},
			["EZ HEAT Rocket"] = {
				results = "ent_jack_gmod_ezheatrocket",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 50,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 50
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "EZ HE Rocket, except it's a lot more effective against armored vehicles with less boom."
			},
			["EZ Rocket Motor"] = {
				results = "ent_jack_gmod_ezrocketmotor",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.PAPER] = 20,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 50
				},
				sizeScale = 1,
				category = "Other",
				craftingType = "workbench",
				description = "Attach to an object and launch to propell it away."
			},
			["EZ Firework Rocket"] = {
				results = "ent_jack_gmod_ezfirework",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 10,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 30,
					[JMod.EZ_RESOURCE_TYPES.PAPER] = 20
				},
				sizeScale = .1,
				category = "Other",
				craftingType = "workbench",
				description = "Firework to celebrate the holidays with.\n Or set stuff on fire."
			},
			["EZ Rocket Pod"] = {
				results = "ent_jack_gmod_ezrocketpod",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 130,
					--[JMod.EZ_RESOURCE_TYPES.ALUMINUM] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10
				},
				sizeScale = 1,
				category = "Other",
				craftingType = "toolbox",
				description = "Allows you to load multiple rockets\n and launch them in a reliable way."
			},
			["EZ Incendiary Bomb"] = {
				results = "ent_jack_gmod_ezincendiarybomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 200,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 20
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Fire bomb. Detonates in the air to ensure max spread of napalm."
			},
			["EZ Gas Bomb"] = {
				results = "ent_jack_gmod_ezchlorinebomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 700,
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Gas bomb."
			},
			["EZ Mega Bomb"] = {
				results = "ent_jack_gmod_ezmoab",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 380,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 1200
				},
				sizeScale = 4,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Anything on the surface of the enemy bunker is gonna be gone, and they'll need to cleanup the bunker."
			},
			["EZ Micro Black Hole Generator"] = {
				results = "ent_jack_gmod_ezmbhg",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 400,
					[JMod.EZ_RESOURCE_TYPES.ANTIMATTER] = 25
				},
				sizeScale = 2,
				category = "Machines",
				craftingType = "toolbox",
				description = "Takes a couple minutes to spin up, and then creates an impossibly weak black hole that scales with time."
			},
			["EZ Micro Nuclear Bomb"] = {
				results = "ent_jack_gmod_eznuke",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 300,
					[JMod.EZ_RESOURCE_TYPES.FISSILEMATERIAL] = 35
				},
				sizeScale = 2,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Powerful nuclear weapon that will easily level a large portion of the map."
			},
			["EZ Nuclear Rocket"] = {
				results = "ent_jack_gmod_eznukerocket",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 300,
					[JMod.EZ_RESOURCE_TYPES.FISSILEMATERIAL] = 35,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 300
				},
				sizeScale = 4,
				category = "Explosives",
				craftingType = "toolbox",
				description = "High velocity map deletion."
			},
			["EZ Mini Naval Mine"] = {
				results = "ent_jack_gmod_eznavalmine",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 200
				},
				sizeScale = 2,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Ships beware! This mine is ready to send em to Davy Jones' locker!"
			},
			["EZ Nano Nuclear Bomb"] = {
				results = "ent_jack_gmod_eznuke_small",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100,
					[JMod.EZ_RESOURCE_TYPES.FISSILEMATERIAL] = 15
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Weak nuclear bomb, though easily transportable."
			},
			["EZ Resource Crate"] = {
				results = "ent_jack_gmod_ezcrate",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 100
				},
				sizeScale = 2,
				category = "Other",
				craftingType = "toolbox",
				description = "Store your resources here for clean organization and automatic pulling when crafting."
			},
			["EZ Shipping Container"] = {
				results = "ent_aboot_gmod_ezshippingcontainer",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 700
				},
				sizeScale = 2,
				category = "Other",
				craftingType = "toolbox",
				description = "Store your resources here for clean organization and automatic pulling when crafting."
			},
			["EZ Ezutility Crate"] = {
				results = "ent_fumo_gmod_ezutilitycrate",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 200
				},
				sizeScale = 2,
				category = "Other",
				craftingType = "toolbox",
				description = "Store your resources here for clean organization and automatic pulling when crafting."
			},
			["EZ Fuel Lantern"] = {
				results = "ent_jack_gmod_ezfuellantern",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 10
				},
				sizeScale = 0.5,
				category = "Other",
				craftingType = {"workbench", "craftingtable"},
				description = "Produces light when fuelled and ignited."
			},
			["EZ Sentry"] = {
				results = "ent_jack_gmod_ezsentry",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 100,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				sizeScale = 1,
				category = "Machines",
				craftingType = "toolbox",
				description = "Shoots enemies so you don't have to! Just remember to refill the ammo and power."
			},
			["EZ Small Bomb"] = {
				results = "ent_jack_gmod_ezsmallbomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100
				},
				sizeScale = 1.5,
				category = "Explosives",
				craftingType = "toolbox",
				description = "A small alternative to the EZ Bomb, it has airbrakes for low altitude bombing."
			},
			["EZ Supply Radio"] = {
				results = "ent_jack_gmod_ezaidradio",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 50,
					--[JMod.EZ_RESOURCE_TYPES.GLASS] = 5
				},
				sizeScale = 1,
				category = "Machines",
				craftingType = "toolbox",
				description = "Order more supplies for free. Just place it outside and watch for the package."
			},
			["EZ Thermobaric Bomb"] = {
				results = "ent_jack_gmod_ezthermobaricbomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 20,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 300
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Bunker buster, will cause more damage if you place it indoors."
			},
			["EZ Thermonuclear Bomb"] = {
				results = "ent_jack_gmod_eznuke_big",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 400,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 600,
					[JMod.EZ_RESOURCE_TYPES.FISSILEMATERIAL] = 75
				},
				sizeScale = 1,
				category = "Explosives",
				craftingType = "toolbox",
				description = "Now we are all sons of bitches."
			},
			["EZ Vehicle Mine"] = {
				results = "ent_jack_gmod_ezatmine",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 40,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100
				},
				sizeScale = .75,
				category = "Explosives",
				craftingType = "toolbox",
				description = "A good way of stopping enemy vehicles from passing through."
			},
			["EZ Workbench"] = {
				results = "ent_jack_gmod_ezworkbench",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 400,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 100,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				sizeScale = 3,
				category = "Machines",
				craftingType = "toolbox",
				description = "Craft all your smaller items here."
			},
			["EZ Fabricator"] = {
				results = "ent_jack_gmod_ezfabricator",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 500,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 700,
					--[JMod.EZ_RESOURCE_TYPES.TITANIUM] = 200,
					--[JMod.EZ_RESOURCE_TYPES.GLASS] = 100
				},
				sizeScale = 3,
				category = "Machines",
				craftingType = "toolbox",
				description = "Highly advanced machine used for manufacturing Parts."
			},
			["EZ Pumpjack"] = {
				results = "ent_jack_gmod_ezpumpjack",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 200,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				sizeScale = 10,
				category = "Machines",
				craftingType = "toolbox",
				description = "A pump for extracting liquids from the ground."
			},
			["EZ Auger Drill"] = {
				results = "ent_jack_gmod_ezaugerdrill",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 100,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 25,
					--[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 25
				},
				sizeScale = 10,
				category = "Machines",
				craftingType = "toolbox",
				description = "A drill for extracting ores from the ground."
			},
			["EZ Geothermal Generator"] = {
				results = "ent_jack_gmod_ezgeothermalgenerator",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 400,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 200
				},
				sizeScale = 10,
				category = "Machines",
				craftingType = "toolbox",
				description = "Bulky machine for utilizing geothermal deposits, and creating power from them."
			},
			["EZ Fluid Bottler"] = {
				results = "ent_jack_gmod_ezfluid_bottler",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 200,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 50
				},
				sizeScale = 8,
				category = "Machines",
				craftingType = "toolbox",
				description = "Machine for compressing air into EZ gas and bottling water. \nAlso cleans the air of toxins and radioactive fallout."
			},
			["EZ Solid Fuel Generator"] = {
				results = "ent_jack_gmod_ezsfg",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 250,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 50,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 100
				},
				sizeScale = 8,
				category = "Machines",
				craftingType = "toolbox",
				description = "Generator that uses coal or wood to heat water to produce power."
			},
			["EZ Radioisotope Thermoelectric Generator"] = {
				results = "ent_jack_gmod_ezrtg",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.ALUMINUM] = 100,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.URANIUM] = 150
				},
				sizeScale = 6,
				category = "Machines",
				craftingType = "toolbox",
				description = "Generator that uses radioactive decay to slowly create power.\nWorks just about anywhere."
			},
			["EZ Sprinkler"] = {
				results = "ent_jack_gmod_ezsprinkler",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 20,
				},
				sizeScale = 5,
				category = "Machines",
				craftingType = "toolbox",
				description = "Machine for watering trees and other EZ crops."
			},
			--[[["HL2 Buggy"] = {
				results = "FUNC spawnHL2buggy",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 50,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.AMMO] = 200
				},
				sizeScale = 4,
				category = "Other",
				craftingType = "toolbox",
				description = "Gordon, remember to bring back the scout car."
			},]]
			["EZ Basic Parts, x50"] = {
				results = {"ent_jack_gmod_ezbasicparts", 1, 50},
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 40,
					--[JMod.EZ_RESOURCE_TYPES.ALUMINUM] = 15,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 10,
					--[JMod.EZ_RESOURCE_TYPES.GLASS] = 5,
					--[JMod.EZ_RESOURCE_TYPES.COPPER] = 15,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 5
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "50 basic parts used for crafting and repairs."
			},
			["EZ Basic Parts, x100"] = {
				results = "ent_jack_gmod_ezbasicparts",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 60,
					--[JMod.EZ_RESOURCE_TYPES.ALUMINUM] = 20,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 20,
					--[JMod.EZ_RESOURCE_TYPES.GLASS] = 10,
					--[JMod.EZ_RESOURCE_TYPES.COPPER] = 20,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 10
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "1 box of parts used for crafting and repairs."
			},
			["EZ Basic Parts, x300"] = {
				results = {"ent_jack_gmod_ezbasicparts", 3},
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 180,
					--[JMod.EZ_RESOURCE_TYPES.ALUMINUM] = 60,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 60,
					--[JMod.EZ_RESOURCE_TYPES.GLASS] = 30,
					--[JMod.EZ_RESOURCE_TYPES.COPPER] = 60,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 30
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "3 boxes of parts used for crafting and repairs."
			},
			["EZ Precision Parts, x100"] = {
				results = "ent_jack_gmod_ezprecparts",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 20,
					--[JMod.EZ_RESOURCE_TYPES.TITANIUM] = 20,
					--[JMod.EZ_RESOURCE_TYPES.SILVER] = 30,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 20
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "1 box of precision parts used for use in high-powered machines and weapons."
			},
			["EZ Precision Parts, x10"] = {
				results = {"ent_jack_gmod_ezprecparts", 1, 10},
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 2,
					--[JMod.EZ_RESOURCE_TYPES.TITANIUM] = 2,
					--[JMod.EZ_RESOURCE_TYPES.SILVER] = 3,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 2
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "10 precision parts used for use in high-powered machines and weapons."
			},
			["EZ Advanced Parts, x50"] = {
				results = {"ent_jack_gmod_ezadvparts", 1, 50},
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.GOLD] = 40,
					--[JMod.EZ_RESOURCE_TYPES.DIAMOND] = 20,
					--[JMod.EZ_RESOURCE_TYPES.PLATINUM] = 40
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "50 Advanced Parts for use in hyper-advanced technology"
			},
			["EZ Advanced Parts, x5"] = {
				results = {"ent_jack_gmod_ezadvparts", 1, 5},
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.GOLD] = 4,
					--[JMod.EZ_RESOURCE_TYPES.DIAMOND] = 2,
					--[JMod.EZ_RESOURCE_TYPES.PLATINUM] = 4
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "5 Advanced Parts for use in hyper-advanced technology"
			},
			["EZ Advanced Textiles"] = {
				results = "ent_jack_gmod_ezadvtextiles",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 100,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 20,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 20
				},
				category = "Resources",
				craftingType = {"workbench", "fabricator"},
				description = "Advanced fabrics for use in high-tier clothing."
			},
			["EZ Chemicals"] = {
				results = "ent_jack_gmod_ezchemicals",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ORGANICS] = 50,
					[JMod.EZ_RESOURCE_TYPES.GAS] = 100,
					[JMod.EZ_RESOURCE_TYPES.WATER] = 50
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Caustic burns and choking smoke."
			},
			["EZ Ammo"] = {
				results = "ent_jack_gmod_ezammo",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 50,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 25
				},
				category = "Resources",
				craftingType = "workbench",
				description = "General purpose bullets. Don't ask how we got so many types of ammo in one box."
			},
			["EZ Paper"] = {
				results = "ent_jack_gmod_ezpaper",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 30,
					[JMod.EZ_RESOURCE_TYPES.WATER] = 70
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Writing material that can be used for more malicious purposes."
			},
			["EZ Cloth"] = {
				results = "ent_jack_gmod_ezcloth",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ORGANICS] = 50,
					[JMod.EZ_RESOURCE_TYPES.WATER] = 20
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Mysterious fabrication of fabric from edible organics. Don't ask how."
			},
			["EZ Black Powder Paper Cartridges"] = {
				results = "ent_jack_gmod_ezammobox_bppc",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.PAPER] = 17,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 15,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 10
				},
				category = "Weapons",
				craftingType = {"workbench", "craftingtable"},
				description = "Ancient black powder ammo for the similarly ancient guns."
			},
			--[[["EZ Arrows"] = {
				results = "ent_jack_gmod_ezammobox_a",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 15,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 15
				},
				category = "Resources",
				craftingType = "workbench",
				description = "Modern broadhead hunting arrows for cheap armor-piercing capability."
			},]]
			["EZ Flintlock Musket"] = {
				results = JMod.WeaponTable["Flintlock Musket"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 25,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 25
				},
				category = "Weapons",
				craftingType = {"workbench", "craftingtable"},
				description = "Cumbersome musket that comes with a bayonet."
			},
			--[[["EZ Flintlock Blunderbuss"] = {
				results = JMod.WeaponTable["Flintlock Blunderbuss"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 25,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 25
				},
				category = "Weapons",
				craftingType = {"workbench", "craftingtable"},
				description = "Prehistoric shotgun that you can delete enemies with! (unless they have armor)"
			},]]
			["EZ Cap and Ball Revolver"] = {
				results = JMod.WeaponTable["Cap and Ball Revolver"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 10,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 5
				},
				category = "Weapons",
				craftingType = {"workbench", "craftingtable"},
				description = "A very inaccurate, outdated revolver. Fires 6 shots."
			},
			["EZ Break-Action Shotgun"] = {
				results = JMod.WeaponTable["Break-Action Shotgun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 25
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A double barrel O/U shotgun."
			},
			["EZ Revolver"] = {
				results = JMod.WeaponTable["Revolver"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 5
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A simple revolver. Fires 6 shots"
			},
			["EZ Single-Shot Rifle"] = {
				results = JMod.WeaponTable["Single-Shot Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 75,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 25
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A simple rifle. Fires one bullet at a time."
			},
			--[[["EZ Crossbow"] = {
				results = JMod.WeaponTable["Crossbow"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A crossbow. Can be very efficient if you hit all your shots."
			},]]
			-- ["EZ Bolt-Action Rifle"] = {
			-- 	results = JMod.WeaponTable["Bolt-Action Rifle"].ent,
			-- 	craftingReqs = {
			-- 		[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 125
			-- 	},
			-- 	category = "Weapons",
			-- 	craftingType = "workbench",
			-- 	description = "A bolt action rifle. First practical high-power repeating rifle."
			-- },
			["EZ Lever-Action Carbine"] = {
				results = JMod.WeaponTable["Brush Gun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 20
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A Lever action carbine, less power than bolt action rifle, but more ammo."
			},
			["EZ Magnum Revolver"] = {
				results = JMod.WeaponTable["Magnum Revolver"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 75,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 10
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "Revolver, but with a more powerful round."
			},
			["EZ Pump-action Shotgun"] = {
				results = JMod.WeaponTable["Pump-Action Shotgun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 125,
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "Pump action shotgun, More shotgun shells."
			},
			["EZ Shot Revolver"] = {
				results = JMod.WeaponTable["Shot Revolver"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "Small shotgun, ready to tear faces off at very close range."
			},
			["EZ Grenade Launcher"] = {
				results = JMod.WeaponTable["Grenade Launcher"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 125,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 10
				},
				category = "Weapons",
				craftingType = {"fabricator"},
				description = "First grenade launcher. A single grenade to turn shit into scrap."
			},
			["EZ Pistol"] = {
				results = JMod.WeaponTable["Pistol"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 75,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 35
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A pistol. Great sidearm to have."
			},
			["EZ Plinking Pistol"] = {
				results = JMod.WeaponTable["Plinking Pistol"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 10
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A plinking pistol. Great if you want to deal with that bird that's annoying you."
			},
			["EZ Sniper Rifle"] = {
				results = JMod.WeaponTable["Sniper Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A sniper rifle. Pick off targets at long range."
			},
			["EZ Pocket Pistol"] = {
				results = JMod.WeaponTable["Pocket Pistol"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 10
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A pocket pistol. It's concealable, allowing you to seem unarmed to others."
			},
			["EZ Anti-Materiel Sniper Rifle"] = {
				results = JMod.WeaponTable["Anti-Materiel Sniper Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "An Anti-materiel sniper rifle. Use to obliterate your enemies and their property at long range."
			},
			["EZ Assault Rifle"] = {
				results = JMod.WeaponTable["Assault Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 125,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "An assault rifle. Reliable automatic rifle to dispatch assailants at medium range."
			},
			["EZ Battle Rifle"] = {
				results = JMod.WeaponTable["Battle Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A battle rifle. Powerful semi-auto rifle to dispatch assailants at medium range."
			},
			--[[["EZ Carbine"] = {
				results = JMod.WeaponTable["Carbine"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A carbine. Like the assault rifle, but with a shorter barrel."
			},]]
			["EZ Designated Marksman Rifle"] = {
				results = JMod.WeaponTable["Designated Marksman Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 35
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A designated marksman rifle. Strong semi-auto rifle equipped with a scope for long range target removal."
			},
			["EZ Machine Pistol"] = {
				results = JMod.WeaponTable["Machine Pistol"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 75,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A machine pistol. Extremely fast automatic pistol for short range encounters."
			},
			["EZ Magnum Pistol"] = {
				results = JMod.WeaponTable["Magnum Pistol"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 75,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A magnum pistol. Strong semi-auto pistol."
			},
			["EZ Submachine Gun"] = {
				results = JMod.WeaponTable["Sub Machine Gun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 125,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A submachine gun. Fast automatic SMG for short-medium range engagements."
			},
			["EZ Semiautomatic Shotgun"] = {
				results = JMod.WeaponTable["Semi-Automatic Shotgun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A semi-automatic shotgun. Fast firing tube-fed shotgun for close range battle."
			},
			["EZ Rocket Launcher"] = {
				results = JMod.WeaponTable["Rocket Launcher"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50
				},
				category = "Weapons",
				craftingType = {"fabricator"},
				description = "A rocket launcher. Launches rockets. What else did you think it did?"
			},
			["EZ Fully-Automatic Shotgun"] = {
				results = JMod.WeaponTable["Fully-Automatic Shotgun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 125,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 75
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A fully-automatic shotgun. Fast firing magazine-fed automatic shotgun for close range deletion."
			},
			["EZ Light Machine Gun"] = {
				results = JMod.WeaponTable["Light Machine Gun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 25
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A light machine gun. Fast firing LMG capable of laying down suppressive fire at medium range."
			},
			["EZ Medium Machine Gun"] = {
				results = JMod.WeaponTable["Medium Machine Gun"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 125,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 25
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A medium machine gun. Powerful machine gun with decent fire rate for dealing serious damage."
			},
			["EZ Anti-Materiel Rifle"] = {
				results = JMod.WeaponTable["Anti-Materiel Rifle"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 250,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "An Anti-materiel rifle. Use to obliterate your enemies and their property in quick succession."
			},
			["EZ Multiple Grenade Launcher"] = {
				results = JMod.WeaponTable["Multiple Grenade Launcher"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A Multiple Grenade Launcher. Use wisely to wreak havoc at close-medium range."
			},
			["EZ Multiple Rocket Launcher"] = {
				results = JMod.WeaponTable["Multiple Rocket Launcher"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 250,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 50
				},
				category = "Weapons",
				craftingType = "fabricator",
				description = "A Multiple Rocket Launcher. The holy grail. Use this to strike down the deserving."
			},
			["EZ Flamethrower"] = {
				results = "ent_jack_gmod_ezarmor_flametank",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 50,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 25,
					[JMod.EZ_RESOURCE_TYPES.GAS] = 100,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 100
				},
				category = "Weapons",
				craftingType = "workbench",
				description = "A flamethrower. Use to burn your enemies to ashes."
			},
			["EZ Toolbox"] = {
				results = "ent_jack_gmod_eztoolbox",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50
				},
				noRequirementScaling = true,
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "Стройте, модернизируйте, спасайте. Все, что нужно для создания больших машин."
			},
			["EZ Chemical Power"] = {
				results = "ent_jack_gmod_ezbattery",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 20,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 20,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 5
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Uses a chemical reaction to give you 100 power"
			},
			["EZ Electrolysis Gas"] = {
				results = {"ent_jack_gmod_ezgas", 1, 50},
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.POWER] = 50,
					[JMod.EZ_RESOURCE_TYPES.WATER] = 50
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Uses a chemical reaction to give you 50 gas"
			},
			["EZ Pick Axe"] = {
				results = "ent_jack_gmod_ezpickaxe",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 25,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 30
				},
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "I am a dwarf and I'm digging in a hole"
			},
			["EZ Axe"] = {
				results = "ent_jack_gmod_ezaxe",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 15,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 25
				},
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "Я должен найти в себе маленького дровосека!"
			},
			["EZ Shovel"] = {
				results = "ent_jack_gmod_ezshovel",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 12,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 15
				},
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "Дай мне лопату, и я дам тебе копыто."
			},
			["Binoculars"] = {
				results = "binocle",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 20,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20
				},
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "Смотри в даль и не промахнись"
			},
			["Trench Whistle"] = {
				results = "weapon_trenchwhistle",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 20,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20
				},
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "В АТАААААКУ"
			},
			["EZ Bucket"] = {
				results = "ent_jack_gmod_ezbucket",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 20
				},
				category = "Tools",
				craftingType = {"craftingtable", "workbench"},
				description = "Я мудро набираю воду в ведро."
			},
			["EZ Detpack"] = {
				results = "ent_jack_gmod_ezdetpack",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 25
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Универсальный инструмент для взлома."
			},
			["EZ Dynamite"] = {
				results = "ent_jack_gmod_ezdynamite",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.PAPER] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Хорошо подходит для взрывных работ и подрыва идиотов."
			},
			["EZ Explosives"] = {
				results = "ent_jack_gmod_ezexplosives",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 100
				},
				category = "Resources",
				craftingType = "workbench",
				description = "Ни одна бомба не обходится без взрывчатки!"
			},
			["EZ Flashbang"] = {
				results = "ent_jack_gmod_ezflashbang",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 5,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 5
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Отвернитесь, если не хотите быть ослепленными."
			},
			["EZ Fougasse Mine"] = {
				results = "ent_jack_gmod_ezfougasse",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 100,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Направьте огонь на легковоспламеняющиеся цели."
			},
			--[[["EZ Fragmentation Grenade"] = {
				results = "ent_jack_gmod_ezfragnade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Frag nade, for sending hundreds of fragments into your enemy."
			},]]
			["EZ Criticality Weapon"] = {
				results = "ent_jack_gmod_ezcriticalityweapon",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.FISSILEMATERIAL] = 25,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 100
				},
				sizeScale = 1,
				category = "Other",
				craftingType = "workbench",
				description = "Говорят, Слотин часто появлялся в своих фирменных синих джинсах и ковбойских сапогах..."
			},
			["EZ Road Flare"] = {
				results = "ent_jack_gmod_ezroadflare",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 5,
					[JMod.EZ_RESOURCE_TYPES.PAPER] = 10,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 5
				},
				category = "Other",
				craftingType = "workbench",
				description = "Цветные дорожные ракеты, для сигнализации и освещения."
			},
			["EZ Glow Stick"] = {
				results = "ent_jack_gmod_ezglowstick",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 5,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 5
				},
				category = "Other",
				craftingType = "workbench",
				description = "Цветная светящаяся палочка для идентификации, маломощной подсветки и рейвов."
			},
			["EZ IFAK Packet"] = {
				results = "ent_jack_gmod_ezifakpacket",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.MEDICALSUPPLIES] = 5,
				},
				category = "Other",
				craftingType = "workbench",
				description = "Индивидуальная аптечка для остановки кровотечения."
			},
			["EZ Fumigator"] = {
				results = "ent_jack_gmod_ezfumigator",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.GAS] = 200,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 500
				},
				category = "Other",
				craftingType = "workbench",
				description = "Давайте, рассказывайте свои шутки про Гитлера. Мы подождем."
			},
			["EZ Gas Grenade"] = {
				results = "ent_jack_gmod_ezgasnade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.GAS] = 20,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 20
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Портативный способ отравления врагов газом."
			},
			["EZ Tear Gas Grenade"] = {
				results = "ent_jack_gmod_ezcsnade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.GAS] = 20,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Эффективное ограничение зоны поражения для тех, у кого нет противогазов. Может стать военным преступлением."
			},
			["EZ Gebalte Ladung"] = {
				results = "ent_jack_gmod_ezsticknadebundle",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 50
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Очень тяжелая и очень взрывоопасная граната-палка."
			},
			--[[["EZ Impact Grenade"] = {
				results = "ent_jack_gmod_ezimpactnade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 15
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "For the aggressive type. Explodes on impact."
			},]]
			["EZ Incendiary Grenade"] = {
				results = "ent_jack_gmod_ezfirenade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 30
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Портативная огненная бомба, попробуйте приготовить ее перед броском, чтобы она больше распространилась."
			},
			["EZ Landmine"] = {
				results = "ent_jack_gmod_ezlandmine",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Противопехотная мина. Постарайтесь, чтобы цвет совпадал с цветом земли."
			},
			["EZ Bear Trap"] = {
				results = "ent_jack_gmod_ezbeartrap",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15
				},
				category = "Other",
				craftingType = "workbench",
				description = "Основная ловушка для ловли/замедления врагов.\n Постарайтесь, чтобы цвет совпадал с цветом земли."
			},
			["EZ Sleeping Bag"] = {
				results = "ent_jack_sleepingbag",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 1,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 100
				},
				sizeScale = 1,
				category = "Other",
				craftingType = {"toolbox", "workbench", "craftingtable"},
				description = "Спальный мешок, в котором можно установить точку спавна."
			},
			["EZ Ballistic Mask"] = {
				results = JMod.ArmorTable["BallisticMask"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Защита лица для самовлюбленных."
			},
			["EZ Gas Mask"] = {
				results = JMod.ArmorTable["GasMask"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 10,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Защитите себя от военных преступлений врагов."
			},
			--[[["EZ Headset"] = {
				results = JMod.ArmorTable["Headset"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.COPPER] = 5
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Гарнитура, позволяющая удаленно общаться с рациями и друзьями."
			},]]
			["EZ Heavy Left Shoulder Armor"] = {
				results = JMod.ArmorTable["Heavy-Left-Shoulder"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 20,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Вы должны заботиться о своих плечах, если носите это."
			},
			["EZ Heavy Right Shoulder Armor"] = {
				results = JMod.ArmorTable["Heavy-Right-Shoulder"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 20,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 20,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Вы должны заботиться о своих плечах, если носите это."
			},
			["EZ Heavy Torso Armor"] = {
				results = JMod.ArmorTable["Heavy-Vest"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 50,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 50
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Черепаший панцирь. Тяжелая защита."
			},
			["BUCKET"] = {
				results = JMod.ArmorTable["Metal Bucket"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 20
				},
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "я умний, нодел ведро на галаву для зощиты."
			},
			["CONE"] = {
				results = JMod.ArmorTable["Traffic Cone"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 10,
					[JMod.EZ_RESOURCE_TYPES.PLASTIC] = 10
				},
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "йо играл ли ты в Garry's Mod?"
			},
			["CERAMIC POT"] = {
				results = JMod.ArmorTable["Ceramic Pot"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 30,
				},
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "остановит пулю один раз."
			},
			["COOKIN POT"] = {
				results = JMod.ArmorTable["Metal Pot"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 30
				},
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "congrats you are now 5"
			},
			["Nazi helmet"] = {
				results = JMod.ArmorTable["Nazi-helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 15
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Simple lightweight helmet that doesn't block much damage."
			},
			["Brodie helmet"] = {
				results = JMod.ArmorTable["Brodie-helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 15
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Simple lightweight helmet that doesn't block much damage."
			},
			["schirmmuetze"] = {
				results = JMod.ArmorTable["schirmmuetze"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 2,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Simple lightweight helmet that doesn't block much damage."
			},
			--[[["Steel helmet"] = {
				results = JMod.ArmorTable["ST-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 15
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Simple lightweight helmet that doesn't block much damage."
			},]]
			--[[["EZ Light Helmet"] = {
				results = JMod.ArmorTable["Light-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 2,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Simple lightweight helmet that doesn't block much damage."
			},]]
			--[[["EZ Respirator"] = {
				results = JMod.ArmorTable["Respirator"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "You can wear goggles while protecting your lungs, but you'll have to retreat."
			},]]
			["EZ Riot Helmet"] = {
				results = JMod.ArmorTable["Riot-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				"The light helmet, but with cheap glass attached to the front. Light face defense."
			},
			["EZ Heavy Riot Helmet"] = {
				results = JMod.ArmorTable["Heavy-Riot-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 15,
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Heavy riot helmet with proper ballistic protection."
			},
			["EZ Heavy Helmet"] = {
				results = JMod.ArmorTable["Heavy-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 10,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 5
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "A heavy helmet that provides good defense without taking up your face slots."
			},
			["EZ Ultra Heavy Helmet"] = {
				results = JMod.ArmorTable["Ultra-Heavy-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 20,
					[JMod.EZ_RESOURCE_TYPES.TUNGSTEN] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Strongest helmet avaliable, at the cost of weight and vision."
			},
			["EZ Light Left Shoulder Armor"] = {
				results = JMod.ArmorTable["Light-Left-Shoulder"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Decent protection for your shoulders."
			},
			["EZ Light Right Shoulder Armor"] = {
				results = JMod.ArmorTable["Light-Right-Shoulder"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Decent protection for your shoulders."
			},
			["EZ Light Torso Armor"] = {
				results = JMod.ArmorTable["Light-Vest"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Will provide light damage protection at little cost to mobility."
			},
			["EZ Medium Helmet"] = {
				results = JMod.ArmorTable["Medium-Helmet"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Well-rounded helmet with balanced protection and weight."
			},
			["EZ Medium Torso Armor"] = {
				results = JMod.ArmorTable["Medium-Vest"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 25,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 25
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "A vest, that while somewhat heavy, will provide appreciable over-all protection to your torso."
			},
			["EZ Medium-Heavy Torso Armor"] = {
				results = JMod.ArmorTable["Medium-Heavy-Vest"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 25,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 25,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 25
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "It's in the name, for when you need a bit more protection than the medium provides."
			},
			["EZ Medium-Light Torso Armor"] = {
				results = JMod.ArmorTable["Medium-Light-Vest"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 15,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "A lightweight balance between the Light and Medium vests."
			},
			["EZ Thermal Goggles"] = {
				results = JMod.ArmorTable["ThermalGoggles"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 30,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 25
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Allows you to visualize most heat signatures."
			},
			["EZ Night Vision Goggles"] = {
				results = JMod.ArmorTable["NightVisionGoggles"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 30,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 25
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "See at night, be blinded by bright light."
			},
			["EZ Left Calf Armor"] = {
				results = JMod.ArmorTable["Left-Calf"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "For your legs."
			},
			["EZ Left Forearm Armor"] = {
				results = JMod.ArmorTable["Left-Forearm"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Convenient armor for the limbs hanging in front of your chest."
			},
			["EZ Light Left Thigh Armor"] = {
				results = JMod.ArmorTable["Light-Left-Thigh"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Keep your thigh."
			},
			["EZ Heavy Left Thigh Armor"] = {
				results = JMod.ArmorTable["Heavy-Left-Thigh"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 2,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "i'm not making that joke."
			},
			["EZ Pelvis Armor"] = {
				results = JMod.ArmorTable["Pelvis-Panel"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 2,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Prevent annihilation of your family jewels."
			},
			["EZ Right Calf Armor"] = {
				results = JMod.ArmorTable["Right-Calf"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "For your legs."
			},
			["EZ Right Forearm Armor"] = {
				results = JMod.ArmorTable["Right-Forearm"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Convenient armor for the limbs hanging in front of your chest."
			},
			["EZ Light Right Thigh Armor"] = {
				results = JMod.ArmorTable["Light-Right-Thigh"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 10
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Keep your thigh."
			},
			["EZ Heavy Right Thigh Armor"] = {
				results = JMod.ArmorTable["Heavy-Right-Thigh"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 2,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 10,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20,
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 10
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "I'm not making that joke."
			},
			["EZ Hazmat Suit"] = {
				results = JMod.ArmorTable["Hazmat Suit"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 20,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDTEXTILES] = 20,
					[JMod.EZ_RESOURCE_TYPES.RUBBER] = 40
				},
				category = "Apparel",
				craftingType = "fabricator",
				description = "Full-body protection against environmental hazards, though fragile."
			},
			["EZ Parachute"] = {
				results = JMod.ArmorTable["Parachute"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 300
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Valuable tool to break your fall with when falling high distances."
			},
			["EZ Backpack"] = {
				results = JMod.ArmorTable["Backpack"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 40
				},
				category = "Apparel",
				craftingType = "workbench",
				description = "Carry more items and resources to school."
			},
			["EZ Pouches"] = {
				results = JMod.ArmorTable["Pouches"].ent,
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 4,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 20
				},
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "Handy bags for carrying some extra bits and pieces."
			},
			["EZ Medical Supplies"] = {
				results = "ent_jack_gmod_ezmedsupplies",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 10,
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 25
				},
				category = "Resources",
				craftingType = "workbench",
				description = "Necessities to heal anyone."
			},
			["EZ Medkit"] = {
				results = "ent_jack_gmod_ezmedkit",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.MEDICALSUPPLIES] = 100
				},
				category = "Tools",
				craftingType = "workbench",
				description = "Go help em doc. Watch your head, you're gonna be a target."
			},
			["EZ Mini Bounding Mine"] = {
				results = "ent_jack_gmod_ezboundingmine",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 5
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Bury this in the soil around your base, and you got a very hidden defense option."
			},
			["EZ Mini Claymore"] = {
				results = "ent_jack_gmod_ezminimore",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Simple way to trap corners and the like."
			},
			--[[["EZ Mini Impact Grenade"] = {
				results = "ent_jack_gmod_eznade_impact",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 5
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "You could throw it, but it's much better for making sure that bumping a bomb is a death sentence."
			},]]
			--[[["EZ Mini Proximity Grenade"] = {
				results = "ent_jack_gmod_eznade_proximity",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 5
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Useful for turning big bombs into traps. Very weak on its own however."
			},
			["EZ Mini Remote Grenade"] = {
				results = "ent_jack_gmod_eznade_remote",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 5
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Set it on a bomb, and trigger it from afar. Good if you want to ensure you're out of blast range."
			},
			["EZ Mini Timed Grenade"] = {
				results = "ent_jack_gmod_eznade_timed",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 5,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 5
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Arm it on a bomb, and run like hell."
			},]]
			["EZ Munitions"] = {
				results = "ent_jack_gmod_ezmunitions",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 75,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 50
				},
				category = "Resources",
				craftingType = "fabricator",
				description = "Ammo for your explosive toys."
			},
			["EZ Powder Keg"] = {
				results = "ent_jack_gmod_ezpowderkeg",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 30,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 170
				},
				category = "Munitions",
				craftingType = {"workbench", "craftingtable"},
				description = "Become bugs bunny and kill yosemite sam with a black-powder line!"
			},

			["EZ Dynamite"] = {
				results = "ent_jack_gmod_ezdynamite",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 30,
					[JMod.EZ_RESOURCE_TYPES.PROPELLANT] = 70
				},
				category = "Munitions",
				craftingType = {"workbench", "craftingtable"},
				description = "Become bugs bunny and kill yosemite sam with a black-powder line!"
			},

			
			["EZ Propellant"] = {
				results = "ent_jack_gmod_ezpropellant",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 25,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 25
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Propellant for guns and other things."
			},
			["EZ Coolant"] = {
				results = "ent_jack_gmod_ezcoolant",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 10,
					[JMod.EZ_RESOURCE_TYPES.WATER] = 100,
				},
				category = "Resources",
				craftingType = "workbench",
				description = "For cooling down machines. Do not drink."
			},
			["EZ Nutrients"] = {
				results = "ent_jack_gmod_eznutrients",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.ORGANICS] = 50,
					[JMod.EZ_RESOURCE_TYPES.WATER] = 25,
					[JMod.EZ_RESOURCE_TYPES.PAPER] = 25
				},
				category = "Resources",
				craftingType = {"workbench", "craftingtable"},
				description = "Tasty food! 99% Plastic Free!"
			},
			["EZ SLAM"] = {
				results = "ent_jack_gmod_ezslam",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 15
				},
				category = "Munitions",
				description = "Fires an armor-piercing mega bullet at any enemy vehicle to cross the laser beam.",
				craftingType = "workbench"
			},
			--[[["EZ Satchel Charge"] = {
				results = "ent_jack_gmod_ezsatchelcharge",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Powerful explosive charge with a traditional plunger detonator that you can drag away."
			},]]
			["EZ Signal Grenade"] = {
				results = "ent_jack_gmod_ezsignalnade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 25
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Send smoke signals to your team, and probably be ignored or brutally murdered by the enemy."
			},
			["EZ Smoke Grenade"] = {
				results = "ent_jack_gmod_ezsmokenade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 25,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 25
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Smokescreen so nobody knows who they're shooting."
			},
			["EZ Stick Grenade"] = {
				results = "ent_jack_gmod_ezsticknade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "An old-fashioned Stielhandgranate with a toggleable frag sleeve."
			},
			["EZ Sticky Bomb"] = {
				results = "ent_jack_gmod_ezstickynade",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 20,
					[JMod.EZ_RESOURCE_TYPES.CHEMICALS] = 10
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Don't get yourself stuck on it! Very good for sticking to vehicles and stationary objects."
			},
			["EZ TNT"] = {
				results = "ent_jack_gmod_eztnt",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 30
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "Simple breaching device. Reacts to powder from the powder keg."
			},
			["EZ Time Bomb"] = {
				results = "ent_jack_gmod_eztimebomb",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 20,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 100
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "The longer you set the time, the harder it is to defuse."
			},


			["Physgun"] = {
				results = "weapon_physgun",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.POWER] = 250,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 50,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 30
				},
				category = "Tools",
				craftingType = "workbench",
				description = "Как же удобно."
			},
			
			["repair"] = {
				results = "weapon_lvsrepair",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.POWER] = 100,
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 50,
				},
				category = "Tools",
				craftingType = "workbench",
				description = "Как же удобно."
			},

			--[[["welding mask"] = {
				results = "ent_aboot_gmod_ezarmor_weldingmask",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 100,
				},
				category = "Tools",
				craftingType = "workbench",
				description = "Как же удобно."
			},]]

			["Conveyor"] = {
				results = "FUNC SpawnConveyor",
				craftingReqs = {
					--[JMod.EZ_RESOURCE_TYPES.STEEL] = 30,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15
				},
				sizeScale = 1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Конвейр для автоматизации."
			},

			["Power Line"] = {
				results = "ent_rus_gmod_ezpowerline",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 15,
				},
				sizeScale = 1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Линии Электро-передач для автоматизации."
			},

			["Pipe"] = {
				results = "ent_rus_jsmod_pipe",
				craftingReqs = {
					--[JMod.EZ_RESOURCE_TYPES.STEEL] = 30,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 15
				},
				sizeScale = 1,
				category = "Tools",
				craftingType = "toolbox",
				description = "Труба для автоматизации."
			},

			["Sorter"] = {
				results = "ent_rus_sorter",
				craftingReqs = {
					--[JMod.EZ_RESOURCE_TYPES.STEEL] = 30,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 50
				},
				sizeScale = 1,
				category = "Tools",
				craftingType = "toolbox",
				description = "сортировщик для автоматизации."
			},


			["Point Of Dislocation"] = {
				results = "ent_rus_spawnbase",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 250,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200
				},
				sizeScale = 2,
				category = "Tools",
				craftingType = "toolbox",
				description = "Точка дислокации."
			},

			

			["Crate Fulton"] = {
				results = "ent_aboot_jsmod_ezcrate_fulton",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 50,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 10
				},
				sizeScale = 3,
				category = "Other",
				craftingType = "toolbox",
				description = "Фултон, для продажи предметов."
			},

			["cratepack"] = {
				results = "ent_fumo_gmod_cratepack",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 25,
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 100
				},
				sizeScale = 3,
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "коробка на спину."
			},
			
			--[[["armorstand"] = {
				results = "armorstand",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 30
				},
				sizeScale = 3,
				category = "Apparel",
				craftingType = "workbench",
				description = "стэнд для брони."
			},]]

			["sky lantern"] = {
				results = "ent_fumo_gmod_ezskylantern",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CLOTH] = 15
				},
				sizeScale = 1,
				category = "Apparel",
				craftingType = {"workbench", "craftingtable"},
				description = "китайская леталка."
			},

			["fluid barrel"] = {
				results = "ent_fumo_gmod_ezfluidbarrel",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.WOOD] = 50
				},
				sizeScale = 2,
				category = "Machines",
				craftingType = "toolbox",
				description = "емкость жидкостей."
			},
			

			





			["blastdoor big"] = {
				results = "models/props_lab/blastdoor001c.mdl",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 70,
				},
				sizeScale = 2,
				category = "Props",
				craftingType = "toolbox",
				description = "проп для строительства."
			},

			["blastdoor small"] = {
				results = "models/props_lab/blastdoor001b.mdl",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 30,
				},
				sizeScale = 3,
				category = "Props",
				craftingType = "toolbox",
				description = "проп для строительства."
			},
			
			--[[["barrier"] = {
				results = "models/props_c17/concrete_barrier001a.mdl",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.CERAMIC] = 30,
				},
				sizeScale = 3,
				category = "Props",
				craftingType = "toolbox",
				description = "проп для строительства."
			},]]

			["fence"] = {
				results = "models/props_c17/fence02a.mdl",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 20,
				},
				sizeScale = 3,
				category = "Props",
				craftingType = "toolbox",
				description = "проп для строительства."
			},

			["Tank Ammo"] = {
				results = "lvs_item_ammo",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 30,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 30
				},
				category = "Munitions",
				craftingType = "workbench",
				description = "танковый снаряд."
			},

			["Renault FT"] = {
				results = "lvs_renaultft_m",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 450,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 200,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 150,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 600,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 300
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "Легендарный танк первой мировой."
			},

			["Sherman"] = {
				results = "lvs_wheeldrive_dodsherman",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 700,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 600,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 500
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "Легендарный танк второй мировой."
			},

			--[[["Super Tank"] = {
				results = "lvs_wheeldrive_t35",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 1500,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 1000,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 500,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 500,
					[JMod.EZ_RESOURCE_TYPES.ADVANCEDPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 1000,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 1000
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "Его появление должно перевернуть войну."
			},]]

			--[[["Panzerwagen"] = {
				results = "lvs_wheeldrive_sdkfz251_base",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 450,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
				},

				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "Его появление должно перевернуть войну."
			},]]

			["BM 13"] = {
				results = "lvs_wheeldrive_bm13",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 500,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 480
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "МАШИНАА."
			},

			["Sturm Panzer"] = {
				results = "lvs_wheeldrive_pz1bison",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 500,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 500,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 600,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 600
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "МАШИНАА."
			},

			["MLE 1897"] = {
				results = "lvs_trailer_75mle1897",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					--[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 300
				},
				sizeScale = 4.5,
				category = "Artillery",
				craftingType = "toolbox",
				description = "противотанковая пушка."
			},

			["MLE 1913"] = {
				results = "lvs_trailer_schneider",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 500,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					--[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					[JMod.EZ_RESOURCE_TYPES.EXPLOSIVES] = 400
				},
				sizeScale = 4.5,
				category = "Artillery",
				craftingType = "toolbox",
				description = "гаубица."
			},

			["truck"] = {
				results = "lvs_wheeldrive_citroen_type23",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.MUNITIONS] = 100
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "МАШИНАА."
			},
			
			["gazm1"] = {
				results = "lvs_wheeldrive_gazm1",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.MUNITIONS] = 100
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "МАШИНАА."
			},

			--[[["BMW r75"] = {
				results = "lvs_wheeldrive_bmw_r75_upd",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 200,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 200,
					--[JMod.EZ_RESOURCE_TYPES.POWER] = 150,
					--[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 150,
					[JMod.EZ_RESOURCE_TYPES.AMMO] = 100
				},
				sizeScale = 4.5,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "МАШИНАА."
			},]]

			["helicopter"] = {
				results = "lvs_helicopter_rebel",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.LEAD] = 100,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 200,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.FUEL] = 300,
					--[JMod.EZ_RESOURCE_TYPES.MUNITIONS] = 100
				},
				sizeScale = 10,
				category = "Vehicle",
				craftingType = "toolbox",
				description = "МАШИНАА."
			},

			["air defence"] = {
				results = "FUNC SpawnAirDefence",
				craftingReqs = {
					[JMod.EZ_RESOURCE_TYPES.STEEL] = 150,
					[JMod.EZ_RESOURCE_TYPES.BASICPARTS] = 300,
					[JMod.EZ_RESOURCE_TYPES.POWER] = 300,
					[JMod.EZ_RESOURCE_TYPES.PRECISIONPARTS] = 100,
				},
				sizeScale = 2,
				category = "Other",
				craftingType = "toolbox",
				description = "ПВО."
			},

			
		},
	}

	if (configToApply ~= nil) and istable(configToApply) then
		NewConfig = configToApply
	end

	local FileContents = file.Read("jmod_config.txt")

	if FileContents then
		local Existing = util.JSONToTable(FileContents)

		if Existing then
			if Existing.Version then
				print("JMOD: Your config is from a JMod version before the config reformat, old config will no longer work as-is.")
				forceNew = true
			elseif Existing.Info.Version then
				if (Existing.Info.Version == NewConfig.Info.Version) then
					JMod.Config = util.JSONToTable(FileContents)
					print("JMOD: config file loaded")
				else
					file.Write("jmod_config_old.txt", FileContents)
					print("JMOD: old config version: " .. tostring(Existing.Info.Version) .. ", new config version: " .. tostring(NewConfig.Info.Version))
					print("JMOD: config versions do not match, writing old config to 'jmod_config_old.txt'...")
				end
			else
				print("JMOD: unable to compare versions!! (check config layout)")
			end
		else
			print("JMOD: invalid config syntax!! (make sure to lint the json)")
		end
	else
		print("JMOD: config missing or corrupted!! (can not update)")
		forceNew = true
	end

	if not JMod.Config or forceNew then
		JMod.Config = NewConfig
		if forceNew then
			if FileContents then
				print("JMOD: as a precaution, writing file contents to 'jmod_config_old.txt'...")
				file.Write("jmod_config_old.txt", FileContents)
			end
			file.Write("jmod_config.txt", util.TableToJSON(JMod.Config, true))
			print("JMOD: config reset to default")
		else
			print("JMOD: no config detected, temporarily using default")
		end
	end

	-- jmod lua config --
	if not JMod.LuaConfig then
		JMod.LuaConfig = {
			BuildFuncs = {},
			ArmorOffsets = {}
		}
	end

	JMod.LuaConfig.BuildFuncs = JMod.LuaConfig.BuildFuncs or {}
	JMod.LuaConfig.ArmorOffsets = JMod.LuaConfig.ArmorOffsets or {}

	JMod.LuaConfig.BuildFuncs.spawnHL2buggy = function(playa, position, angles)
		local Ent = ents.Create("prop_vehicle_jeep_old")
		Ent:SetModel("models/buggy.mdl")
		Ent:SetKeyValue("vehiclescript", "scripts/vehicles/jeep_test.txt")
		Ent:SetPos(position)
		Ent:SetAngles(angles)
		JMod.SetEZowner(Ent, playa)
		Ent:Spawn()
		Ent:Activate()
	end
	JMod.LuaConfig.BuildFuncs.spawnHL2airboat = function(playa, position, angles)
		local Ent = ents.Create("prop_vehicle_airboat")
		Ent:SetModel("models/airboat.mdl")
		Ent:SetKeyValue("vehiclescript", "scripts/vehicles/airboat.txt")
		Ent:SetPos(position)
		Ent:SetAngles(angles)
		JMod.SetEZowner(Ent, playa)
		Ent:Spawn()
		Ent:Activate()
	end
	JMod.LuaConfig.BuildFuncs.EZnail = function(playa, position, angles)
		JMod.Nail(playa)
	end
	JMod.LuaConfig.BuildFuncs.EZbolt = function(playa, position, angles)
		JMod.Bolt(playa)
	end
	JMod.LuaConfig.BuildFuncs.EZbox = function(playa, position, angles)
		JMod.Package(playa)
	end
	JMod.LuaConfig.BuildFuncs.EZrope = function(playa, position, angles)
		JMod.Rope(playa, nil, nil, 2, 5000, "cable/rope")
		playa.EZropeData = nil
	end
	JMod.LuaConfig.BuildFuncs.EZcable = function(playa, position, angles)
		local Ent1 = playa.EZropeData.Ent
		local Rope, Ent2 = JMod.Rope(playa, nil, nil, 2, 20000, "cable/cable2")
		local PlugPos = Ent2:WorldToLocal(position)
		local RopeDist = math.ceil(playa.EZropeData.Ent:GetPos():Distance(position))
		if JMod.CreateConnection(Ent1, Ent2, JMod.EZ_RESOURCE_TYPES.POWER, PlugPos, RopeDist, Rope) or JMod.CreateConnection(Ent2, Ent1, JMod.EZ_RESOURCE_TYPES.POWER, PlugPos, RopeDist, Rope) then
			local effectdata = EffectData()
			effectdata:SetOrigin(position)
			effectdata:SetScale(1)
			util.Effect("Sparks", effectdata)
		end
		playa.EZropeData = nil
	end
	JMod.LuaConfig.BuildFuncs.EZchain = function(playa, position, angles)
		JMod.Rope(playa, nil, nil, 2, 50000, "cable/mat_jack_gmod_chain")
		playa.EZropeData = nil
	end

	JMod.LuaConfig.BuildFuncs.SpawnAirDefence = function(ply, position, angles)
		local ent = ents.Create("joes_sam_turret_lvs")
		ent:SetOwner( ply )
		ent:Spawn()
		
		JMod.SetEZowner(ent, ply)

		local trSpawn = util.TraceHull( {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
			filter = ply,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )

		ent:SetPos(trSpawn.HitPos)
		ent:SetAngles(Angle(0, ply:EyeAngles().y , 0) + Angle(0,180,0))
		
        local tr = util.TraceLine( {
            start = ent:GetPos(),
            endpos = ent:GetPos() - Vector(0, 0, 15),
            filter = ent,
        } )

        if tr.HitWorld then
            ent:GetPhysicsObject():EnableMotion(false)
        end
	end

	JMod.LuaConfig.BuildFuncs.SpawnConveyor = function(ply, position, angles)
		local ent = ents.Create("sent_conveyor")
		ent:Spawn()
		
		JMod.SetEZowner(ent, ply)

		local trSpawn = util.TraceHull( {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
			filter = ply,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )

		ent:SetPos(trSpawn.HitPos)
		ent:SetAngles(Angle(0, ply:EyeAngles().y , 0) + Angle(90,180,0))
		
        local tr = util.TraceLine( {
            start = ent:GetPos(),
            endpos = ent:GetPos() - Vector(0, 0, 15),
            filter = ent,
        } )

        if tr.HitWorld then
            ent:GetPhysicsObject():EnableMotion(false)
        end
	end

	JMod.LuaConfig.BuildFuncs.BigBlastDoor = function(ply, position, angles)
		local ent = ents.Create("prop_physics")
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:Spawn()
		ent:SetPos(position)
		ent:SetAngles(angles + Angle(90,180,0))
		JMod.SetEZowner(ent, ply)

        JMod.SetEZowner(ent, ply)

		local trSpawn = util.TraceHull( {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
			filter = ply,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )

		ent:SetPos(trSpawn.HitPos)
		ent:SetAngles(Angle(0, ply:EyeAngles().y , 0) + Angle(90,180,0))
		
        local tr = util.TraceLine( {
            start = ent:GetPos(),
            endpos = ent:GetPos() - Vector(0, 0, 15),
            filter = ent,
        } )

        if tr.HitWorld then
            ent:GetPhysicsObject():EnableMotion(false)
        end
	end

	hook.Run("JMod_PostLuaConfigLoad", JMod.Config)

	-- This is to make sure the ammo types are saved on config reload
	JMod.LoadAmmoTable(JMod.AmmoTable)

	print("JMOD: updating recipies...")
	for k, v in ents.Iterator() do
		if(IsValid(v) and v.UpdateConfig)then
			v:UpdateConfig()
		end
	end

	SetArmorPlayerModelModifications()

	print("JMOD: lua config file loaded")
	if SERVER then
		print("JMOD: syncing lua config's")
		JMod.LuaConfigSync(true)
	end
	if not forceNew then
		print("-----Config Info-----")
		for k, v in pairs(JMod.Config.Info) do
			print(k..":", v)
		end
	end
end

function JMod.LoadDepositConfig(configID, forceMap)
	if not configID then print("No valid ID") return end
	configID = tostring(configID)
	local MapName = game.GetMap()
	if forceMap then
		MapName = forceMap
	end
	--print(MapName)
	local FileContents = file.Read("jmod_resources_"..MapName..".txt")
	
	if FileContents then
		local MapConfig = util.JSONToTable(FileContents) or {}

		--PrintTable(MapConfig)
		for k, v in pairs(MapConfig) do
			if not(isstring(k)) then
				MapConfig[tostring(k)] = v
				MapConfig[k] = nil
			end
		end

		if MapConfig[configID] then
			local NewResourceTable = {}
			for k, v in pairs(MapConfig[configID]) do
				NewResourceTable[k] = {
					typ = v.typ,
					pos = Vector(v.pos[1], v.pos[2], v.pos[3]),
					siz = v.siz
				}
				if v.rate then
					NewResourceTable[k].rate = v.rate
				else
					NewResourceTable[k].amt = math.Round(v.amt)
				end
			end
			print("JMod: Succesfully loaded new resource deposit map")
			return NewResourceTable
		else
			--PrintTable(MapConfig) -- Debug
			return "JMod: Resource config ID " .. "jmod_resources_"..MapName..".txt \'" .. configID .."\' doesn't exsist"
		end
	else 
		return "jmod_resources_"..MapName..".txt is missing or corrupt"
	end
end

function JMod.SaveDepositConfig(configID)
	if not isstring(configID) then print("No valid ID") return end
	configID = tostring(configID)
	local MapName = game.GetMap()

	local FileContents = file.Read("jmod_resources_"..MapName..".txt")
	
	local Existing = FileContents and util.JSONToTable(FileContents) or {}

	local ResourceMapToSave = JMod.NaturalResourceTable

	local NewResourceTable = {}
	for k, v in pairs(ResourceMapToSave) do
		NewResourceTable[k] = {
			typ = v.typ,
			pos = {v.pos[1], v.pos[2], v.pos[3]},
			siz = v.siz
		}
		if v.rate then
			NewResourceTable[k].rate = v.rate
		else
			NewResourceTable[k].amt = v.amt
		end
	end
	Existing[configID] = NewResourceTable
	file.Write("jmod_resources_"..MapName..".txt", util.TableToJSON(Existing))
	print("JMod: Saved resource layout to: " .. "jmod_resources_"..MapName..".txt" .. " with ID: " .. configID)
	--PrintTable(Existing)
end

hook.Add("PersistenceSave", "JMOD_SaveDepositConfig", function(persistenceString)
	if not persistenceString then return end
	JMod.SaveDepositConfig("Persistant" .. persistenceString)
end)

hook.Add("PersistenceLoad", "JMOD_LoadDepositConfig", function(persistenceString)
	if not persistenceString then return end
	local Info = JMod.LoadDepositConfig("Persistant" .. persistenceString)

	if type(Info) == "string" then
		print(Info)
		return
	else
		if SERVER and GetConVar("sv_cheats"):GetBool() == true then
			JMod.NaturalResourceTable = Info
			net.Start("JMod_NaturalResources")
				net.WriteBool(false)
				net.WriteTable(Info)
			net.Broadcast()
		end
	end
end)

hook.Add("Initialize", "JMOD_Initialize", function()
	if SERVER then
		JMod.InitGlobalConfig()
	end
end)

local RopeCostList = {["FUNC EZrope"] = 64, ["FUNC EZcable"] = 64, ["FUNC EZchain"] = 64}

hook.Add("JMod_CanKitBuild", "JMOD_KitBuildReqs", function(playa, toolbox, buildInfo)
	if (buildInfo.results == "FUNC EZnail") and not JMod.FindNailPos(playa) then return false, "No applicable nail pos" end
	if (buildInfo.results == "FUNC EZbolt") and not JMod.FindBoltPos(playa) then return false, "No applicable bolt pos" end
	if (buildInfo.results == "FUNC EZbox") and not JMod.GetPackagableObject(playa) then 
		local _, Message = JMod.GetPackagableObject(playa) 
		
		return false, Message 
	end
	if (RopeCostList[buildInfo.results]) then
		local RopeTr = util.QuickTrace(playa:GetShootPos(), playa:GetAimVector() * 80, {playa})
		if not RopeTr.Hit then 
			playa.EZropeData = nil

			return false, "No applicible cable pos" 
		end

		if not playa.EZropeData  or not IsValid(playa.EZropeData.Ent) then
			playa.EZropeData = {Pos = RopeTr.Entity:WorldToLocal(RopeTr.HitPos), Ent = RopeTr.Entity}
			return false, "Cable started"
		end

		return true, "Cable finished", math.Round(playa.EZropeData.Ent:LocalToWorld(playa.EZropeData.Pos):Distance(RopeTr.HitPos) / RopeCostList[buildInfo.results])
	end
end)
