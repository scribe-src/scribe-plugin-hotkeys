(function(){

  var plugin = Scribe.Plugin.load('HotKeys');

  Scribe.Plugin.HotKeys = {

    register: function(key, callback) {

      var unregistered = false;

      plugin.call({
        name: 'registerHotKey',
        key: key,
        onMessage: function(message) {
          if (message.name == 'success') {
            instance.failed = false;
            instance.success = true;
          } else if (message.name == 'fail') {
            instance.failed = true;
            instance.success = false;
          } else if (message.name == 'callback') {
            callback.call(instance, message);
          }
        }
      });

      return instance;
    },

    unregister: function(key) {
      return plugin.call({
        name: 'hotKeysUnregister',
        key: key
      });
    }

  };

})();
