package kabam.rotmg.util.components {
    import com.company.rotmg.graphics.StarGraphic;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    
    public class StarsView extends Sprite {
        
        private static const TOTAL:int = 5;
        
        private static const MARGIN:int = 4;
        
        private static const CORNER:int = 15;
        
        private static const BACKGROUND_COLOR:uint = 2434341;
        
        private static const EMPTY_STAR_COLOR:uint = 8618883;
        
        private static const FILLED_STAR_COLOR:uint = 16777215;
         
        
        private const stars:Vector.<StarGraphic> = this.makeStars();
        
        private const background:Sprite = this.makeBackground();
        
        public function StarsView() {
            super();
        }
        
        private function makeStars() : Vector.<StarGraphic> {
            var _local_1:Vector.<StarGraphic> = this.makeStarList();
            this.layoutStars(_local_1);
            return _local_1;
        }
        
        private function makeStarList() : Vector.<StarGraphic> {
            var _local_1:Vector.<StarGraphic> = new Vector.<StarGraphic>(TOTAL,true);
            var _local_2:int = 0;
            while(_local_2 < TOTAL) {
                _local_1[_local_2] = new StarGraphic();
                addChild(_local_1[_local_2]);
                _local_2++;
            }
            return _local_1;
        }
        
        private function layoutStars(param1:Vector.<StarGraphic>) : void {
            var _local_2:int = 0;
            while(_local_2 < TOTAL) {
                param1[_local_2].x = MARGIN + param1[0].width * _local_2;
                param1[_local_2].y = MARGIN;
                _local_2++;
            }
        }
        
        private function makeBackground() : Sprite {
            var _local_1:Sprite = new Sprite();
            this.drawBackground(_local_1.graphics);
            addChildAt(_local_1,0);
            return _local_1;
        }
        
        private function drawBackground(param1:Graphics) : void {
            var _local_2:StarGraphic = this.stars[0];
            var _local_3:int = _local_2.width * TOTAL + 2 * MARGIN;
            var _local_4:int = _local_2.height + 2 * MARGIN;
            param1.clear();
            param1.beginFill(BACKGROUND_COLOR);
            param1.drawRoundRect(0,0,_local_3,_local_4,CORNER,CORNER);
            param1.endFill();
        }
        
        public function setStars(param1:int) : void {
            var _local_2:int = 0;
            while(_local_2 < TOTAL) {
                this.updateStar(_local_2,param1);
                _local_2++;
            }
        }
        
        private function updateStar(param1:int, param2:int) : void {
            var _local_3:StarGraphic = this.stars[param1];
            var _local_4:ColorTransform = _local_3.transform.colorTransform;
            _local_4.color = param1 < param2?uint(FILLED_STAR_COLOR):uint(EMPTY_STAR_COLOR);
            _local_3.transform.colorTransform = _local_4;
        }
    }
}
