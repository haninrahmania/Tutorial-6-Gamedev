extends Control


func _ready():
	$AnimationPlayer.play("fade_in")  # Mulai animasi saat scene awal dimulai

func change_scene(next_level: String):
	$AnimationPlayer.play("fade_out")  # Jalankan animasi transisi
	await $AnimationPlayer.animation_finished  # Tunggu animasi selesai
	get_tree().call_deferred("change_scene_to_file",(next_level))  # Pindah ke level berikutnya
	$AnimationPlayer.play("fade_in")  # Jalankan animasi transisi
