# 🎯 Raycast Prototype - Godot 4

Um protótipo simples em Godot 4 que demonstra como implementar raycast a partir da câmera baseado na posição do mouse, com spawning de objetos no ponto de colisão.

## 📋 Descrição

Este projeto implementa um sistema básico de raycast 3D que:
- Detecta cliques do mouse
- Projeta um raio da câmera através da posição do cursor
- Detecta colisões com objetos físicos na cena
- Spawna um objeto de debug no ponto exato da colisão

## ✨ Funcionalidades

- **Raycast 3D**: Projeção precisa de raios da câmera baseada na posição 2D do mouse
- **Detecção de Colisão**: Sistema robusto usando `PhysicsRayQueryParameters3D`
- **Visual Debug**: Spawning automático de cubos de debug nos pontos de impacto
- **Console Logging**: Informações detalhadas sobre posição, normal e colisor

## 🎮 Como Usar

1. Execute o projeto no Godot 4
2. Clique com o botão esquerdo do mouse em qualquer objeto da cena
3. Um cubo de debug será criado no ponto exato onde o ray colidiu
4. Verifique o console para informações detalhadas da colisão

## 🔧 Componentes Principais

### Raycast System
- **Origem**: Calculada usando `camera_3d.project_ray_origin(mousepos)`
- **Direção**: Normalizada com `camera_3d.project_ray_normal(mousepos)`
- **Alcance**: Configurável via constante `RAY_LENGTH` (1000 unidades)

### Detecção de Física
- Utiliza `PhysicsRayQueryParameters3D` para queries precisas
- Configurado para detectar apenas corpos físicos (não áreas)
- Retorna informações completas sobre posição, normal e objeto colidido

### Debug Visual
- Spawning automático de objetos `cubo_debug.tscn`
- Posicionamento exato no ponto de colisão
- Console logging com dados estruturados
