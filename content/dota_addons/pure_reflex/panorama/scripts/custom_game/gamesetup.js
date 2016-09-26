var slots = [
	[
	    { abilityname: "refraction" },
		{ abilityname: "mirana_leap_datadriven" },
		{ abilityname: "life_stealer_consume" }
	],
	[
	    { abilityname: "blink" },
		{ abilityname: "mirana_leap_datadriven" },
		{ abilityname: "life_stealer_consume" }
	],
	[
	    { abilityname: "shockwave" },
		{ abilityname: "life_stealer_consume" },
		{ abilityname: "life_stealer_consume" }
	],
		[
	    { abilityname: "stone_remnant" },
		{ abilityname: "naga_siren_rip_tide" },
		{ abilityname: "naga_siren_riptide" }
	],
	[
	    { abilityname: "dagger_throw" },
		{ abilityname: "life_stealer_consume" },
		{ abilityname: "life_stealer_consume" }
	]
]

function CheckForHostPrivileges()
{
	var playerInfo = Game.GetLocalPlayerInfo();
	if ( !playerInfo ) {
		$("#PlayButton").enabled = false;
		return;
	}
 
	Game.SetAutoLaunchEnabled( false );
}

function ClearPanel(p) {
	$.Each(p.Children(), function (panel) {
		panel.DeleteAsync(0.0);
		panel.RemoveAndDeleteChildren();
	})
}

function SetupTooltips(panel) {
	panel.SetPanelEvent("onmouseover", (function () {
		$.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", panel, panel.abilityname, 0 );
	}));
	panel.SetPanelEvent("onmouseout", (function () {
		$.DispatchEvent( "DOTAHideAbilityTooltip", panel );
	}));
}

(function () {
	CheckForHostPrivileges()

	Game.PlayerJoinTeam(2);

	ClearPanel($("#Abilities"));

	for (var i = 0; i < 5; i++) {
		(function () {
			var abilitySlot = $.CreatePanel( "Panel", $("#Abilities"), "AbilitySlot" + i );
			abilitySlot.BLoadLayoutSnippet("Ability");

			var yellowSquare = $.CreatePanel( "Panel", abilitySlot, "YellowSquare" );
			yellowSquare.BLoadLayoutSnippet("YellowSquare");
			yellowSquare.style.opacity = "0.0;";

			abilitySlot.i = i;

			abilitySlot.FindChildTraverse("AbilityImage").abilityname = slots[i][0].abilityname;
			SetupTooltips(abilitySlot.FindChildTraverse("AbilityImage"))

			abilitySlot.FindChildTraverse("AbilityImage").SetPanelEvent("onmouseactivate", (function () {
				if ($("#AbilityMenuRoot").currentSlot == abilitySlot.i) {
					$("#AbilityMenuRoot").AddClass("Hidden");
					$("#AbilityMenuRoot").currentSlot = -1;
					abilitySlot.FindChildTraverse("YellowSquare").style.opacity = "0.0;";
					return;
				} else if ($("#AbilityMenuRoot").currentSlot >= 0) {
					$("#Abilities").FindChildTraverse("AbilitySlot" + $("#AbilityMenuRoot").currentSlot).FindChildTraverse("YellowSquare").style.opacity = "0.0;";
				}
				
				ClearPanel($("#AbilityMenuRoot"));
				abilitySlot.FindChildTraverse("YellowSquare").style.opacity = "1.0;";
				$("#AbilityMenuRoot").currentSlot = abilitySlot.i;
				for (var x = 0; x < slots[abilitySlot.i].length; x++) {
					(function () {
						var ability = $.CreatePanel( "Panel", $("#AbilityMenuRoot"), "Ability" + x );
						ability.BLoadLayoutSnippet("Ability");
						ability.x = x;

						ability.FindChildTraverse("AbilityImage").abilityname = slots[abilitySlot.i][x].abilityname;
						SetupTooltips(ability.FindChildTraverse("AbilityImage"))

						ability.FindChildTraverse("AbilityImage").SetPanelEvent("onmouseactivate", (function () {
							$("#Abilities").FindChildTraverse("AbilitySlot" + abilitySlot.i).FindChildTraverse("AbilityImage").abilityname = ability.FindChildTraverse("AbilityImage").abilityname;
							$("#AbilityMenuRoot").AddClass("Hidden");
							$("#AbilityMenuRoot").currentSlot = -1;
							abilitySlot.FindChildTraverse("YellowSquare").style.opacity = "0.0;";
						}));
					})();
				}
				$("#AbilityMenuRoot").RemoveClass("Hidden");
			}));
		})();
	}

	$("#PlayButton").SetPanelEvent("onactivate", (function () {
		var gameTable = {};
		for (var i = 0; i < 5; i++) {
			gameTable[i.toString()] = $("#Abilities").FindChildTraverse("AbilitySlot" + i).FindChildTraverse("AbilityImage").abilityname;
			$.Msg(gameTable[i]);
		}
		gameTable["randomSkills"] = $("#RandomSkills").enabled;
		gameTable["anomalies"] = $("#Anomalies").enabled;

		GameEvents.SendCustomGameEventToServer( "reflex_start_game", gameTable);
	}));
})()