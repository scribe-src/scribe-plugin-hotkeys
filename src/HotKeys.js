(function(){

  var nativeObject = Scribe.Plugin.load('HotKeys');

  Scribe.Plugin.HotKeys = {

    register: function(key, callback) {

      var instance = {
        unregister: this.unregister.bind(this, key)
      };

      nativeObject.call('RegisterHotKey', {
        key: key,
        done: function(response) {
          callback.call(instance, response);
        }
      });

      return instance;
    },

    unregister: function(key) {
      return nativeObject.call('UnregisterHotKey', { key: key });
    }

  };

})();
