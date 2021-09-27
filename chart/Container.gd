extends Position3D

var array = []
var rng = RandomNumberGenerator.new()

var LineDrawer = preload("res://DrawLine3D.gd").new() #In 'global' scope  

func read_csv():
	var file = File.new()
	file.open("./data.csv", File.READ)
	var content = []
	
	while not file.eof_reached():
		var line = file.get_line()
		content.append(separate_line(line))
	
	file.close()
	return content

func separate_line(line):
	var result = []
	var part = ""
	for i in range(len(line)):
		if not line[i] == ',':
			part += line[i]
		else:
			result.append(part)
			part = ""
	result.append(part)
	return result

func fill_array():
	var csv_file = read_csv()
	#print(csv_file)
	var array = []
	
	for i in range(22):
		array.append([])
	
	var csv_index = 0
	for i in range(22):
		for j in range(22):
			if(csv_index > 483):
				pass
			else:
				csv_index += 1
			array[i].append(float(csv_file[csv_index][2]))
			#print(float(csv_file[csv_index][2]))
			#array[i].append(rng.randf_range(2,6))
	return array


func draw_are():
	var color = 254
	var n = 800
	for i in range(1,len(array)):
		for j in range(1,len(array)-1):
			#print(str(i) + ' ' + str(j) + ' ' + str(array[j][i]))
			var from = Vector3(j, (array[j][i] / n) + 1.2,i)
			var to = Vector3(j+1, (array[j+1][i] / n) + 1.2, i)
			LineDrawer.DrawLine(from, to, Color(array[j+1][i] / color - 2, array[j+1][i] / fmod(color, 255), array[j+1][i] / color - 1), INF)
	
	
	
	for i in range(1,len(array)-1):
		for j in range(1,len(array)):
			#print(str(i) + ' ' + str(j) + ' ' + str(array[j][i]))
			var from = Vector3(j, (array[j][i] / n) + 1.2,i)
			var to = Vector3(j, (array[j][i+1] / n) + 1.2, i+1)
			LineDrawer.DrawLine(from, to, Color(array[j][i+1] / color - 2, array[j][i+1] / fmod(color, 255), array[j][i+1] / color - 1), INF)
			self.add_child(LineDrawer)


func _ready():
	#LineDrawer.DrawLine(Vector3(0, 0, 0), Vector3(1, 2, 0), Color(0, 0, 1), INF)
	add_child(LineDrawer) #At some point before calling the desired draw function(s) e.g. in '_ready()'
	array = fill_array()
	
	#draw_are()
	
	for i in range(22):
		for j in range(22):
			var cube_for = CSGBox.new()
			cube_for.transform.origin = Vector3((j/1.43)-7,0,(i/1.43)-7)
			cube_for.height = array[j][i] / 800.0
			cube_for.width = 0.7
			cube_for.depth = 0.7
			#cube_for.rotate_y(500)
			var material = SpatialMaterial.new()
			
			material.albedo_color = Color(array[j][i] / 6000.0, array[j][i] / 6000.0, array[j][i] / 6000.0)
			cube_for.set_material(material)
			#cube_for.radius=0.2
			self.add_child(cube_for)


func _input(event):
	var sensitivity = 0.002
	if(Input.is_action_pressed("drag")):
			if event is InputEventMouseMotion:
				self.rotate_object_local(Vector3.UP, event.relative.x * sensitivity)
		

func _physics_process(delta):
	#self.rotate_y(0.005)
	pass
