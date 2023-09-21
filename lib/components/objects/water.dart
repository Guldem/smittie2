import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'collision_poly_object.dart';

class Waters extends CollisionPolygonObject {
  Waters({required super.vertices, super.position, super.size});

  static List<Waters> fromObjectLayer(List<TiledObject> objects) {
    return objects
        .map((e) => Waters(
            position: Vector2(e.x, e.y),
            size: Vector2(e.width, e.height),
            vertices: e.polygon.map((p) => Vector2(p.x, p.y)).toList()))
        .toList();
  }
}
