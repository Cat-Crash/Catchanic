extends GameMode

@onready var puzzle_sound_player : AudioStreamPlayer2D = $PuzzleSoundPlayer
@onready var center : CenterContainer = $Center

@export var puzzle_complete_delay : float = 1

var goal_parts: int

func _ready() -> void:
	mode_type = ProjectEnums.GameState.PUZZLE
	
	var children: Array[Node] = GlobalUtilities.get_all_children(self)
# Count all parts to be installed or uninstall in scene
	for child : Node in children:
		if child is PuzzlePart:
			if child.goal_part : goal_parts += 1
		
		elif child is PuzzleGoal:
			child.part_complete.connect(_on_goal_part_complete)
	
# Remove completed part from count and check for completion
func _on_goal_part_complete(type: bool) -> void:
	if type: goal_parts -= 1
	else: push_error("Unexpected Part Type has been Completed")
	
	if goal_parts < 1: 
		puzzle_sound_player.play()
		await get_tree().create_timer(puzzle_complete_delay).timeout
		mode_done.emit(self)
	
func set_active(active: bool) -> void:
	center.visible = active
	super.set_active(active)
