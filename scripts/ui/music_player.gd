extends AudioStreamPlayer

@export var default_volume: float = -10.0


func start_music():
	volume_db = default_volume
	
	if not playing:
		play()


func stop_music():
	stop()


func fade_out_music():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "volume_db", -80, 2)
	
	await tween.finished
	stop_music()
