extends Node3D

@export var blood: PackedScene
@export var child_friendly: bool = false

func _input(event):
	if event is InputEventKey and event.pressed:
		#Get input vector from arrow keys
		var input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		_splatter(6, Vector3(input_vector.x,0,input_vector.y))

func _splatter(power, splatter_dir):
	#instatiate the blood effect
	var _blood = blood.instantiate()
	var process_mat: ParticleProcessMaterial = _blood.process_material
	
	if child_friendly:
		process_mat.hue_variation_max = 1 #set the max hue variation to 1 for a confetti effect :D
	else:
		process_mat.hue_variation_max = 0

	process_mat.direction = splatter_dir
	process_mat.initial_velocity_min = power * 0.3
	process_mat.initial_velocity_max = power
	#make sure the blood scene is one shot and emmiting before adding it to the tree
	_blood.one_shot = true
	_blood.emitting = true 
	#add blood scene to the scene
	get_tree().root.add_child(_blood)
	_blood.global_position = global_position
