extends ParallaxLayer


func _process(delta):
	self.motion_offset.x += -10 * delta
