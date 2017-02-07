package com.company.assembleegameclient.tutorial {
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.util.PointUtil;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.BlurFilter;
    import flash.utils.getTimer;
    import kabam.rotmg.assets.EmbeddedData;
    
    public class Tutorial extends Sprite {
        
        public static const NEXT_ACTION:String = "Next";
        
        public static const MOVE_FORWARD_ACTION:String = "MoveForward";
        
        public static const MOVE_BACKWARD_ACTION:String = "MoveBackward";
        
        public static const ROTATE_LEFT_ACTION:String = "RotateLeft";
        
        public static const ROTATE_RIGHT_ACTION:String = "RotateRight";
        
        public static const MOVE_LEFT_ACTION:String = "MoveLeft";
        
        public static const MOVE_RIGHT_ACTION:String = "MoveRight";
        
        public static const UPDATE_ACTION:String = "Update";
        
        public static const ATTACK_ACTION:String = "Attack";
        
        public static const DAMAGE_ACTION:String = "Damage";
        
        public static const KILL_ACTION:String = "Kill";
        
        public static const SHOW_LOOT_ACTION:String = "ShowLoot";
        
        public static const TEXT_ACTION:String = "Text";
        
        public static const SHOW_PORTAL_ACTION:String = "ShowPortal";
        
        public static const ENTER_PORTAL_ACTION:String = "EnterPortal";
        
        public static const NEAR_REQUIREMENT:String = "Near";
        
        public static const EQUIP_REQUIREMENT:String = "Equip";
         
        
        public var gs_:GameSprite;
        
        public var steps_:Vector.<Step>;
        
        public var currStepId_:int = 0;
        
        private var darkBox_:Sprite;
        
        private var boxesBack_:Shape;
        
        private var boxes_:Shape;
        
        private var tutorialMessage_:TutorialMessage = null;
        
        public function Tutorial(param1:GameSprite) {
            var _local_2:XML = null;
            var _local_3:Graphics = null;
            this.steps_ = new Vector.<Step>();
            this.darkBox_ = new Sprite();
            this.boxesBack_ = new Shape();
            this.boxes_ = new Shape();
            super();
            this.gs_ = param1;
            for each(_local_2 in EmbeddedData.tutorialXML.Step) {
                this.steps_.push(new Step(_local_2));
            }
            addChild(this.boxesBack_);
            addChild(this.boxes_);
            _local_3 = this.darkBox_.graphics;
            _local_3.clear();
            _local_3.beginFill(0,0.1);
            _local_3.drawRect(0,0,800,600);
            _local_3.endFill();
            Parameters.data_.needsTutorial = false;
            Parameters.save();
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
        }
        
        private function onAddedToStage(param1:Event) : void {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.draw();
        }
        
        private function onRemovedFromStage(param1:Event) : void {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
        }
        
        private function onEnterFrame(param1:Event) : void {
            var _local_4:Step = null;
            var _local_5:Boolean = false;
            var _local_6:Requirement = null;
            var _local_7:int = 0;
            var _local_8:UIDrawBox = null;
            var _local_9:UIDrawArrow = null;
            var _local_10:Player = null;
            var _local_11:Boolean = false;
            var _local_12:GameObject = null;
            var _local_13:Number = NaN;
            var _local_2:Number = Math.abs(Math.sin(getTimer() / 300));
            this.boxesBack_.filters = [new BlurFilter(5 + _local_2 * 5,5 + _local_2 * 5)];
            this.boxes_.graphics.clear();
            this.boxesBack_.graphics.clear();
            var _local_3:int = 0;
            while(_local_3 < this.steps_.length) {
                _local_4 = this.steps_[_local_3];
                _local_5 = true;
                for each(_local_6 in _local_4.reqs_) {
                    _local_10 = this.gs_.map.player_;
                    switch(_local_6.type_) {
                        case NEAR_REQUIREMENT:
                            _local_11 = false;
                            for each(_local_12 in this.gs_.map.goDict_) {
                                if(!(_local_12.objectType_ != _local_6.objectType_ || _local_6.objectName_ != "" && _local_12.name_ != _local_6.objectName_)) {
                                    _local_13 = PointUtil.distanceXY(_local_12.x_,_local_12.y_,_local_10.x_,_local_10.y_);
                                    if(_local_13 <= _local_6.radius_) {
                                        _local_11 = true;
                                        break;
                                    }
                                }
                            }
                            if(!_local_11) {
                                _local_5 = false;
                            }
                            continue;
                        default:
                            continue;
                    }
                }
                if(!_local_5) {
                    _local_4.satisfiedSince_ = 0;
                } else {
                    if(_local_4.satisfiedSince_ == 0) {
                        _local_4.satisfiedSince_ = getTimer();
                    }
                    _local_7 = getTimer() - _local_4.satisfiedSince_;
                    for each(_local_8 in _local_4.uiDrawBoxes_) {
                        _local_8.draw(5 * _local_2,this.boxes_.graphics,_local_7);
                        _local_8.draw(6 * _local_2,this.boxesBack_.graphics,_local_7);
                    }
                    for each(_local_9 in _local_4.uiDrawArrows_) {
                        _local_9.draw(5 * _local_2,this.boxes_.graphics,_local_7);
                        _local_9.draw(6 * _local_2,this.boxesBack_.graphics,_local_7);
                    }
                }
                _local_3++;
            }
        }
        
        function doneAction(param1:String) : void {
            var _local_3:Requirement = null;
            var _local_4:Player = null;
            var _local_5:Boolean = false;
            var _local_6:GameObject = null;
            var _local_7:Number = NaN;
            if(this.currStepId_ >= this.steps_.length) {
                return;
            }
            var _local_2:Step = this.steps_[this.currStepId_];
            if(param1 != _local_2.action_) {
                return;
            }
            while(true) {
                loop0:
                for each(_local_3 in _local_2.reqs_) {
                    _local_4 = this.gs_.map.player_;
                    switch(_local_3.type_) {
                        case NEAR_REQUIREMENT:
                            _local_5 = false;
                            for each(_local_6 in this.gs_.map.goDict_) {
                                if(_local_6.objectType_ == _local_3.objectType_) {
                                    _local_7 = PointUtil.distanceXY(_local_6.x_,_local_6.y_,_local_4.x_,_local_4.y_);
                                    if(_local_7 <= _local_3.radius_) {
                                        _local_5 = true;
                                        break;
                                    }
                                }
                            }
                            if(!_local_5) {
                                break loop0;
                            }
                            continue;
                        case EQUIP_REQUIREMENT:
                            if(_local_4.equipment_[_local_3.slot_] != _local_3.objectType_) {
                                return;
                            }
                            continue;
                        default:
                            continue;
                    }
                }
                var _local_8:* = this;
                this.currStepId_++;
                this.draw();
                return;
            }
        }
        
        private function draw() : void {
            var _local_3:UIDrawBox = null;
        }
    }
}
