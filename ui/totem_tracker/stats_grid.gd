extends GridContainer

func set_stats(totem: Totem):
	$DamageNumberLabel.text = fmt(totem.get_damage())
	$CooldownNumberLabel.text = fmt(totem.get_cooldown()) + "S"
	$CritNumberLabel.text = fmt(totem.get_crit() * 100.0) + "%"
	$RangeNumberLabel.text = fmt(totem.get_range() / 100.0) + "m"
	$EnergyCostNumberLabel.text = fmt(1 + (totem.get_energy_cost() / 100.0))

func fmt(n: float) -> String:
	return str(round(n * 10) / 10.0)
