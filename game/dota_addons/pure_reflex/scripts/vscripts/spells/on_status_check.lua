function on_status_check( event )    
  local caster = event.caster
  local ability = event.ability
  local steamID = PlayerResource:GetSteamAccountID(caster:GetPlayerID())

  print(steamID)

   if steamID == 80974978 or steamID == 165298899 or steamID == 163465023 then
    caster.CustomColor = {225, 235, 255}
    
        if caster:HasModifier("modifier_golden") then
        else
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_golden", {})

        -- Add
        caster:AddAbility("refraction_gold"):SetLevel(1) 
        caster:AddAbility("shockwave_gold"):SetLevel(1) 
        caster:AddAbility("dagger_throw_gold"):SetLevel(1) 
        caster:AddAbility("blink_gold"):SetLevel(1) 
        
        -- Swap
        caster:SwapAbilities("refraction", "refraction_gold", false, true)
        caster:SwapAbilities("shockwave", "shockwave_gold", false, true)
        caster:SwapAbilities("dagger_throw", "dagger_throw_gold", false, true)
        caster:SwapAbilities("blink", "blink_gold", false, true)
       
        -- Remove pustishku
        caster:RemoveAbility("refraction") 
        caster:RemoveAbility("shockwave") 
        caster:RemoveAbility("dagger_throw") 
        caster:RemoveAbility("blink") 
        end
  end
end