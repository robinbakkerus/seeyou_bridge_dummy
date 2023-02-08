import 'package:event_bus/event_bus.dart';

enum ShowPage { play, select, settings, help }

/*
 * All Events are maintainded here.
 */
class ShowPageEvent {
  ShowPage page;
  ShowPageEvent(this.page);
}

class UndoEvent {}

class CardEvent {}

class ResetEvent {}

/*
	Static class that contains all onXxx and fireXxx methods.
*/
class AppEvents {
  static final EventBus _sEventBus = EventBus();

  // Only needed if clients want all EventBus functionality.
  static EventBus ebus() => _sEventBus;

  /*
  * The methods below are just convenience shortcuts to make it easier for the client to use.
  */
  static void fireShowPage(ShowPage page) =>
      _sEventBus.fire(ShowPageEvent(page));
  static void fireReset() => _sEventBus.fire(ResetEvent());
  static void fireUndo() => _sEventBus.fire(UndoEvent());
  static void fireCardEvent() => _sEventBus.fire(CardEvent());

  ///----- static onXxx methods --------
  static void onShowPage(OnShowPageFunc func) =>
      _sEventBus.on<ShowPageEvent>().listen((event) => func(event));

  static void onCardEvent(OnCardEventFunc func) =>
      _sEventBus.on<CardEvent>().listen((event) => func(event));

  static void onReset(OnResetFunc func) =>
      _sEventBus.on<ResetEvent>().listen((event) => func(event));

  static void onUndo(OnUndoFunc func) =>
      _sEventBus.on<UndoEvent>().listen((event) => func(event));
}

/// ----- typedef's -----------
typedef OnShowPageFunc = void Function(ShowPageEvent event);
typedef OnCardEventFunc = void Function(CardEvent event);
typedef OnResetFunc = void Function(ResetEvent event);
typedef OnUndoFunc = void Function(UndoEvent event);
