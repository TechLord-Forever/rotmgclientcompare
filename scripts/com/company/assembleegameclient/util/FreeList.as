package com.company.assembleegameclient.util {
    import flash.utils.Dictionary;
    
    public class FreeList {
        
        private static var dict_:Dictionary = new Dictionary();
         
        
        public function FreeList() {
            super();
        }
        
        public static function newObject(param1:Class) : Object {
            var _local_2:Vector.<Object> = dict_[param1];
            if(_local_2 == null) {
                _local_2 = new Vector.<Object>();
                dict_[param1] = _local_2;
            } else if(_local_2.length > 0) {
                return _local_2.pop();
            }
            return new param1();
        }
        
        public static function storeObject(param1:*, param2:Object) : void {
            var _local_3:Vector.<Object> = dict_[param1];
            if(_local_3 == null) {
                _local_3 = new Vector.<Object>();
                dict_[param1] = _local_3;
            }
            _local_3.push(param2);
        }
        
        public static function getObject(param1:*) : Object {
            var _local_2:Vector.<Object> = dict_[param1];
            if(_local_2 != null && _local_2.length > 0) {
                return _local_2.pop();
            }
            return null;
        }
        
        public static function dump(param1:*) : void {
            delete dict_[param1];
        }
        
        public static function deleteObject(param1:Object) : void {
            var _local_2:Class = Object(param1).constructor;
            var _local_3:Vector.<Object> = dict_[_local_2];
            if(_local_3 == null) {
                _local_3 = new Vector.<Object>();
                dict_[_local_2] = _local_3;
            }
            _local_3.push(param1);
        }
    }
}
