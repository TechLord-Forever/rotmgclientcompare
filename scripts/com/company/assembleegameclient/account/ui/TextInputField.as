package com.company.assembleegameclient.account.ui {
    import com.company.ui.BaseSimpleText;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    
    public class TextInputField extends Sprite {
        
        public static const HEIGHT:int = 88;
         
        
        public var nameText_:TextFieldDisplayConcrete;
        
        public var inputText_:BaseSimpleText;
        
        public var errorText_:TextFieldDisplayConcrete;
        
        public function TextInputField(param1:String, param2:Boolean) {
            super();
            this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(11776947);
            this.nameText_.setBold(true);
            this.nameText_.setStringBuilder(new LineBuilder().setParams(param1));
            this.nameText_.filters = [new DropShadowFilter(0,0,0)];
            addChild(this.nameText_);
            this.inputText_ = new BaseSimpleText(20,11776947,true,238,30);
            this.inputText_.y = 30;
            this.inputText_.x = 6;
            this.inputText_.border = false;
            this.inputText_.displayAsPassword = param2;
            this.inputText_.updateMetrics();
            addChild(this.inputText_);
            graphics.lineStyle(2,4539717,1,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
            graphics.beginFill(3355443,1);
            graphics.drawRect(0,this.inputText_.y,238,30);
            graphics.endFill();
            graphics.lineStyle();
            this.inputText_.addEventListener(Event.CHANGE,this.onInputChange);
            this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
            this.errorText_.y = this.inputText_.y + 32;
            this.errorText_.filters = [new DropShadowFilter(0,0,0)];
            addChild(this.errorText_);
        }
        
        public function text() : String {
            return this.inputText_.text;
        }
        
        public function clearText() : void {
            this.inputText_.text = "";
        }
        
        public function setError(param1:String, param2:Object = null) : void {
            this.errorText_.setStringBuilder(new LineBuilder().setParams(param1,param2));
        }
        
        public function clearError() : void {
            this.errorText_.setStringBuilder(new StaticStringBuilder(""));
        }
        
        public function onInputChange(param1:Event) : void {
            this.errorText_.setStringBuilder(new StaticStringBuilder(""));
        }
    }
}
