extends Sprite

signal counter_changed(val)

var count = 0
var speed = 400
var max_size = 3
var blink = false
var angular_speed = PI
var count_lable = Label.new()

func _init():
	add_child(count_lable)
		
	count_lable.set_name("Counter")
	count_lable.text = String(count)
	count_lable.set_position(Vector2(0, -50))
	
	print("Hello, world!")
	
func _ready():
	var timer = $Timer #get_node("Timer")
	timer.wait_time = 0.25
	timer.connect("timeout", self, "_on_Timer_timeout")
	
func _process(delta):
	var direct = 0;
	
	if Input.is_action_pressed("ui_left"):
		direct = -1
	elif Input.is_action_pressed("ui_right"):
		direct = 1
		
	rotation += angular_speed * direct * delta
		
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		var xr = Vector2.UP.x * cos(rotation) - Vector2.UP.y * sin(rotation)
		var yr = Vector2.UP.y * cos(rotation) + Vector2.UP.x * sin(rotation)
		#velocity = Vector2.UP.rotated(rotation) * speed
		velocity = Vector2(xr, yr) * speed
		print(velocity)

	position += velocity * delta

func _on_HSlider_value_changed(value):
	var s = value * max_size / 100
	scale = Vector2(s, s)

func _on_Button_pressed():
	blink = not blink
	emit_signal("counter_changed", 1)
	
func _on_Sprite_counter_changed(val):
	count += val
	count_lable.text = String(count)

func _on_Timer_timeout():
	visible = not(visible and blink)
