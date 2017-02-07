package org.swiftsuspenders.typedescriptions {
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    import org.swiftsuspenders.InjectorError;
    
    public class TypeDescription {
         
        
        public var ctor:ConstructorInjectionPoint;
        
        public var injectionPoints:InjectionPoint;
        
        public var preDestroyMethods:PreDestroyInjectionPoint;
        
        private var _postConstructAdded:Boolean;
        
        public function TypeDescription(param1:Boolean = true) {
            super();
            if(param1) {
                this.ctor = new NoParamsConstructorInjectionPoint();
            }
        }
        
        public function setConstructor(param1:Array, param2:Array = null, param3:uint = 2147483647, param4:Dictionary = null) : TypeDescription {
            this.ctor = new ConstructorInjectionPoint(this.createParameterMappings(param1,param2 || []),param3,param4);
            return this;
        }
        
        public function addFieldInjection(param1:String, param2:Class, param3:String = "", param4:Boolean = false, param5:Dictionary = null) : TypeDescription {
            if(this._postConstructAdded) {
                throw new InjectorError("Can\'t add injection point after post construct method");
            }
            this.addInjectionPoint(new PropertyInjectionPoint(getQualifiedClassName(param2) + "|" + param3,param1,param4,param5));
            return this;
        }
        
        public function addMethodInjection(param1:String, param2:Array, param3:Array = null, param4:uint = 2147483647, param5:Boolean = false, param6:Dictionary = null) : TypeDescription {
            if(this._postConstructAdded) {
                throw new InjectorError("Can\'t add injection point after post construct method");
            }
            this.addInjectionPoint(new MethodInjectionPoint(param1,this.createParameterMappings(param2,param3 || []),Math.min(param4,param2.length),param5,param6));
            return this;
        }
        
        public function addPostConstructMethod(param1:String, param2:Array, param3:Array = null, param4:uint = 2147483647) : TypeDescription {
            this._postConstructAdded = true;
            this.addInjectionPoint(new PostConstructInjectionPoint(param1,this.createParameterMappings(param2,param3 || []),Math.min(param4,param2.length),0));
            return this;
        }
        
        public function addPreDestroyMethod(param1:String, param2:Array, param3:Array = null, param4:uint = 2147483647) : TypeDescription {
            var _local_5:PreDestroyInjectionPoint = new PreDestroyInjectionPoint(param1,this.createParameterMappings(param2,param3 || []),Math.min(param4,param2.length),0);
            if(this.preDestroyMethods) {
                this.preDestroyMethods.last.next = _local_5;
                this.preDestroyMethods.last = _local_5;
            } else {
                this.preDestroyMethods = _local_5;
                this.preDestroyMethods.last = _local_5;
            }
            return this;
        }
        
        public function addInjectionPoint(param1:InjectionPoint) : void {
            if(this.injectionPoints) {
                this.injectionPoints.last.next = param1;
                this.injectionPoints.last = param1;
            } else {
                this.injectionPoints = param1;
                this.injectionPoints.last = param1;
            }
        }
        
        private function createParameterMappings(param1:Array, param2:Array) : Array {
            var _local_3:Array = new Array(param1.length);
            var _local_4:int = _local_3.length;
            while(_local_4--) {
                _local_3[_local_4] = getQualifiedClassName(param1[_local_4]) + "|" + (param2[_local_4] || "");
            }
            return _local_3;
        }
    }
}
