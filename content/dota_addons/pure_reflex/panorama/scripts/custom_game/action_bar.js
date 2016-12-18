"use strict";

var m_AbilityPanels = []; // created up to a high-water mark, but reused when selection changes

function OnLevelUpClicked()
{
	if ( Game.IsInAbilityLearnMode() )
	{
		Game.EndAbilityLearnMode();
		UpdateAbilityList();
	}
	else
	{
		Game.EnterAbilityLearnMode();
		UpdateAbilityList();
	}
}

function UpdateAbilityList()
{
	var abilityListPanel = $( "#ability_list" );
	if ( !abilityListPanel )
		return;

	var queryUnit = Players.GetLocalPlayerPortraitUnit();

	// see if we can level up
	var nRemainingPoints = Entities.GetAbilityPoints( queryUnit );
	var bPointsToSpend = ( nRemainingPoints > 0 );
	var bControlsUnit = Entities.IsControllableByPlayer( queryUnit, Game.GetLocalPlayerID() );
	$.GetContextPanel().SetHasClass( "could_level_up", ( bControlsUnit && bPointsToSpend ) );
	$( "#LevelUpButtonInsetText_2" ).text ="+"+nRemainingPoints;

	// update all the panels
	var nUsedPanels = 0;
	for ( var i = 0; i < Entities.GetAbilityCount( queryUnit ); ++i )
	{
		var ability = Entities.GetAbility( queryUnit, i );
		if ( ability == -1 )
			continue;

		if ( !Abilities.IsDisplayedAbility(ability) )
			continue;
		
		if ( nUsedPanels >= m_AbilityPanels.length )
		{
			// create a new panel
			var abilityPanel = $.CreatePanel( "Panel", abilityListPanel, "" );
			abilityPanel.BLoadLayout( "file://{resources}/layout/custom_game/action_bar_ability.xml", false, false );
			m_AbilityPanels.push( abilityPanel );
		}

		// update the panel for the current unit / ability
		var abilityPanel = m_AbilityPanels[ nUsedPanels ];
		abilityPanel.SetAbility( ability, queryUnit, Game.IsInAbilityLearnMode() );
		
		nUsedPanels++;
	}

	// clear any remaining panels
	for ( var i = nUsedPanels; i < m_AbilityPanels.length; ++i )
	{
		var abilityPanel = m_AbilityPanels[ i ];
		abilityPanel.SetAbility( -1, -1, false );
	}
}

(function()
{
	GameEvents.Subscribe( "dota_portrait_ability_layout_changed", UpdateAbilityList );
	GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateAbilityList );
	GameEvents.Subscribe( "dota_player_update_query_unit", UpdateAbilityList );
	GameEvents.Subscribe( "dota_ability_changed", UpdateAbilityList );
	GameEvents.Subscribe( "dota_hero_ability_points_changed", UpdateAbilityList );

    var parent = $.GetContextPanel().GetParent();
    while(parent.id != "Hud")
        parent = parent.GetParent();

    var dire = parent.FindChildTraverse("TopBarDireScore");
    dire.visible = false;
    var radiant = parent.FindChildTraverse("TopBarRadiantScore");
    radiant.visible = false;

    dire = $.CreatePanel("Label", dire.GetParent(), "ScoreDire");
    radiant = $.CreatePanel("Label", radiant.GetParent(), "ScoreRadiant");

    dire.GetParent().MoveChildAfter(dire, parent.FindChildTraverse("TopBarDireScore"))

    radiant.style.horizontalAlign = "left;";
    radiant.style.marginLeft = "4px;";

    dire.style.horizontalAlign = "right;";
    dire.style.marginRight = "4px;";

    radiant.style.color = dire.style.color = "white;";
    radiant.style.fontSize = dire.style.fontSize = "22px;";
    radiant.style.fontWeight = dire.style.fontWeight = "bold;";
    radiant.style.fontFamily = dire.style.fontFamily = "RadianceM;";
    radiant.style.height = dire.style.height = "38px;";
    radiant.style.width = dire.style.width = "50px;";
    radiant.style.textAlign = dire.style.textAlign = "center;";
    radiant.style.marginTop = dire.style.marginTop = "7px;";
    radiant.style.zIndex = dire.style.zIndex = "5;";

    dire.text = "0";
    radiant.text = "0";

    GameEvents.Subscribe( "update_score", function (args) {
    	$.Msg(args);
	    dire.text = args.badGuysScore;
	    radiant.text = args.goodGuysScore;
    } );

	UpdateAbilityList(); // initial update
})();

