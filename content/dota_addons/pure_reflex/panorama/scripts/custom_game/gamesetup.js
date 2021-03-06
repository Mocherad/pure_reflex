var slots = [
	[
	    { abilityname: "refraction" },
 		{ abilityname: "leap" },
	],
	[
	    { abilityname: "blink" },
	    { abilityname: "swap" },

	],
	[
	    { abilityname: "shockwave" },
	    { abilityname: "boomerang" },

	],
		[
	    { abilityname: "stone_remnant" },

	],
	[
	    { abilityname: "dagger_throw" },

	]
]

var isHost = false;
var rounds = 12;

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

function OnDropDownChanged() {
	rounds = parseInt($("#TimeDropDown").GetSelected().id);
}

(function () {
	$("#PlayButton").visible = false;
	GameEvents.Subscribe("reflex_set_host", (function () {
		isHost = true;
		$("#PlayButton").visible = true;
	}))

	GameEvents.Subscribe("reflex_force_start_game", (function () {
		var gameTable = {};
		for (var i = 0; i < 5; i++) {
			gameTable[i.toString()] = $("#Abilities").FindChildTraverse("AbilitySlot" + i).FindChildTraverse("AbilityImage").abilityname;
			$.Msg(gameTable[i]);
		}
		gameTable["randomSkills"] = $("#RandomSkills").enabled;
		gameTable["anomalies"] = $("#Anomalies").enabled;
		gameTable["rounds"] = rounds;

		GameEvents.SendCustomGameEventToServer( "reflex_start_game", gameTable);
	}))

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
				if (isHost) {
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
								// $("#Abilities").FindChildTraverse("AbilitySlot" + abilitySlot.i).FindChildTraverse("AbilityImage").abilityname = ability.FindChildTraverse("AbilityImage").abilityname;
								GameEvents.SendCustomGameEventToServer( "reflex_update_skill", {"slot" : abilitySlot.i, "abilityname" : ability.FindChildTraverse("AbilityImage").abilityname});
								$("#AbilityMenuRoot").AddClass("Hidden");
								$("#AbilityMenuRoot").currentSlot = -1;
								abilitySlot.FindChildTraverse("YellowSquare").style.opacity = "0.0;";
							}));
						})();
					}
					$("#AbilityMenuRoot").RemoveClass("Hidden");
				}
			}));
 //else {
				CustomNetTables.SubscribeNetTableListener("abilities", (function (table_name, key, data) {
					for (var i = 0; i < 5; i++) {
						if (data[i.toString()]) {
							$.Msg(i.toString(), data[i.toString()]);
							$("#Abilities").FindChildTraverse("AbilitySlot" + i).FindChildTraverse("AbilityImage").abilityname = data[i.toString()];
						}
					}
				}));
			//}
		})();
	}

		Game.ShufflePlayerTeamAssignments();
		Game.AutoAssignPlayersToTeams();

	$("#PlayButton").SetPanelEvent("onactivate", (function () {

		var gameTable = {};
		for (var i = 0; i < 5; i++) {
			gameTable[i.toString()] = $("#Abilities").FindChildTraverse("AbilitySlot" + i).FindChildTraverse("AbilityImage").abilityname;
		}
		gameTable["randomSkills"] = $("#RandomSkills").enabled;
		gameTable["anomalies"] = $("#Anomalies").enabled;
		gameTable["rounds"] = rounds;

		GameEvents.SendCustomGameEventToServer( "reflex_start_game", gameTable);
	}));
})()