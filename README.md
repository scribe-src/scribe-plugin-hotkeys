scribe-plugin-hotkeys
==
Implements a HotKey handler plugin for the [Scribe.io](https://scribe.io) framework.

#### Example Usage:

    var hotKey = Scribe.Plugin.HotKey.register(
      'meta-shift-x',
      function() {

      }
    );

    hotKey.unregister();

#### Documentation

Documentation is generated with `codo` and is available [here](http://blah.com).

#### Build

To build for a specific `$PLATFORM`:

    $ make $PLATFORM

The following values are supported for `$PLATFORM`:

 - osx

#### Tests

Tests are written with [objc-unit](https://github.com/scribe-src/objc-unit). To run tests:

    $ make test

#### License

[BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause)

#### Copyright

    2014 Scribe.io
