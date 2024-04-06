extends Node

const HIGHSCORE_FILE_PATH = "user://game_data.dat"

var playthrough_highscore = {}


func clear_current_playthrough_highscore():
	playthrough_highscore.clear()
	print("Current playthrough highscore cleared")


func add_playthrough_highscore(level_id, score):
	print("New playthrough score " + str(score) + " for level " + str(level_id))
	print("Old playthrough score " + str(playthrough_highscore.get(level_id)))
	
	if level_id < 1:
		push_error("Level ID is undefined, passed Level ID = " + str(level_id))
		return
	
	if playthrough_highscore.has(level_id):
		if playthrough_highscore.get(level_id) > score:
			print("New playthrough score is lower, returning")
			return
	
	playthrough_highscore[level_id] = score
	add_total_highscore(level_id, score)


func get_playthrough_highscore():
	return playthrough_highscore


func add_total_highscore(level_id, score):
	if level_id < 1:
		push_error("Level ID is undefined, passed Level ID = " + str(level_id))
		return
	
	var highscore_file = FileAccess.open(HIGHSCORE_FILE_PATH, FileAccess.READ)
	
	var old_score = 0
	var saved_highscore = {}
	
	if highscore_file != null:
		saved_highscore = highscore_file.get_var()
		if saved_highscore is Dictionary:
			if saved_highscore.has(level_id):
				old_score = saved_highscore.get(level_id)
		else:
			print("Loaded highscore file is not a Dictionary, creating new Dictionary")
			saved_highscore = {}
	
	print("New total score " + str(score) + " for level " + str(level_id))
	print("Old total score " + str(old_score))
	
	if old_score > score:
		print("New total score is lower, returning")
		return
	
	saved_highscore[level_id] = score
	
	highscore_file = FileAccess.open(HIGHSCORE_FILE_PATH, FileAccess.WRITE)
	highscore_file.store_var(saved_highscore)


func get_total_highscore():
	var highscore_file = FileAccess.open(HIGHSCORE_FILE_PATH, FileAccess.READ)
	
	if highscore_file == null:
		print("Highscore file doesn't exist, returning empty Dictionary")
		return {}
	
	var saved_highscore = highscore_file.get_var()
	
	if saved_highscore is Dictionary:
		return saved_highscore
	else:
		print("Opened highscore file is not of a Dictionary type, returning empty Dictionary")
		return {}
