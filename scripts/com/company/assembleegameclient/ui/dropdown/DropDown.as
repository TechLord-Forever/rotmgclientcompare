package com.company.assembleegameclient.ui.dropdown {
    import com.company.ui.BaseSimpleText;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    public class DropDown extends Sprite {
         
        
        protected var strings_:Vector.<String>;
        
        protected var w_:int;
        
        protected var h_:int;
        
        protected var maxItems_:int;
        
        protected var labelText_:BaseSimpleText;
        
        protected var xOffset_:int = 0;
        
        protected var selected_:DropDownItem;
        
        protected var all_:Sprite;
        
        public function DropDown(param1:Vector.<String>, param2:int, param3:int, param4:String = null, param5:Number = 0, param6:int = 17) {
            this.all_ = new Sprite();
            super();
            this.strings_ = param1;
            this.w_ = param2;
            this.h_ = param3;
            this.maxItems_ = param6;
            if(param4 != null) {
                this.labelText_ = new BaseSimpleText(14,16777215,false,0,0);
                this.labelText_.setBold(true);
                this.labelText_.text = param4 + ":";
                this.labelText_.updateMetrics();
                addChild(this.labelText_);
                this.xOffset_ = this.labelText_.width + 5;
            }
            this.setIndex(param5);
        }
        
        public function getValue() : String {
            return this.selected_.getValue();
        }
        
        public function setListItems(param1:Vector.<String>) : void {
            this.strings_ = param1;
        }
        
        public function setValue(param1:String) : Boolean {
            var _local_2:int = 0;
            while(_local_2 < this.strings_.length) {
                if(param1 == this.strings_[_local_2]) {
                    this.setIndex(_local_2);
                    return true;
                }
                _local_2++;
            }
            return false;
        }
        
        public function setIndex(param1:int) : void {
            if(param1 >= this.strings_.length) {
                param1 = 0;
            }
            this.setSelected(this.strings_[param1]);
        }
        
        public function getIndex() : int {
            var _local_1:int = 0;
            while(_local_1 < this.strings_.length) {
                if(this.selected_.getValue() == this.strings_[_local_1]) {
                    return _local_1;
                }
                _local_1++;
            }
            return -1;
        }
        
        private function setSelected(param1:String) : void {
            var _local_2:String = this.selected_ != null?this.selected_.getValue():null;
            this.selected_ = new DropDownItem(param1,this.w_,this.h_);
            this.selected_.x = this.xOffset_;
            this.selected_.y = 0;
            addChild(this.selected_);
            this.selected_.addEventListener(MouseEvent.CLICK,this.onClick);
            if(param1 != _local_2) {
                dispatchEvent(new Event(Event.CHANGE));
            }
        }
        
        private function onClick(param1:MouseEvent) : void {
            param1.stopImmediatePropagation();
            this.selected_.removeEventListener(MouseEvent.CLICK,this.onClick);
            if(contains(this.selected_)) {
                removeChild(this.selected_);
            }
            this.showAll();
        }
        
        private function showAll() : void {
            var _local_3:int = 0;
            var _local_4:int = 0;
            var _local_5:int = 0;
            var _local_1:Point = parent.localToGlobal(new Point(x,y));
            this.all_.x = _local_1.x;
            this.all_.y = _local_1.y;
            var _local_2:int = Math.ceil(this.strings_.length / this.maxItems_);
            var _local_6:int = 0;
            while(_local_6 < _local_2) {
                _local_3 = _local_6 * this.maxItems_;
                _local_4 = Math.min(_local_3 + this.maxItems_,this.strings_.length);
                _local_5 = this.xOffset_ - this.w_ * _local_6;
                this.listItems(_local_3,_local_4,_local_5);
                _local_6++;
            }
            this.all_.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
            stage.addChild(this.all_);
        }
        
        private function listItems(param1:int, param2:int, param3:int) : void {
            var _local_4:int = 0;
            var _local_5:DropDownItem = null;
            _local_4 = 0;
            var _local_6:int = param1;
            while(_local_6 < param2) {
                _local_5 = new DropDownItem(this.strings_[_local_6],this.w_,this.h_);
                _local_5.addEventListener(MouseEvent.CLICK,this.onSelect);
                _local_5.x = param3;
                _local_5.y = _local_4;
                this.all_.addChild(_local_5);
                _local_4 = _local_4 + _local_5.h_;
                _local_6++;
            }
        }
        
        private function hideAll() : void {
            this.all_.removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
            stage.removeChild(this.all_);
        }
        
        private function onSelect(param1:MouseEvent) : void {
            param1.stopImmediatePropagation();
            this.hideAll();
            var _local_2:DropDownItem = param1.target as DropDownItem;
            this.setSelected(_local_2.getValue());
        }
        
        private function onOut(param1:MouseEvent) : void {
            this.hideAll();
            this.setSelected(this.selected_.getValue());
        }
    }
}
