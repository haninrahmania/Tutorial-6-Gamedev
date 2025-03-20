**Membuat level select**
Pertama, saya membuat new scene dengan MarginContainer sebagai root node, dan mengisinya dengan HBoxContainer dan VBoxContainer yang berisi Label dan LinkButtons. Saya menghubungkan Linkbuttons dengan scene Level 1 dan scene Level 2 menggunakan script, sehingga player dapat memilih ingin memainkan dari level mana. Saya juga memformat HBoxContainer supaya content tidak berdempetan di sebelah kiri scene, dengan cara mengubah Horizontal dan Vertical pada Container Sizing di Layout menjadi Shrink Center, kemudian untuk memberi sedikit gap diantara kedua bagian horizontal saya ubah value Separation menjadi 50px pada Constants di Theme Overrides. Saya juga melakukan formatting lebih pada jenis font, color, size, dan line separation pada label dan linkbuttons dengan cara meng-load font pada Theme Overrides, dan mengubah values font color dan size pada tempat yang sama.

Selanjutnya, saya membuat script untuk dihubungkan dengan masing-masing buttons untuk menuju level tertentu, sama dengan script pada scene Menu.tscn saya. pada button Level 1 saya set scene to load nya Level 1, dan untuk Level 2 saya set scene to load Level 2 pada bagian inspector. Kemudian saya menghubungkan signal pressed() di node dengan function name pada scriptnya untuk masing-masing button.

Tidak lupa saya menghubungkan button Level Select pada scene Menu dengan scene Level Select yang baru saja saya buat. Caranya sama seperti ketika menghubungkan buttons sebelumnya.

**Membuat Tombol Kembali ke Menu pada GameOver Screen**
Saya menambahkan LinkButton baru pada scene GameOver dan memposisikannya pada posisi yang saya inginkan secara manual (tidak menggunakan HboxContainer atau VboxContainer pada scene ini). Kemudian saya beri font, size, dan color yang saya inginkan, dan menghubungkan dengan script dan signal yang membuat button ini menuju scene Menu ketika di press.

**Membuat Scene Transitions**
Pertama saya membuat scene baru dengan node Control, kemudian menambahkan ColorRect dan AnimationPlayer didalamnya. Saya set warna transisi yang saya inginkan pada ColorRect, (dan memastikan transition scene ini menutupi seluruh area screen), kemudian membuat dua animation baru pada AnimationPlayer, yaitu fade_in dan fade_out. Untuk membuat efek transisi fade in, saya saya klik Add Track, Property Track, ColorRect, dan modulate. Kemudian saya menambahkan juga color dengan klik Add Track, Property Track, ColorRect, color. Sekarang pada Animation fade_in saya terdapat track modulate dan color. Pada masing-masing modulate dan color, saya klik kanan di track pada detik 0 dan klik Add Key, kemudian pada color value yang muncul di inspector saya slide value A ke kanan penuh. Selanjutnya saya klik kanan track pada detik 0.5 dan slide value A pada color yang muncul ke kiri penuh. Saya juga set panjang animation menjadi 0.5 detik pada Animation. Selanjutnya saya melakukan hal yang sama, namun di reverse urutan value A nya untuk animation fade_out.
Selanjutnya, saya menambahkan script baru untuk scene transition ini, berisi functions ini:
>>func _ready():
	$AnimationPlayer.play("fade_in")  # Mulai animasi saat scene awal dimulai

func change_scene(next_level: String):
	$AnimationPlayer.play("fade_out")  # Jalankan animasi transisi
	await $AnimationPlayer.animation_finished  # Tunggu animasi selesai
	get_tree().call_deferred("change_scene_to_file",(next_level))  # Pindah ke level berikutnya
	$AnimationPlayer.play("fade_in")  # Jalankan animasi transisi

Setelah itu, saya membuat group global baru ‘transition’ untuk scene transition ini agar dapat digunakan secara global oleh scenes lainnya. Untuk memanggil transisi tersebut, pada script yang memindahkan dari satu scene ke scene lainnya (contohnya dari level 1 ke level 2) saya menambahkan script ini untuk pemanggilan scene 
>>var transition_layer = get_tree().get_first_node_in_group("transition")
			if transition_layer:
				transition_layer.change_scene(str("res://scenes/" + sceneName + ".tscn"))

**Membuat Collectable Coins**
Untuk tambahan polishing game, saya membuat scene Coin dengan sprite coin dan collisionshape2d berbentuk lingkaran, kemudian membuat script sederhana berisi function untuk penambahan coin
>>func _on_coin_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		global.coins +=1
		queue_free()

kemudian saya menambahkan var coins = 0 ke dalam script global.gd, dan menambahkan script pada label GUI LifeCounter untuk menampilkan jumlah coins yang saat ini dimiliki player. Saya juga menambahkan pada script area2d supaya jumlah coins kembali menjadi 0 jika player mati. Setelah itu, saya memasukkan scene Coin ke dalam level 1 dan 2, agar player dapat mengenainya dan menambah coins mereka. Terakhir, saya menambahkan label pada WinScreen untuk menampilkan jumlah coins yang player berhasil kumpulkan.

