package kabam.rotmg.arena.component {
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.StaticTextDisplay;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    
    public class BattleSummaryText extends Sprite {
         
        
        private var titleText:StaticTextDisplay;
        
        private var waveText:StaticTextDisplay;
        
        private var timeText:StaticTextDisplay;
        
        public function BattleSummaryText(param1:String, param2:int, param3:int) {
            this.titleText = this.makeTitleText();
            this.waveText = this.makeSubtitleText();
            this.timeText = this.makeSubtitleText();
            super();
            this.titleText.setStringBuilder(new LineBuilder().setParams(param1));
            this.waveText.setStringBuilder(new LineBuilder().setParams(TextKey.BATTLE_SUMMARY_WAVENUMBER,{"waveNumber":param2 - 1}));
            this.timeText.setStringBuilder(new StaticStringBuilder(this.createTimerString(param3)));
            this.align();
        }
        
        private function align() : void {
            this.titleText.x = width / 2 - this.titleText.width / 2;
            this.waveText.y = this.titleText.height + 10;
            this.waveText.x = width / 2 - this.waveText.width / 2;
            this.timeText.y = this.waveText.y + this.waveText.height + 5;
            this.timeText.x = width / 2 - this.timeText.width / 2;
        }
        
        private function createTimerString(param1:int) : String {
            var _local_2:int = param1 / 60;
            var _local_3:int = param1 % 60;
            var _local_4:String = _local_2 < 10?"0":"";
            _local_4 = _local_4 + (_local_2 + ":");
            _local_4 = _local_4 + (_local_3 < 10?"0":"");
            _local_4 = _local_4 + _local_3;
            return _local_4;
        }
        
        private function makeTitleText() : StaticTextDisplay {
            var _local_1:StaticTextDisplay = null;
            _local_1 = new StaticTextDisplay();
            _local_1.setSize(16).setBold(true).setColor(16777215);
            _local_1.filters = [new DropShadowFilter(0,0,0,1,8,8)];
            addChild(_local_1);
            return _local_1;
        }
        
        private function makeSubtitleText() : StaticTextDisplay {
            var _local_1:StaticTextDisplay = new StaticTextDisplay();
            _local_1.setSize(14).setBold(true).setColor(11776947);
            _local_1.filters = [new DropShadowFilter(0,0,0,1,8,8)];
            addChild(_local_1);
            return _local_1;
        }
    }
}
