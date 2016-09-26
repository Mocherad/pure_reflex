-- Generated from template

if NinjaClaasicGameMode == nil then
  NinjaClaasicGameMode = class({})
end

require("libraries/timers")
require("libraries/projectiles")
require("libraries/notifications")
require( "libraries/physics" )

BUILD = {}
RANDOM_SKILLS = false
ANOMALIES = false

local noData = true

function Precache( context )

  PrecacheUnitByNameSync("npc_dota_hero_juggernaut", context)
  PrecacheUnitByNameSync("npc_dota_hero_phantom_assassin", context)
  PrecacheUnitByNameSync("npc_dota_hero_invoker", context)
  PrecacheUnitByNameSync("npc_dota_hero_templar_assassin", context)
  PrecacheUnitByNameSync("npc_dota_hero_magnataur", context)
  PrecacheUnitByNameSync("npc_dota_hero_queenofpain", context)
  PrecacheUnitByNameSync("npc_dota_hero_phantom_assassin", context)
  PrecacheUnitByNameSync("npc_dota_hero_legion_commander", context)  
  PrecacheUnitByNameSync("npc_dota_hero_earth_spirit", context)  
  PrecacheUnitByNameSync("npc_dota_hero_bloodseeker", context)  
  
  PrecacheResource( "particle","particles/units/heroes/hero_elder_titan/elder_titan_earth_splitter.vpcf", context) 

  PrecacheResource( "particle","particles/shockwave/shockwave.vpcf", context) 
  PrecacheResource( "particle","particles/shockwave_gold/shockwave_gold.vpcf", context) 
  PrecacheResource( "particle","particles/refraction/refraction.vpcf", context) 
  PrecacheResource( "particle","particles/refraction_gold/refraction_gold.vpcf", context) 

  PrecacheResource( "particle","particles/shockwave_critical/shockwave_critical.vpcf", context) 
  PrecacheResource( "particle","particles/stone_remnant/stone_remnant.vpcf", context) 
  PrecacheResource( "particle","particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", context) 

  PrecacheResource( "particle","particles/econ/items/undying/undying_manyone/undying_pale_gold_tower_destruct_flashbang.vpcf", context)

  PrecacheResource( "soundfile", "soundevents/custom_sounds.vsndevts", context)
  PrecacheResource( "soundfile", "soundevents/game_sounds_items.vsndevts", context) 
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)

  PrecacheModel("models/items/juggernaut/thousand_faces_wraps/thousand_faces_wraps.mdl", context )
  PrecacheModel("models/items/juggernaut/thousand_faces_hakama/thousand_faces_hakama.mdl", context )
  PrecacheModel("models/items/juggernaut/thousand_faces_vest/thousand_faces_vest.mdl", context )
  PrecacheModel("models/items/juggernaut/thousand_faces_mask/thousand_faces_mask.mdl", context )
  PrecacheModel("models/items/juggernaut/weapon_bladefury512/weapon_bladefury512.mdl", context )
  PrecacheModel("models/items/juggernaut/jugg_flag/jugg_flag.mdl", context )
  PrecacheModel("models/items/juggernaut/thousand_faces_katana/thousand_faces_katana.mdl", context )
  PrecacheModel("models/items/juggernaut/juggernaut_sword_cursed/juggernaut_sword_cursed.mdl", context )
  PrecacheModel("models/items/juggernaut/dragon_sword.mdl", context )
  PrecacheModel("models/items/juggernaut/armour_of_the_exiled_ronin/armour_of_the_exiled_ronin.mdl", context )
  PrecacheModel("models/items/juggernaut/izoku/izoku.mdl", context )
  PrecacheModel("models/items/juggernaut/sturdy_bracers_of_the_exiled_ronin/sturdy_bracers_of_the_exiled_ronin.mdl", context )
  PrecacheModel("models/items/juggernaut/fire_of_the_exiled_ronin/fire_of_the_exiled_ronin.mdl", context )
  PrecacheModel("models/items/juggernaut/burden_of_the_exiled_ronin/burden_of_the_exiled_ronin.mdl", context )
  PrecacheModel("models/items/juggernaut/vestments_of_the_exiled_ronin/vestments_of_the_exiled_ronin.mdl", context )
  PrecacheModel("models/items/juggernaut/leg_gaurds_of_kogu/leg_gaurds_of_kogu.mdl", context )
  PrecacheModel("models/items/juggernaut/scowl_of_kogu/scowl_of_kogu.mdl", context )
  PrecacheModel("models/items/juggernaut/the_discipline_of_kogu/the_discipline_of_kogu.mdl", context )
  PrecacheModel("models/items/juggernaut/armor_of_kogu/armor_of_kogu.mdl", context )
  PrecacheModel("models/items/juggernaut/bracers_of_kogu/bracers_of_kogu.mdl", context )
  PrecacheModel("models/items/juggernaut/the_elegant_stroke/the_elegant_stroke.mdl", context )
  PrecacheModel("models/items/juggernaut/wandering_demon_arms/wandering_demon_arms.mdl", context )
  PrecacheModel("models/items/juggernaut/wandering_demon_mask/wandering_demon_mask.mdl", context )
  PrecacheModel("models/items/juggernaut/wandering_demon_legs/wandering_demon_legs.mdl", context )
  PrecacheModel("models/items/juggernaut/wandering_demon_sword/wandering_demon_sword.mdl", context )
  PrecacheModel("models/items/juggernaut/wandering_demon_top/wandering_demon_top.mdl", context )
  PrecacheModel("models/items/juggernaut/juggernaut_horse_sword/juggernaut_horse_sword.mdl", context )
  PrecacheModel("models/items/juggernaut/jg_weapon_files2/jg_weapon_files2.mdl", context )
  PrecacheModel("models/items/juggernaut/gifts_of_the_vanished_head/gifts_of_the_vanished_head.mdl", context )
  PrecacheModel("models/items/juggernaut/gifts_of_the_vanished_weapon/gifts_of_the_vanished_weapon.mdl", context )
  PrecacheModel("models/items/juggernaut/gifts_of_the_vanished_legs/gifts_of_the_vanished_legs.mdl", context )
  PrecacheModel("models/items/juggernaut/gifts_of_the_vanished_arms/gifts_of_the_vanished_arms.mdl", context )
  PrecacheModel("models/items/juggernaut/gifts_of_the_vanished_back/gifts_of_the_vanished_back.mdl", context )
  PrecacheModel("models/items/juggernaut/bladesrunner_back/bladesrunner_back.mdl", context )
  PrecacheModel("models/items/juggernaut/bladesrunner_legs/bladesrunner_legs.mdl", context )
  PrecacheModel("models/items/juggernaut/bladesrunner_head/bladesrunner_head.mdl", context )
  PrecacheModel("models/items/juggernaut/jadeserpent_weapon/jadeserpent_weapon.mdl", context )
  PrecacheModel("models/items/juggernaut/bladesrunner_arms/bladesrunner_arms.mdl", context )
  PrecacheModel("models/items/juggernaut/bladesrunner_weapon/bladesrunner_weapon.mdl", context )
  PrecacheModel("models/items/juggernaut/dc_armsupdate/dc_armsupdate.mdl", context )
  PrecacheModel("models/items/juggernaut/dc_weaponupdate/dc_weaponupdate.mdl", context )
  PrecacheModel("models/items/juggernaut/dc_backupdate4/dc_backupdate4.mdl", context )
  PrecacheModel("models/items/juggernaut/dc_headupdate/dc_headupdate.mdl", context )
  PrecacheModel("models/items/juggernaut/dc_legsupdate5/dc_legsupdate5.mdl", context )
