extends Node3D

const RAY_LENGTH = 1000
@onready var camera_3d: Camera3D = $Camera3D
var mouse_clique := false
var debug := true
var cubo_debug = preload("res://cubo_debug.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
		if mouse_clique:
			mouse_clique = false
			# Obtém o estado atual do espaço 3D para fazer consultas de física
			var space_state := get_world_3d().direct_space_state
			
			# Obtém a posição atual do mouse na janela de visualização (em pixels)
			var mousepos := get_viewport().get_mouse_position()
			
			# Calcula o ponto de ORIGEM do raio no mundo 3D baseado na posição do mouse
			# (Converte coordenada 2D do mouse para um ponto 3D na câmera)
			var origin := camera_3d.project_ray_origin(mousepos)
			
			# Calcula o ponto FINAL do raio:
			# 1. Obtém a direção normalizada do raio a partir da câmera
			# 2. Multiplica pela extensão máxima do raio (RAY_LENGTH)
			# 3. Soma com a origem para obter o ponto final no mundo 3D
			var end := origin + camera_3d.project_ray_normal(mousepos) * RAY_LENGTH
			
			# Cria os parâmetros para a consulta de raycast físico:
			# - Define os pontos de início (origin) e fim (end) do raio
			var query := PhysicsRayQueryParameters3D.create(origin, end)
			
			# Configura se o raycast deve detectar colisões com ÁREAS (Area3D):
			# - false = detecta apenas corpos físicos (PhysicsBody3D como StaticBody, RigidBody)
			# - true = detecta tanto corpos físicos quanto áreas
			query.collide_with_areas = false
			
			# Executa efetivamente o raycast com os parâmetros configurados
			# Retorna um dicionário com informações da colisão ou vazio se não houve colisão
			var result = space_state.intersect_ray(query)
			
			# Imprime o resultado no console (útil para debug durante desenvolvimento)
			if result:
				print(result)
				print("Position: " + str(result.position))
				print("Normal: " + str(result.normal))
				print("Collider: " + str(result.collider))
				var cubo_d = cubo_debug.instantiate()
				add_child(cubo_d)
				cubo_d.position = result.position

			else:
				print("Errou")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		mouse_clique = true
		#print("Clique detectado (usando evento direto)")
		#
		#var mouse_position := get_window().get_mouse_position()
		#var camera := get_window().get_viewport().get_camera_3d()
		#var plane := Plane.PLANE_XZ
		#var origin := camera.project_ray_origin(mouse_position)
		#var normal := camera.project_ray_normal(mouse_position)
		##print(mouse_position)
		#print("Origin: " + str(origin))
		#print("Normal: " + str(normal))
#
		#var final = origin + normal * 1000.0
		#print("Final: " + str(final))
#
		#var intersect : Variant = plane.intersects_ray(
			#camera.project_ray_origin(mouse_position),
			#final
		#)
		## Prints either null or the Vector3 where the raycast intersects the zero-plane:
		#print(intersect)
