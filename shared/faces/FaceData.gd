extends Resource
class_name FaceData
var eye_type : int = 0:
	set(value):
		eye_type = posmod(value, 8)
var nose_type : int = 0:
	set(value):
		nose_type = posmod(value, 8)
var mouth_type : int = 0:
	set(value):
		mouth_type = posmod(value, 8)
var eye_position : Vector2i = Vector2i(2,2):
	set(value):
		eye_position = value.clamp(Vector2.ZERO, Vector2(4,6))
var nose_pos : int = 2:
	set(value):
		nose_pos = clamp(value, 0, 4)
var mouth_pos : int = 2:
	set(value):
		mouth_pos = clamp(value, 0, 4)

func copy() -> FaceData:
	var face := FaceData.new()
	face.eye_type = eye_type
	face.nose_type = nose_type
	face.mouth_type = mouth_type
	face.eye_position = eye_position
	face.nose_pos = nose_pos
	face.mouth_pos = mouth_pos
	return face