end

-- Create the game mode when we activate
function Activate()
  GameRules.AddonTemplate = NinjaClaasicGameMode()
  GameRules.AddonTemplate:InitGameMode()
end

function NinjaClaasicGameMode:InitGameMode()
  GameMode = GameRules:GetGameModeEntity()
  goodGuysTeamName = "#Radiant"
  badGuysTeamName = "#Dire"
  Round = "#Round"
  goodGuysTeamNameSet = false
  badGuysTeamNameSet = false
  GameStarted = false
  roundGoing = true
  ROUND = 1
  goodGuysScore = 0
  badGuysScore = 0
  timeToStart = 400
  GameRules:SetHeroSelectionTime(120)
  GameRules:SetPreGameTime(16)
  GameRules:GetGameModeEntity():SetThink("GameStartMsg", self, 0)
  GameRules:SetSameHeroSelectionEnabled(true)
  GameMode:SetTopBarTeamValuesOverride (true)
  GameMode:SetBuybackEnabled(false)
  GameRules:SetGoldPerTick(0)
  GameRules:SetUseBaseGoldBountyOnHeroes(false)
  GameMode:SetCameraDistanceOverride(1360)
  GameRules:SetFirstBloodActive(false)
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_SHOP, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_COURIER, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_QUICKBUY, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_SHOP_SUGGESTEDITEMS, false )
  GameMode:SetFixedRespawnTime(1)
  GameRules:SetHideKillMessageHeaders(false)

  GameRules:GetGameModeEntity():SetThink("GameStartMusic", self, 8)

  GameRules.styles = {}
  GameRules.styles.rounds = { 
    marginTop = "400px",
    color="#E4E4E4",
    ["font-size"]="80px"
  }

  GameRules:SetCustomGameSetupTimeout( 9999 )

  CustomNetTables:SetTableValue("abilities","abilities",{})

  CustomGameEventManager:RegisterListener("reflex_start_game", Dynamic_Wrap(NinjaClaasicGameMode, 'FinishGameSetup'))
  CustomGameEventManager:RegisterListener("reflex_update_skill", Dynamic_Wrap(NinjaClaasicGameMode, 'UpdateSkill'))

  ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(NinjaClaasicGameMode, 'HeroPicked'), self)
  ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(NinjaClaasicGameMode, 'HeroGainedLevel'), self)
  ListenToGameEvent('player_chat', Dynamic_Wrap(NinjaClaasicGameMode, 'TeamNameChat'), self)
  
  ListenToGameEvent('player_connect_full', Dynamic_Wrap(NinjaClaasicGameMode, 'OnConnectFull'), self)
  ListenToGameEvent('player_disconnect', Dynamic_Wrap(NinjaClaasicGameMode, 'OnDisconnect'), self)
  ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(NinjaClaasicGameMode, 'OnGameRulesStateChange'), self)
  ListenToGameEvent("player_reconnected", Dynamic_Wrap(NinjaClaasicGameMode, 'OnPlayerReconnected'), self)

  -- ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(NinjaClaasicGameMode, 'CreateHeroes'), self)

  self.vUserIds = {}
  self.splIds = {}
