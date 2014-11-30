#import "HotKeys.h"

void registerHotKey(NSDictionary *options, ScribeEngine *caller) {
  [caller eval: @"joe.js"];
}

void unregisterHotKey(NSDictionary *options, ScribeEngine *caller) {
  
}
