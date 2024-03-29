extends Node

var gem_pickup = preload("res://assets/sounds/gem-pickup.wav")
var player_spawn = preload("res://assets/sounds/player-spawn.wav")
var player_death = preload("res://assets/sounds/player-death.wav")
var portal = preload("res://assets/sounds/portal.wav")
var win = preload("res://assets/sounds/win.wav")


func play_sfx(stream, node_name, volume):
	var audio_stream_player = AudioStreamPlayer.new()
	
	audio_stream_player.stream = stream
	audio_stream_player.name = node_name
	audio_stream_player.volume_db = volume
	
	add_child(audio_stream_player)
	
	audio_stream_player.play()
	
	await  audio_stream_player.finished
	audio_stream_player.queue_free()


func play_gem_pickup_sfx():
	play_sfx(gem_pickup, "GemPickupSFX", -5)


func play_player_spawn_sfx():
	play_sfx(player_spawn, "PlayerSpawnSFX", -3)


func play_player_death_sfx():
	play_sfx(player_death, "PlayerDeathSFX", 5)


func play_portal_sfx():
	play_sfx(portal, "PortalSFX", 0)


func play_win_sfx():
	play_sfx(win, "WinSFX", 10)
