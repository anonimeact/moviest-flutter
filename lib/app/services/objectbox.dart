
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  
  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    Store store = await openStore(directory: p.join(docsDir.path, "favorites"));
    return ObjectBox._create(store);
  }
}