package kabam.rotmg.promotions.view {
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import kabam.lib.resizing.view.Resizable;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
    
    public class AlreadyPurchasedBeginnersPackageDialog extends Sprite implements Resizable {
        
        public static var hifiBeginnerOfferAlreadyPurchasedEmbed:Class = AlreadyPurchasedBeginnersPackageDialog_hifiBeginnerOfferAlreadyPurchasedEmbed;
         
        
        private var closeBtn:Sprite;
        
        public function AlreadyPurchasedBeginnersPackageDialog() {
            super();
            this.addBackground();
            this.makeCloseButton();
        }
        
        private function addBackground() : void {
            addChild(new hifiBeginnerOfferAlreadyPurchasedEmbed());
        }
        
        private function makeCloseButton() : void {
            this.closeBtn = new Sprite();
            this.closeBtn.graphics.beginFill(16711680,0);
            this.closeBtn.graphics.drawRect(0,0,30,30);
            this.closeBtn.graphics.endFill();
            this.closeBtn.buttonMode = true;
            this.closeBtn.x = 550;
            this.closeBtn.y = 30;
            addEventListener(MouseEvent.CLICK,this.onClose);
            addChild(this.closeBtn);
        }
        
        private function onClose(param1:MouseEvent) : void {
            parent.removeChild(this);
            var _local_2:ShowDailyCalendarPopupSignal = StaticInjectorContext.getInjector().getInstance(ShowDailyCalendarPopupSignal);
            _local_2.dispatch();
        }
        
        public function resize(param1:Rectangle) : void {
            x = (param1.width - width) / 2;
            y = (param1.height - height) / 2;
        }
    }
}
