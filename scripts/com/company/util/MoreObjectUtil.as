package com.company.util {
    public class MoreObjectUtil {
         
        
        public function MoreObjectUtil() {
            super();
        }
        
        public static function addToObject(param1:Object, param2:Object) : void {
            var _local_3:* = null;
            for(_local_3 in param2) {
                param1[_local_3] = param2[_local_3];
            }
        }
    }
}
