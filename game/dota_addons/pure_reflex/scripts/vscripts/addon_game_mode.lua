-- Generated from template

if NinjaClaasicGameMode == nil then
  NinjaClaasicGameMode = class({})
end

require("libraries/timers")
require("libraries/projectiles")
require("libraries/notifications")
require( "libraries/physics")

BUILD = {}
RANDOM_SKILLS = false
ANOMALIES = false
ROUNDS = 12

TEAM_COLORS = {}                        -- If USE_CUSTOM_TEAM_COLORS is set, use these colors.
TEAM_COLORS[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }  --    Teal
TEAM_COLORS[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }   --    Yellow
TEAM_COLORS[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }  --    Pink
TEAM_COLORS[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }   --    Orange
TEAM_COLORS[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }   --    Blue
TEAM_COLORS[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }  --    Green
TEAM_COLORS[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }   --    Brown
TEAM_COLORS[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }  --    Cyan
TEAM_COLORS[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }  --    Olive
TEAM_COLORS[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }  --    Purple

local noData = true

function Precache( context )

  PrecacheUnitByNameSync("npc_dota_hero_juggernaut", context)
  PrecacheUnitByNameSync("npc_dota_hero_phantom_assassin", context)

  PrecacheResource( "particle","particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf", context)
  PrecacheResource( "particle","particles/deadwave_gold/deadwave_gold.vpcf", context)
  PrecacheResource( "particle","particles/deadwave/deadwave.vpcf", context)
  
  PrecacheResource( "particle","particles/shuriken_gold/shuriken_gold.vpcf", context)
  PrecacheResource( "particle","particles/boomerang/boomerang.vpcf", context)

  PrecacheResource( "particle","particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", context)
  PrecacheResource( "particle","particles/dagger_hephaestus/dagger_hephaestus.vpcf", context)

  PrecacheResource( "particle","particles/swap_gold/swap_gold.vpcf", context) 
  PrecacheResource( "particle","particles/swap_gold/swap_gold_target.vpcf", context) 
  PrecacheResource( "particle","particles/swap/swap.vpcf", context) 
  PrecacheResource( "particle","particles/swap/swap_target.vpcf", context) 

  PrecacheResource( "particle","particles/shockwave/shockwave.vpcf", context) 
  PrecacheResource( "particle","particles/shockwave_gold/shockwave_gold.vpcf", context) 

  PrecacheResource( "particle","particles/refraction/refraction.vpcf", context) 
  PrecacheResource( "particle","particles/refraction_gold/refraction_gold.vpcf", context) 
  PrecacheResource( "particle","particles/refraction_hephaestus/refraction_hephaestus.vpcf", context) 

  PrecacheResource( "particle","particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf", context) 

  PrecacheResource( "particle","particles/stone_remnant/stone_remnant.vpcf", context) 
  PrecacheResource( "particle","particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", context) 

  PrecacheResource( "particle","particles/econ/items/undying/undying_manyone/undying_pale_gold_tower_destruct_flashbang.vpcf", context)

  PrecacheResource("soundfile",  "soundevents/custom_sounds.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_items.vsndevts", context) 
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_queenofpain.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_earth_spirit.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_vengefulspirit.vsndevts", context)
  PrecacheResource("soundfile",  "soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts", context)


   print("cash comlited")

end

-- Create the game mode when we activate
function Activate()
  SendToServerConsole( 'dota_create_fake_clients 3' )
  GameRules.AddonTemplate = NinjaClaasicGameMode()
  GameRules.AddonTemplate:InitGameMode()
  print("mod activeted")
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
  GameRules:GetGameModeEntity():SetThink("GameStartMsg", self, 0)
  GameRules:SetSameHeroSelectionEnabled(true)
  GameMode:SetTopBarTeamValuesOverride (true)
  GameMode:SetBuybackEnabled(false)
  GameRules:SetGoldPerTick(0)
  GameRules:SetUseBaseGoldBountyOnHeroes(false)
  GameMode:SetCameraDistanceOverride(1360)
  GameRules:SetFirstBloodActive(true)
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_SHOP, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_COURIER, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_INVENTORY_QUICKBUY, false )
  GameRules:GetGameModeEntity():SetHUDVisible( DOTA_HUD_VISIBILITY_SHOP_SUGGESTEDITEMS, false )
  GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_wisp")
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
  ListenToGameEvent('npc_spawned', Dynamic_Wrap(NinjaClaasicGameMode, 'OnNPCSpawned'), self)

  -- ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(NinjaClaasicGameMode, 'CreateHeroes'), self)

  self.vUserIds = {}
  self.splIds = {}
  print("mod inited")
end

function NinjaClaasicGameMode:OnNPCSpawned(keys)
  local npc = EntIndexToHScript(keys.entindex)

  if npc:IsRealHero() and npc.bFirstSpawned == nil then
    npc.bFirstSpawned = true
    NinjaClaasicGameMode.spawnedArray = NinjaClaasicGameMode.spawnedArray or {}

    if not NinjaClaasicGameMode.spawnedArray[npc:GetPlayerOwnerID()] then
      NinjaClaasicGameMode:CreateHero(npc:GetPlayerOwnerID(), npc)
      NinjaClaasicGameMode.spawnedArray[npc:GetPlayerOwnerID()] = true
    end
  end
end

function NinjaClaasicGameMode:UpdateSkill(args)
  local abilities = CustomNetTables:GetTableValue("abilities","abilities")
  abilities[tostring(args.slot)] = args.abilityname
  CustomNetTables:SetTableValue("abilities","abilities",abilities)
  print("UpdateSkill")
end

