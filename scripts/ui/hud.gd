extends Control


func set_gems_amount_label(amount):
	$GemsPanel/GemsAmountLabel.text = str(amount)


func set_timer_label(time):
	$TimerPanel/TimerLabel.text = str(time)
