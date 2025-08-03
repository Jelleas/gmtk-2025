extends VBoxContainer

class_name ShopItem

signal item_bought(modifier: TotemPieces.TotemPiece)

var item: TotemPieces.TotemPiece

const RARITY_COLOR_MAP = {
	null: Color(0, 0, 0, 0),
	TotemPieces.Rarity.COMMON: Color(0.62, 0.62, 0.62, 1), # grey
	TotemPieces.Rarity.UNCOMMON: Color(0.12, 1, 0, 1), # green
	TotemPieces.Rarity.RARE: Color(0, 0.44, 0.87, 1), # blue
	TotemPieces.Rarity.EPIC: Color(0.64, 0.21, 0.93, 1), # purple
	TotemPieces.Rarity.LEGENDARY: Color(1, 0.5, 0, 1), # orange
	TotemPieces.Rarity.GAMING: Color(1, 0.84, 0, 1), # gold
}

func _ready() -> void:
	style_button()
	$Button.button_up.connect(_on_button_up)
	$HBoxContainer/TextureRect.texture = BonesTracker.get_bones_image(23, 23)

func init(item_: TotemPieces.TotemPiece) -> void:
	item = item_
	$Button.icon = item.icon
	tooltip_text = item.description
	$Button.tooltip_text = item.description
	$HBoxContainer/NameLabel.text = item.name
	$HBoxContainer/PriceLabel.text = str(item.price)
	style_button()

func enable() -> void:
	$HBoxContainer/NameLabel.self_modulate.a = 1.0
	$HBoxContainer/PriceLabel.self_modulate.a = 1.0
	$Button.disabled = false
	
func disable() -> void:
	$HBoxContainer/NameLabel.self_modulate.a = 0.5
	$HBoxContainer/PriceLabel.self_modulate.a = 0.5
	$Button.disabled = true

func _on_button_up() -> void:
	if item != null:
		item_bought.emit(item)

func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = for_text
	return label

func style_button():
	var button = $Button
	button.custom_minimum_size = Vector2(100, 50)
	
	var rarity = null if item == null else item.rarity
	
	# Create the StyleBoxes
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.89, 0.86, 0.79, 0.20)
	normal_style.set_corner_radius_all(3)
	normal_style.set_border_width_all(3)
	normal_style.border_color = RARITY_COLOR_MAP[rarity]
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.89, 0.86, 0.79, 0.40)
	hover_style.set_corner_radius_all(3)
	hover_style.set_border_width_all(3)
	hover_style.border_color = RARITY_COLOR_MAP[rarity]

	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.89, 0.86, 0.79, 0.60)
	pressed_style.set_corner_radius_all(3)
	pressed_style.set_border_width_all(3)
	pressed_style.border_color = RARITY_COLOR_MAP[rarity]
	
	var disabled_style = StyleBoxFlat.new()
	disabled_style.bg_color = Color(0.89, 0.86, 0.79, 0.05)
	disabled_style.set_corner_radius_all(3)
	disabled_style.set_border_width_all(3)
	var c = RARITY_COLOR_MAP[rarity]
	c.a = min(c.a, 0.3)
	disabled_style.border_color = c
	
	# Apply StyleBoxes via theme overrides
	button.set("theme_override_styles/normal", normal_style)
	button.set("theme_override_styles/hover", hover_style)
	button.set("theme_override_styles/pressed", pressed_style)
	button.set("theme_override_styles/disabled", disabled_style)
