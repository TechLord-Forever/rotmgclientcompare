package com.company.assembleegameclient.util {
    import flash.display.DisplayObject;
    
    public class DisplayHierarchy {
         
        
        public function DisplayHierarchy() {
            super();
        }
        
        public static function getParentWithType(param1:DisplayObject, param2:Class) : DisplayObject {
            while(param1 && !(param1 is param2)) {
                param1 = param1.parent;
            }
            return param1;
        }
        
        public static function getParentWithTypeArray(param1:DisplayObject, ... rest) : DisplayObject {
            var _local_3:Class = null;
            while(param1) {
                for each(_local_3 in rest) {
                    if(param1 is _local_3) {
                        return param1;
                    }
                }
                param1 = param1.parent;
            }
            return param1;
        }
    }
}
