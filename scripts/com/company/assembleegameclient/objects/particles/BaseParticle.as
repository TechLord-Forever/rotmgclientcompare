package com.company.assembleegameclient.objects.particles {
    import com.company.assembleegameclient.map.Camera;
    import com.company.assembleegameclient.objects.BasicObject;
    import com.company.util.GraphicsUtil;
    import flash.display.BitmapData;
    import flash.display.GraphicsBitmapFill;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;
    import flash.geom.Matrix;
    
    public class BaseParticle extends BasicObject {
         
        
        public var timeLeft:Number = 0;
        
        public var spdX:Number;
        
        public var spdY:Number;
        
        public var spdZ:Number;
        
        protected var vS_:Vector.<Number>;
        
        protected var fillMatrix_:Matrix;
        
        protected var path_:GraphicsPath;
        
        protected var bitmapFill_:GraphicsBitmapFill;
        
        public function BaseParticle(param1:BitmapData) {
            this.vS_ = new Vector.<Number>(8);
            this.fillMatrix_ = new Matrix();
            this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,null);
            this.bitmapFill_ = new GraphicsBitmapFill(null,null,false,false);
            super();
            this.bitmapFill_.bitmapData = param1;
            objectId_ = getNextFakeObjectId();
        }
        
        public function initialize(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : void {
            this.timeLeft = param1;
            this.spdX = param2;
            this.spdY = param3;
            this.spdZ = param4;
            z_ = param5;
        }
        
        override public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
            var _local_4:Number = this.bitmapFill_.bitmapData.width / 2;
            var _local_5:Number = this.bitmapFill_.bitmapData.height / 2;
            this.vS_[6] = this.vS_[0] = posS_[3] - _local_4;
            this.vS_[3] = this.vS_[1] = posS_[4] - _local_5;
            this.vS_[4] = this.vS_[2] = posS_[3] + _local_4;
            this.vS_[7] = this.vS_[5] = posS_[4] + _local_5;
            this.path_.data = this.vS_;
            this.fillMatrix_.identity();
            this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
            this.bitmapFill_.matrix = this.fillMatrix_;
            param1.push(this.bitmapFill_);
            param1.push(this.path_);
            param1.push(GraphicsUtil.END_FILL);
        }
        
        override public function removeFromMap() : void {
            map_ = null;
            square_ = null;
        }
    }
}
