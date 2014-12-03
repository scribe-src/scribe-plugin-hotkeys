#import "HotKeys.h"

static NSMutableArray* handlers = nil;

extern int jsStart __asm("section$start$__DATA$__js");

OSStatus HotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
  NSLog(@"Hot Key Handler Called!");
  return noErr;
}

void RegisterHotKey(NSDictionary *options, ScribeEngine *caller) {
  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  EventHotKeyRef gMyHotKeyRef;
  EventHotKeyID gMyHotKeyID;
  EventTypeSpec eventType;
  eventType.eventClass = kEventClassKeyboard;
  eventType.eventKind = kEventHotKeyPressed;

  InstallApplicationEventHandler(&HotKeyHandler, 1, &eventType, NULL, NULL);

  gMyHotKeyID.id = 1;

  RegisterEventHotKey( //cmd-opt-w
    13, cmdKey+optionKey, gMyHotKeyID,
    GetApplicationEventTarget(), 0, &gMyHotKeyRef
  );

  [pool drain];
}

void UnregisterHotKey(NSDictionary *options, ScribeEngine *caller) {
  // UnregisterEventHotKey(ref);
}


// This function (if defined) will be called as soon as the HotKeys plugin is loaded.
// It allows us to run the javascript that is packed into the .dylib by the linker.
void ScribePluginOnLoad(NSDictionary *options, ScribeEngine *caller) {
  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  if (!handlers) {
    handlers = [NSMutableArray new];
  }
  NSString *js = [NSString stringWithCString: (char*)&jsStart encoding: NSUTF8StringEncoding];
  [caller.jsc evalJSString: js];

  RegisterHotKey(@{}, caller);

  [pool drain];
}
