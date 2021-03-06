package kabam.rotmg.dailyLogin.view {
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.AssetLibrary;
    import com.company.util.GraphicsUtil;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.CapsStyle;
    import flash.display.GraphicsPath;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.IGraphicsData;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.text.TextFieldAutoSize;
    import kabam.rotmg.assets.services.IconFactory;
    import kabam.rotmg.dailyLogin.config.CalendarSettings;
    import kabam.rotmg.dailyLogin.model.CalendarDayModel;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    
    public class CalendarDayBox extends Sprite {
         
        
        private var fill_:GraphicsSolidFill;
        
        private var fillCurrent_:GraphicsSolidFill;
        
        private var fillBlack_:GraphicsSolidFill;
        
        private var lineStyle_:GraphicsStroke;
        
        private var path_:GraphicsPath;
        
        private var graphicsDataBackground:Vector.<IGraphicsData>;
        
        private var graphicsDataBackgroundCurrent:Vector.<IGraphicsData>;
        
        private var graphicsDataClaimedOverlay:Vector.<IGraphicsData>;
        
        public var day:CalendarDayModel;
        
        private var redDot:Bitmap;
        
        private var boxCuts:Array;
        
        public function CalendarDayBox(param1:CalendarDayModel, param2:int, param3:Boolean) {
            var _local_6:ItemTileRenderer = null;
            var _local_7:Bitmap = null;
            var _local_8:BitmapData = null;
            var _local_9:TextFieldDisplayConcrete = null;
            this.fill_ = new GraphicsSolidFill(3552822,1);
            this.fillCurrent_ = new GraphicsSolidFill(4889165,1);
            this.fillBlack_ = new GraphicsSolidFill(0,0.7);
            this.lineStyle_ = new GraphicsStroke(CalendarSettings.BOX_BORDER,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,new GraphicsSolidFill(16777215));
            this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
            this.graphicsDataBackground = new <IGraphicsData>[this.lineStyle_,this.fill_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
            this.graphicsDataBackgroundCurrent = new <IGraphicsData>[this.lineStyle_,this.fillCurrent_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
            this.graphicsDataClaimedOverlay = new <IGraphicsData>[this.lineStyle_,this.fillBlack_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
            super();
            this.day = param1;
            var _local_4:int = Math.ceil(param1.dayNumber / CalendarSettings.NUMBER_OF_COLUMNS);
            var _local_5:int = Math.ceil(param2 / CalendarSettings.NUMBER_OF_COLUMNS);
            if(param1.dayNumber == 1) {
                if(_local_5 == 1) {
                    this.boxCuts = [1,0,0,1];
                } else {
                    this.boxCuts = [1,0,0,0];
                }
            } else if(param1.dayNumber == param2) {
                if(_local_5 == 1) {
                    this.boxCuts = [0,1,1,0];
                } else {
                    this.boxCuts = [0,0,1,0];
                }
            } else if(_local_4 == 1 && param1.dayNumber % CalendarSettings.NUMBER_OF_COLUMNS == 0) {
                this.boxCuts = [0,1,0,0];
            } else if(_local_4 == _local_5 && (param1.dayNumber - 1) % CalendarSettings.NUMBER_OF_COLUMNS == 0) {
                this.boxCuts = [0,0,0,1];
            } else {
                this.boxCuts = [0,0,0,0];
            }
            this.drawBackground(this.boxCuts,param3);
            if(param1.gold == 0 && param1.itemID > 0) {
                _local_6 = new ItemTileRenderer(param1.itemID);
                addChild(_local_6);
                _local_6.x = Math.round(CalendarSettings.BOX_WIDTH / 2);
                _local_6.y = Math.round(CalendarSettings.BOX_HEIGHT / 2);
            }
            if(param1.gold > 0) {
                _local_7 = new Bitmap();
                _local_7.bitmapData = IconFactory.makeCoin(80);
                addChild(_local_7);
                _local_7.x = Math.round(CalendarSettings.BOX_WIDTH / 2 - _local_7.width / 2);
                _local_7.y = Math.round(CalendarSettings.BOX_HEIGHT / 2 - _local_7.height / 2);
            }
            this.displayDayNumber(param1.dayNumber);
            if(param1.claimKey != "") {
                _local_8 = AssetLibrary.getImageFromSet("lofiInterface",52);
                _local_8.colorTransform(new Rectangle(0,0,_local_8.width,_local_8.height),CalendarSettings.GREEN_COLOR_TRANSFORM);
                _local_8 = TextureRedrawer.redraw(_local_8,40,true,0);
                this.redDot = new Bitmap(_local_8);
                this.redDot.x = CalendarSettings.BOX_WIDTH - Math.round(this.redDot.width / 2) - 10;
                this.redDot.y = -Math.round(this.redDot.width / 2) + 10;
                addChild(this.redDot);
            }
            if(param1.quantity > 1 || param1.gold > 0) {
                _local_9 = new TextFieldDisplayConcrete().setSize(14).setColor(16777215).setTextWidth(CalendarSettings.BOX_WIDTH).setAutoSize(TextFieldAutoSize.RIGHT);
                _local_9.setStringBuilder(new StaticStringBuilder("x" + (param1.gold > 0?param1.gold.toString():param1.quantity.toString())));
                _local_9.y = CalendarSettings.BOX_HEIGHT - 18;
                _local_9.x = -2;
                addChild(_local_9);
            }
            if(param1.isClaimed) {
                this.markAsClaimed();
            }
        }
        
        public static function drawRectangleWithCuts(param1:Array, param2:int, param3:int, param4:uint, param5:Number, param6:Vector.<IGraphicsData>, param7:GraphicsPath) : Sprite {
            var _local_8:Shape = new Shape();
            var _local_9:Shape = new Shape();
            var _local_10:Sprite = new Sprite();
            _local_10.addChild(_local_8);
            _local_10.addChild(_local_9);
            GraphicsUtil.clearPath(param7);
            GraphicsUtil.drawCutEdgeRect(0,0,param2,param3,4,param1,param7);
            _local_8.graphics.clear();
            _local_8.graphics.drawGraphicsData(param6);
            var _local_11:GraphicsSolidFill = new GraphicsSolidFill(param4,param5);
            GraphicsUtil.clearPath(param7);
            var _local_12:Vector.<IGraphicsData> = new <IGraphicsData>[_local_11,param7,GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0,0,param2,param3,4,param1,param7);
            _local_9.graphics.drawGraphicsData(_local_12);
            _local_9.cacheAsBitmap = true;
            _local_9.visible = false;
            return _local_10;
        }
        
        public function getDay() : CalendarDayModel {
            return this.day;
        }
        
        public function markAsClaimed() : void {
            if(this.redDot && this.redDot.parent) {
                removeChild(this.redDot);
            }
            var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig",11);
            _local_1 = TextureRedrawer.redraw(_local_1,60,true,2997032);
            var _local_2:Bitmap = new Bitmap(_local_1);
            _local_2.x = Math.round((CalendarSettings.BOX_WIDTH - _local_2.width) / 2);
            _local_2.y = Math.round((CalendarSettings.BOX_HEIGHT - _local_2.height) / 2);
            var _local_3:Sprite = drawRectangleWithCuts(this.boxCuts,CalendarSettings.BOX_WIDTH,CalendarSettings.BOX_HEIGHT,0,1,this.graphicsDataClaimedOverlay,this.path_);
            addChild(_local_3);
            addChild(_local_2);
        }
        
        private function displayDayNumber(param1:int) : void {
            var _local_2:TextFieldDisplayConcrete = null;
            _local_2 = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(CalendarSettings.BOX_WIDTH);
            _local_2.setBold(true);
            _local_2.setStringBuilder(new StaticStringBuilder(param1.toString()));
            _local_2.x = 4;
            _local_2.y = 4;
            addChild(_local_2);
        }
        
        public function drawBackground(param1:Array, param2:Boolean) : void {
            addChild(drawRectangleWithCuts(param1,CalendarSettings.BOX_WIDTH,CalendarSettings.BOX_HEIGHT,3552822,1,!!param2?this.graphicsDataBackgroundCurrent:this.graphicsDataBackground,this.path_));
        }
    }
}
