"use strict";

var m_Ability = -1;
var m_QueryUnit = -1;
var m_bInLevelUp = false;
var LocalPlayer = Players.GetLocalPlayer();
var controlable = true;

function SetAbility( ability, queryUnit, bInLevelUp )
{
	var bChanged = ( ability !== m_Ability || queryUnit !== m_QueryUnit );
	m_Ability = ability;
	m_QueryUnit = queryUnit;
	m_bInLevelUp = bInLevelUp;
	controlable = Entities.IsControllableByPlayer( m_QueryUnit , LocalPlayer );

	var canUpgradeRet = Abilities.CanAbilityBeUpgraded( m_Ability );
	var canUpgrade = ( canUpgradeRet == AbilityLearnResult_t.ABILITY_CAN_BE_UPGRADED );
	
	$.GetContextPanel().SetHasClass( "no_ability", ( ability == -1 ) );
	$.GetContextPanel().SetHasClass( "learnable_ability", bInLevelUp && canUpgrade );

	RebuildAbilityUI();
	UpdateAbility();
}

function AutoUpdateAbility()
{
	UpdateAbility();
	$.Schedule( 0.1, AutoUpdateAbility );
}

function UpdateAbility()
{
	var abilityButton = $( "#AbilityButton" );
	var abilityName = Abilities.GetAbilityName( m_Ability );

	var noLevel =( 0 == Abilities.GetLevel( m_Ability ) );
	var isCastable = !Abilities.IsPassive( m_Ability ) && !noLevel;
	var manaCost = Abilities.GetManaCost( m_Ability );
	var hotkey = Abilities.GetKeybind( m_Ability, m_QueryUnit );
	var unitMana = Entities.GetMana( m_QueryUnit );

	$.GetContextPanel().SetHasClass( "dont_show_level", !controlable );
	$.GetContextPanel().SetHasClass( "is_silenced", Entities.IsSilenced( m_QueryUnit ) );
	$.GetContextPanel().SetHasClass( "no_level", noLevel );
	$.GetContextPanel().SetHasClass( "is_passive", Abilities.IsPassive(m_Ability) );
	$.GetContextPanel().SetHasClass( "no_mana_cost", ( manaCost == 0 ) );
	$.GetContextPanel().SetHasClass( "insufficient_mana", ( manaCost > unitMana ) );
	$.GetContextPanel().SetHasClass( "auto_cast_enabled", ( Abilities.GetAutoCastState(m_Ability) && !is_enemy ) );
	$.GetContextPanel().SetHasClass( "toggle_enabled", ( Abilities.GetToggleState(m_Ability) && !is_enemy ) );
	$.GetContextPanel().SetHasClass( "is_active", ( m_Ability == Abilities.GetLocalPlayerActiveAbility() ) );

	abilityButton.enabled = ( ( isCastable || m_bInLevelUp ) && controlable );
	
	$( "#HotkeyText" ).text = hotkey;
	$( "#AbilityImage" ).abilityname = abilityName;
	$( "#AbilityImage" ).contextEntityIndex = m_Ability;
	$( "#ManaCost" ).text = manaCost;
	
	if ( controlable )
	{
		if ( Abilities.IsCooldownReady( m_Ability ) )
		{
			$.GetContextPanel().SetHasClass( "cooldown_ready", true );
			$.GetContextPanel().SetHasClass( "in_cooldown", false );
		}
		else
		{
			$.GetContextPanel().SetHasClass( "cooldown_ready", false );
			$.GetContextPanel().SetHasClass( "in_cooldown", true );
			var cooldownLength = Abilities.GetCooldownLength( m_Ability );
			var cooldownRemaining = Abilities.GetCooldownTimeRemaining( m_Ability );
			var cooldownPercent = Math.ceil( 100 * cooldownRemaining / cooldownLength );
			$( "#CooldownTimer" ).text = Math.ceil( cooldownRemaining );
			$( "#CooldownOverlay" ).style.width = cooldownPercent+"%";
		}
	}
	
}

function AbilityShowTooltip()
{
	var abilityButton = $( "#AbilityButton" );
	var abilityName = Abilities.GetAbilityName( m_Ability );
	if ( controlable )
		$.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", abilityButton, abilityName, m_QueryUnit );
	else
		$.DispatchEvent( "DOTAShowAbilityTooltip", abilityButton, abilityName );
}

function AbilityHideTooltip()
{
	var abilityButton = $( "#AbilityButton" );
	$.DispatchEvent( "DOTAHideAbilityTooltip", abilityButton );
}

function ActivateAbility()
{
	if ( m_bInLevelUp )
	{
		Abilities.AttemptToUpgrade( m_Ability );
		return;
	}
	Abilities.ExecuteAbility( m_Ability, m_QueryUnit, false );
}

function EndLearnMode()
{
	var nRemainingPoints = Entities.GetAbilityPoints( m_QueryUnit );
	if ( nRemainingPoints < 1 )
	{
		Game.EndAbilityLearnMode();
	}
}

function RightClickAbility()
{
	if ( m_bInLevelUp )
		return;

	if ( Abilities.IsAutocast( m_Ability ) )
	{
		Game.PrepareUnitOrders( { OrderType: dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO, AbilityIndex: m_Ability } );
	}
}

function RebuildAbilityUI()
{
	var abilityLevelContainer = $( "#AbilityLevelContainer" );
	abilityLevelContainer.RemoveAndDeleteChildren();
	if ( !controlable )
		return;
	var currentLevel = Abilities.GetLevel( m_Ability );
	for ( var lvl = 0; lvl < Abilities.GetMaxLevel( m_Ability ); lvl++ )
	{
		var levelPanel = $.CreatePanel( "Panel", abilityLevelContainer, "" );
		levelPanel.AddClass( "LevelPanel" );
		levelPanel.SetHasClass( "active_level", ( lvl < currentLevel ) );
		levelPanel.SetHasClass( "next_level", ( lvl == currentLevel ) );
	}
}

(function()
{
	$.GetContextPanel().SetAbility = SetAbility;
	GameEvents.Subscribe( "dota_ability_changed", RebuildAbilityUI );
	GameEvents.Subscribe( "dota_player_learned_ability", EndLearnMode );
	AutoUpdateAbility();
})();