end

function NinjaClaasicGameMode:UpdateSkill(args)
  local abilities = CustomNetTables:GetTableValue("abilities","abilities")
  abilities[tostring(args.slot)] = args.abilityname
  CustomNetTables:SetTableValue("abilities","abilities",abilities)
end

function NinjaClaasicGameMode:FinishGameSetup(args)
  for i=0,5 do
    table.insert(BUILD, args[tostring(i)])
  end

  RANDOM_SKILLS = args.randomSkills
  ANOMALIES = args.anomalies

  noData = false

  NinjaClaasicGameMode:CreateHeroes()
end

function NinjaClaasicGameMode:InitHero(hero)
  for i=0,16 do
    if hero:GetAbilityByIndex(i) then
      hero:RemoveAbility(hero:GetAbilityByIndex(i):GetName())
    end
  end
  for k,v in pairs(BUILD) do
    hero:AddAbility(v)
    print(v)
  end
  hero:AddAbility("on_respawn_protect")
  hero:AddAbility("blood_spatter")
  for i=0,16 do
    if hero:GetAbilityByIndex(i) then
      hero:GetAbilityByIndex(i):SetLevel(1)
    end
  end


end

function NinjaClaasicGameMode:CreateHeroes()
  --print("Game State Changed: " .. GameRules:State_Get())
  --print("Hero Selection State: " .. DOTA_GAMERULES_STATE_HERO_SELECTION)
  -- if GameRules:State_Get() == 3 then
    -- print("Entered IF")
  for i = 0, 9, 1 do
    if PlayerResource:GetPlayer(i) ~= nil then
      player = PlayerResource:GetPlayer(i)
      local team = player:GetTeamNumber() 
      print("team ".. team)
      if team == 3 then 
        hero = CreateHeroForPlayer('npc_dota_hero_phantom_assassin',player)
        NinjaClaasicGameMode:InitHero(hero)
      else
        hero = CreateHeroForPlayer('npc_dota_hero_juggernaut',player)
        NinjaClaasicGameMode:InitHero(hero)
      end
      hero:SetHasInventory( false )
    end
  end
  -- end
end

function NinjaClaasicGameMode:GameStartMusic ()
end
      

