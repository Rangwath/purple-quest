extends Node

var playthrough_highscore = {}


func clear_current_playthrough_highscore():
	playthrough_highscore.clear()
	print("Current playthrough highscore cleared")


func add_playthrough_highscore(level_id, score):
	if level_id < 1:
		push_error("Level ID is undefined, passed Level ID = " + str(level_id))
		return
	
	print("Old score: " + str(playthrough_highscore.get(level_id)))
	print("New score: " + str(score))
	
	if playthrough_highscore.has(level_id):
		if playthrough_highscore.get(level_id) > score:
			print("New score is lower, returning")
			return
	
	playthrough_highscore[level_id] = score


func get_playthrough_highscore():
	return playthrough_highscore
