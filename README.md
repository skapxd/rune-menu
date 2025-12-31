# Rune Menu Lab 🧪

## 🎯 Objetivo
Laboratorio de experimentación para el sistema de menús del juego.
**Inspiración:** *Lost Magic* (Nintendo DS).
**Restricción Principal:** 🚫 No hay artista. Todo el arte visual (UI, fondos, efectos) debe ser generado por código (Godot StyleBoxes, Shaders, Draw calls, Partículas).

## 🎨 Estilo Visual: "Magia Procedural"
El objetivo es evocar un grimorio mágico o una interfaz de control de runas usando geometría pura.

*   **Paleta de Colores:**
	*   Fondo: Tonos oscuros/profundos (Azul noche, Violeta oscuro) para resaltar los efectos brillantes.
	*   Acentos: Colores elementales vivos (Fuego, Agua, Viento, Tierra, Luz, Oscuridad).
	*   UI: Bordes dorados/plateados (generados con bordes de StyleBox) y fondos translúcidos.
*   **Elementos Gráficos:**
	*   **Botones:** No serán imágenes. Serán `PanelContainer` con `StyleBoxFlat`. Bordes redondeados, brillos al hacer hover (Tweening de propiedades).
	*   **Fondo:** Shader procedural (niebla mágica o retícula de runas).
	*   **Iconos:** Dibujados vectorialmente usando `Line2D` o `Polygon2D`.

## 🛠 Estructura Funcional

### Navegación Principal
*   [ ] **Pantalla de Título:** Nombre del juego + "Presiona cualquier tecla" (o dibuja una runa para entrar).
*   [ ] **Menú Principal:**
	*   Botón 1: **Jugar** (Lleva al selector de partidas)
	*   Botón 2: **Grimorio** (Colección/Configuración)
	*   Botón 3: **Salir**
*   [ ] **Selector de Partidas (Save/Load):**
	*   Visualización: 3 "Tablillas" o "Losas" mágicas en pantalla.
	*   **Nueva Partida:** Una losa vacía/brillante. Al seleccionar, permite ingresar nombre.
	*   **Cargar Partida:** Muestra info resumen (Nivel, Tiempo de juego, Fecha).

### Feedback de Usuario (Juice)
*   Al pasar el mouse sobre un botón:
	*   El borde brilla.
	*   Partículas simples emanan del botón.
	*   Sonido de "piedra mágica" o "cristal".

## 📝 TODO List
- [ ] Crear escena base con fondo procedural (Shader).
- [ ] Crear componente `RuneButton` (Botón custom con estilos por código).
- [ ] Implementar contenedor de menú centrado.