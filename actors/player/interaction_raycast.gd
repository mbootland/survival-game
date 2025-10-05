extends RayCast3D

var is_hitting := false

func check_interaction() -> void:
	if is_colliding():
		var collider := get_collider()
		if not collider is Interactable:
			return

		if Input.is_action_just_pressed("interact"):
			if collider is Interactable:
				collider.start_interaction()

		if not is_hitting:
			is_hitting = true
			EventSystem.BUL_create.emit(BulletinConfig.Keys.InteractionPrompt, collider.prompt)
			
	elif is_hitting:
		is_hitting = false
		EventSystem.BUL_destroy.emit(BulletinConfig.Keys.InteractionPrompt)
