import 'dart:async';

class Bloc<T> {
  final Map<String, StreamController<dynamic>> _controllers = Map();
  String defaultStream = "default";

  Bloc(){ addStream<T>(defaultStream); }

  Stream<T>? get stream => _controllers[defaultStream]?.stream as Stream<T>?;
  StreamSink<T>? get sink => _controllers[defaultStream]?.sink as StreamSink<T>?;
  Stream<T>? getStream<T>({String? name}){ return _controllers[name ?? defaultStream]?.stream as Stream<T>?; }
  StreamSink<T>? getSink<T>({String? name}){ return _controllers[name ?? defaultStream]?.sink as StreamSink<T>?; }
  bool isClosed({String? name}){ return _controllers[name ?? defaultStream]?.isClosed ?? true; }

  void dispose() {
    _controllers.keys.forEach((name) {
      _controllers[name]?.close();
    });
  }

  void addStream<T>(String name) {
    _controllers[name] = StreamController<T>.broadcast();
  }
}