function NinjaClaasicGameMode:Time ()
  local time = 60
  Timers:CreateTimer( 1, function()
     print (time)
     if roundGoing == true then
        if time > 0 then 
          time = time - 1
          return 1.0
        else
          local player = nil
            for i = 0, 9, 1 do
              if PlayerResource:GetPlayer(i) ~= nil and player:GetAssignedHero() then
              player = PlayerResource:GetPlayer(i)
              local hero = player:GetAssignedHero()
              hero:AddNewModifier(hero, nil, "modifier_invulnerable", { duration = 6 })
              hero:AddNewModifier(hero, nil, "modifier_stunned", { duration = 6 })
              end 
            end 
          Notifications:ClearTopFromAll()
          Notifications:TopToAll({text="#Draw", style=GameRules.styles.rounds, duration=7.0})
          GameRules:GetGameModeEntity():SetThink("Respawn", self, 6)
          GameMode:SetTopBarTeamValue ( DOTA_TEAM_BADGUYS, badGuysScore)
          GameMode:SetTopBarTeamValue ( DOTA_TEAM_GOODGUYS, goodGuysScore )
          roundGoing = false 
        end
    end
  end )  
end

function NinjaClaasicGameMode:OnPlayerReconnected()
	NinjaClaasicGameMode:EndRoundCheck()
end

function NinjaClaasicGameMode:OnGameRulesStateChange(keys)
  if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
  	timeToStart = 15
    DeepPrintTable(keys)
    GameRules:SendCustomMessage("#Welcome", 0, 0)
  	GameRules:GetGameModeEntity():SetThink("Respawn", self, 15)
  elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS and noData == true then
    for i = 0, 9, 1 do
      if PlayerResource:GetPlayer(i) ~= nil and GameRules:PlayerHasCustomGameHostPrivileges(PlayerResource:GetPlayer(i)) then
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(i), "reflex_force_start_game", {})
      end 
    end 
  end
end

function NinjaClaasicGameMode:OnConnectFull(keys)
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  local userID = keys.userid
  local spl = keys.splitscreenplayer
  self.vUserIds = self.vUserIds or {}
  self.vUserIds[userID] = ply
  self.splIds[spl] = ply
  DeepPrintTable(keys)
 
end

function NinjaClaasicGameMode:OnDisconnect(keys)
	local playerID = self.vUserIds[keys.userid]:GetPlayerID()
	local player = PlayerResource:GetPlayer(playerID)
	local hero = player:GetAssignedHero()
	if hero ~= nil then
		hero:Kill(nil, nil)
	end
	NinjaClaasicGameMode:EndRoundCheck()
end

function NinjaClaasicGameMode:TeamNameChat(keys)
	local mensagem = string.sub(keys.text, 0, 7)
	if mensagem == "-tname " then
		local playerID = self.vUserIds[keys.userid]:GetPlayerID()
		local player = PlayerResource:GetPlayer(playerID)
		local teamName = string.sub(keys.text, 8, 23)
		if player:GetTeam() == 2 then 
			if player:GetAssignedHero() ~= nil then
				if goodGuysTeamNameSet == false then
				goodGuysTeamNameSet = true
				goodGuysTeamName = teamName
				GameRules:SendCustomMessage("Radiant team name was set to " .. teamName,0,0)
				end
			end
		end
		if player:GetTeam() == 3 then
			if player:GetAssignedHero() ~= nil then
				if badGuysTeamNameSet == false then
				badGuysTeamNameSet = true
				badGuysTeamName = teamName
				GameRules:SendCustomMessage("Dire team name was set to " .. teamName,0,0)
				end
			end
		end	
	end
end

function NinjaClaasicGameMode:GameStartMsg()
  timeToStart = timeToStart - 1
 
  if timeToStart > 0 then
    return 1
  else
    return nil
  end
end

function NinjaClaasicGameMode:HeroGainedLevel(keys)
  local player = EntIndexToHScript (keys.player)
  local hero = player:GetAssignedHero()
  hero:SetAbilityPoints(0) 
end

function NinjaClaasicGameMode:HeroPicked(keys)
  local hero = EntIndexToHScript (keys.heroindex)
  local player = EntIndexToHScript (keys.player)
  local playerId = player:GetPlayerID()
        PlayerResource:SetGold(playerId, 0, false)
        hero:SetAbilityPoints(0)
NinjaClaasicGameMode:InitHero(hero)
		    hero:SetHasInventory( false )
  local item = CreateItem("item_quelling_blade", hero, hero)
        hero:AddItem(item)
		if (GameStarted) then
			  hero:RemoveModifierByName("modifier_on_respawn_protect_active")
		end
end