function NinjaClaasicGameMode:FinishGameSetup(args)
  GameRules:LockCustomGameSetupTeamAssignment( true )
  for i=0,5 do
    table.insert(BUILD, args[tostring(i)])
  end
  EmitGlobalSound("start_gof_01")
  GameRules:SetPreGameTime(16)
  GameRules:SendCustomMessage("#Welcome", 0, 0)
  Timers:CreateTimer( 16, function()
  NinjaClaasicGameMode:Respawn()
  end)

  RANDOM_SKILLS = args.randomSkills
  ANOMALIES = args.anomalies

  ROUNDS = args.rounds
  print(ROUNDS)

  noData = false
  local s = 3
  for pID = 0, DOTA_MAX_PLAYERS do
    if PlayerResource:IsValidPlayerID(pID) then
      if not PlayerResource:IsBroadcaster(pID) then
        if PlayerResource:GetConnectionState(pID) >= 1 then
          if s == 2 then
            s = 3
          else
            s = 2
          end
          PlayerResource:GetPlayer(pID):SetTeam(s)
        end
      end
    end
  end

  GameRules:FinishCustomGameSetup()
  
    print("FinishGameSetup")
end

function NinjaClaasicGameMode:InitHero(hero)
  local steamID = PlayerResource:GetSteamAccountID(hero:GetPlayerID())
  for i=0,16 do
    if hero:GetAbilityByIndex(i) then
      hero:RemoveAbility(hero:GetAbilityByIndex(i):GetName())
    end
  end
  for k,v in pairs(BUILD) do
    if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
       if hero:HasAbility(v.."_gold") then
       --
       else
       hero:AddAbility(v.."_gold")
       end
    else
       if hero:HasAbility(v) then
       --
       else
       hero:AddAbility(v)
       end
    end
  end
  hero:AddAbility("on_respawn_protect")
  hero:AddAbility("blood_spatter")
  hero:AddAbility("on_status_check")
  for i=0,16 do
    if hero:GetAbilityByIndex(i) then
      hero:GetAbilityByIndex(i):SetLevel(1)
    end
  end

print("InitHero")
end

function NinjaClaasicGameMode:CreateHero(i, hero)
  --print("Game State Changed: " .. GameRules:State_Get())
  --print("Hero Selection State: " .. DOTA_GAMERULES_STATE_HERO_SELECTION)
  -- if GameRules:State_Get() == 3 then
  -- print("Entered IF")
    if PlayerResource:GetPlayer(i) ~= nil then
      player = PlayerResource:GetPlayer(i)
      if hero:GetUnitName() == "npc_dota_hero_wisp" then
        local team = player:GetTeamNumber() 
        print("team ".. team)
        -- UTIL_Remove(hero)
        local newHero
        if team == 3 then 
          PrecacheUnitByNameAsync("npc_dota_hero_phantom_assassin", function() 
            newHero = PlayerResource:ReplaceHeroWith(i,"npc_dota_hero_phantom_assassin",0,0)
            NinjaClaasicGameMode:InitHero(newHero)
            newHero:SetHasInventory( false )
            UTIL_Remove(hero)
          end, i)
        else
          PrecacheUnitByNameAsync("npc_dota_hero_juggernaut", function() 
            newHero = PlayerResource:ReplaceHeroWith(i,"npc_dota_hero_juggernaut",0,0)
            NinjaClaasicGameMode:InitHero(newHero)
            newHero:SetHasInventory( false )
            UTIL_Remove(hero)
          end, i)
        end
      end
    end
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
              player = PlayerResource:GetPlayer(i)
              if PlayerResource:GetPlayer(i) ~= nil and player:GetAssignedHero() then
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
  if GameRules:State_Get() == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
  	timeToStart = 15
    DeepPrintTable(keys)
  	print("OnGameRulesStateChange 1")
    Timers:CreateTimer(1, function()
        for i = 0, 9, 1 do
          if PlayerResource:GetPlayer(i) ~= nil and GameRules:PlayerHasCustomGameHostPrivileges(PlayerResource:GetPlayer(i)) then
            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(i), "reflex_set_host", {})
          end 
        end 
      end
    )
  print("OnGameRulesStateChange 2")
  elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS and noData == true then
    print("OnGameRulesStateChange 3")
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
print("OnConnectFull")
 
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
  print("HeroPicked")
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
  
  
  if ROUND == 1 then
    ListenToGameEvent('entity_killed', Dynamic_Wrap(NinjaClaasicGameMode, 'hero_killed'), self)
    GameRules:SetHeroRespawnEnabled(false)
    GameStarted = true
  end
  Notifications:ClearTopFromAll()
  Notifications:TopToAll({text="#Round", style=GameRules.styles.rounds, duration=3.0})
  Notifications:TopToAll({text=ROUND, style=GameRules.styles.rounds, continue=true })
  for i = 0, 9, 1 do
    local player = PlayerResource:GetPlayer(i)
    if player ~= nil and player:GetAssignedHero() then
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
			if goodGuysScore == ROUNDS then
				NinjaClaasicGameMode:GoodGuysVictory()
			else
				if goodGuysScore == (ROUNDS-1) and badGuysScore == (ROUNDS-1) then
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
			if badGuysScore == ROUNDS then
				NinjaClaasicGameMode:BadGuysVictory()
			else
				if goodGuysScore == (ROUNDS-1) and badGuysScore == (ROUNDS-1) then
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
   
    for i=0,16 do
    if KillerUnit:GetAbilityByIndex(i) and KillerUnit:GetAbilityByIndex(i):GetSpecialValueFor('ultimate') == 0 then
      KillerUnit:GetAbilityByIndex(i):EndCooldown()
    end
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
