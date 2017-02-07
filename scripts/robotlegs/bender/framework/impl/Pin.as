package robotlegs.bender.framework.impl {
    import flash.utils.Dictionary;
    
    public class Pin {
         
        
        private const _instances:Dictionary = new Dictionary(false);
        
        public function Pin() {
            super();
        }
        
        public function detain(param1:Object) : void {
            this._instances[param1] = true;
        }
        
        public function release(param1:Object) : void {
            delete this._instances[param1];
        }
        
        public function flush() : void {
            var _local_1:* = null;
            for(_local_1 in this._instances) {
                delete this._instances[_local_1];
            }
        }
    }
}