function NinjaClaasicGameMode:Respawn()

  EmitGlobalSound("DOTA_Item.DoE.Activate")
  GridNav:RegrowAllTrees()
  roundGoing = true
  NinjaClaasicGameMode:Time()


  
  local player = nil
  
  if ROUND == 1 then
    ListenToGameEvent('entity_killed', Dynamic_Wrap(NinjaClaasicGameMode, 'hero_killed'), self)
    GameRules:SetHeroRespawnEnabled(false)
    GameStarted = true
  end
  Notifications:ClearTopFromAll()
  Notifications:TopToAll({text="#Round", style=GameRules.styles.rounds, duration=3.0})
  Notifications:TopToAll({text=ROUND, style=GameRules.styles.rounds, continue=true })
  for i = 0, 9, 1 do
    if PlayerResource:GetPlayer(i) ~= nil and player:GetAssignedHero() then
      player = PlayerResource:GetPlayer(i)
      PlayerResource:SetGold(i, 0, false)
      local hero = player:GetAssignedHero()
      local team = hero:GetTeamNumber() 
        for i = 0, hero:GetAbilityCount() - 1 do
        if hero:GetAbilityByIndex(i) ~= nil then
          hero:GetAbilityByIndex(i):EndCooldown()
        end   
      end
      print("dead".. team)
      if hero == nil then
        if player:GetTeam() == 3 then 
        hero = CreateHeroForPlayer('npc_dota_hero_phantom_assassin',player)
        else
        hero = CreateHeroForPlayer('npc_dota_hero_juggernaut',player)
        end
		    hero:SetHasInventory( false )
      end
      if hero:IsRealHero() then
        hero:RespawnHero(false,false,false)
        hero:SetAbilityPoints(0)
        NinjaClaasicGameMode:InitHero(hero)
      end
    end
  end
  ROUND = ROUND + 1
    Timers:CreateTimer({
    endTime = 3, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
      NinjaClaasicGameMode:RemoveInv()
    end
  })
  return nil
end

function NinjaClaasicGameMode:RemoveInv()
  local player = nil
   for i = 0, 9, 1 do
    if PlayerResource:GetPlayer(i) ~= nil then
      player = PlayerResource:GetPlayer(i)
      local hero = player:GetAssignedHero()
      hero:RemoveModifierByName("modifier_on_respawn_protect_active")
    end 
   end
   return nil  
end

function NinjaClaasicGameMode:EndRoundCheck()
	if (roundGoing) then
		if (NinjaClaasicGameMode:numberOfBadGuysAlive() == 0 and NinjaClaasicGameMode:numberOfGoodGuysAlive() > 0) then
		EmitGlobalSound("Hero_LegionCommander.Duel.Victory")
		goodGuysScore = goodGuysScore + 1
    Notifications:ClearTopFromAll()
    Notifications:TopToAll({text="#Radiant", style=GameRules.styles.rounds, duration=3.0})
    Notifications:TopToAll({text="#Wins", style=GameRules.styles.rounds, continue=true })
		GameMode:SetTopBarTeamValue ( DOTA_TEAM_BADGUYS, badGuysScore)
		GameMode:SetTopBarTeamValue ( DOTA_TEAM_GOODGUYS, goodGuysScore )
		roundGoing = false
			if goodGuysScore == 15 then
				NinjaClaasicGameMode:GoodGuysVictory()
			else
				if goodGuysScore == 14 and badGuysScore == 14 then
					NinjaClaasicGameMode:lastRound()
				else
					GameRules:GetGameModeEntity():SetThink("Respawn", self, 5)
				end
			end
		end

		if (NinjaClaasicGameMode:numberOfGoodGuysAlive() == 0 and NinjaClaasicGameMode:numberOfBadGuysAlive() > 0) then
			EmitGlobalSound("Hero_LegionCommander.Duel.Victory")
			badGuysScore = badGuysScore + 1
      Notifications:ClearTopFromAll()
      Notifications:TopToAll({text="#Dire", style=GameRules.styles.rounds, duration=3.0})
      Notifications:TopToAll({text="#Wins", style=GameRules.styles.rounds, continue=true })
			GameMode:SetTopBarTeamValue ( DOTA_TEAM_BADGUYS, badGuysScore)
			GameMode:SetTopBarTeamValue ( DOTA_TEAM_GOODGUYS, goodGuysScore )
			roundGoing = false
			if badGuysScore == 15 then
				NinjaClaasicGameMode:BadGuysVictory()
			else
				if goodGuysScore == 14 and badGuysScore == 14 then
					NinjaClaasicGameMode:lastRound()
				else
					GameRules:GetGameModeEntity():SetThink("Respawn", self, 5)
				end
			end
		end

		if (NinjaClaasicGameMode:numberOfBadGuysAlive() == 0 and NinjaClaasicGameMode:numberOfGoodGuysAlive() == 0) then
			Notifications:ClearTopFromAll()
      Notifications:TopToAll({text="#Draw", style=GameRules.styles.rounds, duration=3.0})
			GameRules:GetGameModeEntity():SetThink("Respawn", self, 5)
			GameMode:SetTopBarTeamValue ( DOTA_TEAM_BADGUYS, badGuysScore)
			GameMode:SetTopBarTeamValue ( DOTA_TEAM_GOODGUYS, goodGuysScore )
			roundGoing = false
		end
	end
	return nil
