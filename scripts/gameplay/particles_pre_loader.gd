extends Node2D

var blood_explosion = preload("res://particles/blood_explosion_particles.tres")
var portal_implosion = preload("res://particles/portal_implosion_particles.tres")

var particle_materials = [blood_explosion, portal_implosion]


func _ready():
	# Run all particle effecst for the first time here because Godot is unable to handle particles and it lags for the first time
	for particle_material in particle_materials:
		var particles_instance = GPUParticles2D.new()
		particles_instance.process_material = particle_material
		particles_instance.one_shot = true
		self.add_child(particles_instance)
		particles_instance.restart()
		particles_instance.emitting = true
