extends Spatial

func _ready():
	print("alnma")
	
func _process(delta):
	#$Camera.look_at(Vector3(10,0,0), Vector3.UP)
	pass
	
func _physics_process(delta):
	#$Camera.rotate_y(0.005)
	$Camera.look_at(Vector3(0,-18,-10), Vector3.UP)
	pass
	