end

function NinjaClaasicGameMode:hero_killed( keys )
   local KillerUnit = EntIndexToHScript( keys.entindex_attacker )
   local KilledUnit = EntIndexToHScript( keys.entindex_killed )
   

   if KillerUnit:GetUnitName() == "npc_dota_hero_juggernaut" then
     KillerUnit:FindAbilityByName("refraction_gold"):EndCooldown()
     KillerUnit:FindAbilityByName("shockwave_gold"):EndCooldown()
     KillerUnit:FindAbilityByName("dagger_throw_gold"):EndCooldown()
     KillerUnit:FindAbilityByName("blink_gold"):EndCooldown()
     else
     KillerUnit:FindAbilityByName("blink"):EndCooldown()
     KillerUnit:FindAbilityByName("refraction"):EndCooldown()
     KillerUnit:FindAbilityByName("shockwave"):EndCooldown()
     KillerUnit:FindAbilityByName("dagger_throw"):EndCooldown()
  end
   		Timers:CreateTimer({
		endTime = 3, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
		callback = function()
      	FindClearSpaceForUnit(KilledUnit, Vector(0,8030,3495), true)
    end
  })
	
    if GameStarted then
		Timers:CreateTimer({
		endTime = 2, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
		callback = function()
      	NinjaClaasicGameMode:EndRoundCheck()
    end
  })
    end    
end

function NinjaClaasicGameMode:lastRound()
  local random = RandomInt( 0, 3 ) 
        if random == 0 then 
           EmitGlobalSound("lastround.00")
        end
        if random == 1 then 
           EmitGlobalSound("lastround.01")
        end
        if random == 2 then 
           EmitGlobalSound("lastround.02")
        end
        if random == 3 then 
           EmitGlobalSound("lastround.03")
        end
	GameRules:GetGameModeEntity():SetThink("Respawn", self, 15)
	Timers:CreateTimer({
    endTime = 2, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
      Notifications:ClearTopFromAll()
      Notifications:TopToAll({text="#PrepareYourselves", style=GameRules.styles.rounds, duration=3.0})
    end
  })
  	Timers:CreateTimer({
    endTime = 8, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
      Notifications:ClearTopFromAll()
      Notifications:TopToAll({text="#LastRound", style=GameRules.styles.rounds, duration=3.0})
    end
  })
end


function NinjaClaasicGameMode:numberOfGoodGuysAlive()
  local goodGuysAlive = 0
  for i = 0, 9, 1 do
    if PlayerResource:GetPlayer(i) ~= nil then
      if PlayerResource:GetPlayer(i):GetTeam() == 2 then
        if PlayerResource:GetPlayer(i):GetAssignedHero():IsAlive() then
          goodGuysAlive = goodGuysAlive + 1
        end
      end
    end
  end
  return goodGuysAlive
end

function NinjaClaasicGameMode:numberOfBadGuysAlive()
  local badGuysAlive = 0
  for i = 0, 9, 1 do
    if PlayerResource:GetPlayer(i) ~= nil then
      if PlayerResource:GetPlayer(i):GetTeam() == 3 then
        if PlayerResource:GetPlayer(i):GetAssignedHero():IsAlive() then
          badGuysAlive = badGuysAlive + 1
        end
      end
    end
  end
  return badGuysAlive
end

function NinjaClaasicGameMode:GoodGuysVictory()
  GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
  GameRules:MakeTeamLose(DOTA_TEAM_BADGUYS)
end

function NinjaClaasicGameMode:BadGuysVictory()
  GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
  GameRules:MakeTeamLose(DOTA_TEAM_GOODGUYS)
end

function NinjaClaasicGameMode:SendAMsg(msg)
  local centerMessage = {
    message = msg,
    duration = 3.0
  }
  FireGameEvent( "show_center_message", centerMessage)
end
