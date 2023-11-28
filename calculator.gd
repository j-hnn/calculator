extends Control

@onready var prev_work_area = $Screen/ColorRect/AllComponentsContainer/DisplayContainer/MarginContainer/VBoxContainer/PrevWorkArea
@onready var work_area = $Screen/ColorRect/AllComponentsContainer/DisplayContainer/MarginContainer/VBoxContainer/WorkArea
@onready var all_buttons = $Screen/ColorRect/AllComponentsContainer/AllButtons

var has_been_used := false
var first_number : float
var second_number : float
var operator := ""
var decimal_allowed = true

func _ready():
	for buttons in all_buttons.get_children():
		for btn in buttons.get_children():
			if btn.name.is_valid_int():
				btn.pressed.connect(Callable(self, "_number_buttons").bind(btn))
				
func _number_buttons(btn):
	if not has_been_used:
		work_area.text = btn.name
		has_been_used = true
	else:
		work_area.text += btn.name

func _on_equal_button_pressed():
	has_been_used = false
	var result : float
	second_number = work_area.text.to_float()
	match operator: 
		"+": 
			result = first_number + second_number
		"-": 
			result = first_number - second_number
		"*": 
			result = first_number * second_number
		"/": 
			result = first_number / second_number
	
	prev_work_area.text = str(first_number) + " " + operator + " " + str(second_number)
	work_area.text = str(snappedf(result, 0.0000000001))


func _on_add_btn_pressed():
	has_been_used = false
	first_number = work_area.text.to_float()
	operator = "+"
	prev_work_area.text = str(first_number) + " " + operator


func _on_subtract_btn_pressed():
	has_been_used = false
	first_number = work_area.text.to_float()
	operator = "-"
	prev_work_area.text = str(first_number) + " " + operator


func _on_multiply_btn_pressed():
	has_been_used = false
	first_number = work_area.text.to_float()
	operator = "*"
	prev_work_area.text = str(first_number) + " " + operator


func _on_division_btn_pressed():
	has_been_used = false
	first_number = work_area.text.to_float()
	operator = "/"
	prev_work_area.text = str(first_number) + " " + operator


func _on_delete_btn_pressed():
	if has_been_used:
		if work_area.text.length() >= 2:
			work_area.text = work_area.text.left(-1)
		else:
			work_area.text = "0"
			has_been_used = false


func _on_negative_btn_pressed():
	var result : float
	first_number = work_area.text.to_float()
	result = -first_number
	if not has_been_used:
		prev_work_area.text = "-" + str(first_number)
	else:
		prev_work_area.text = str(first_number)
		
	work_area.text = str(result)
	has_been_used = true

func _on_clear_btn_pressed():
	has_been_used = false
	prev_work_area.text = ""
	work_area.text = "0"
	decimal_allowed = true

func _on_decimal_btn_pressed():
	if decimal_allowed:
		if has_been_used == true:
			work_area.text = work_area.text + "."
			decimal_allowed = false
		else:
			work_area.text = "0"
			has_been_used = true
			decimal_allowed = false
