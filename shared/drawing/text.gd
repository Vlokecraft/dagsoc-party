extends RefCounted

const FONT: Font = preload("res://shared/assets/fonts/retro_pixel_cute_prop.ttf")
const DEFAULT_FONT_SIZE: int = 32


static func measure_text(
	text: String,
	font_size: int = DEFAULT_FONT_SIZE
) -> Vector2:
	return FONT.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size)


## Call from the canvas item's _draw(); position is the text baseline.
static func draw_text(
	canvas_item: CanvasItem,
	text: String,
	position: Vector2,
	font_size: int = DEFAULT_FONT_SIZE,
	colour: Color = Color.WHITE,
):
	canvas_item.draw_string(FONT, position, text, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size, colour)
