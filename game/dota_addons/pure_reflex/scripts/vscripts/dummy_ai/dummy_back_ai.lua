function Spawn( Enity )
local spell = thisEntity:FindAbilityByName("shockwave")
local owner = thisEntity:GetOwner() 

thisEntity:CastAbilityOnPosition(owner:GetOrigin(), spell, owner:GetPlayerOwnerID())

thisEntity:AddNewModifier( GetOwnerEntity(), nil, "modifier_kill", {duration = 1})

-- Timers:CreateTimer(0.01, function() return AI_Gyro_Think(thisEntity) end)

end

function AI_Gyro_Think(thisEnt)

  if thisEnt:IsNull() or not thisEnt:IsAlive() then
    return nil
  end

  --local flak_cannon = thisEnt:FindAbilityByName("brewmaster_thunder_clap")

  if flak_cannon:GetCooldownTimeRemaining() > 0.0 then
    return flak_cannon:GetCooldownTimeRemaining()
  end

    flak_cannon:CastAbility()

    return 1
end