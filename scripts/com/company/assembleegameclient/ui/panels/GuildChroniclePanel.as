package com.company.assembleegameclient.ui.panels {
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.guild.GuildChronicleScreen;
    import flash.events.MouseEvent;
    import kabam.rotmg.text.model.TextKey;
    
    public class GuildChroniclePanel extends ButtonPanel {
         
        
        public function GuildChroniclePanel(param1:GameSprite) {
            super(param1,TextKey.GUILD_CHRONICLE_TITLE,TextKey.PANEL_VIEW_BUTTON);
        }
        
        override protected function onButtonClick(param1:MouseEvent) : void {
            gs_.mui_.clearInput();
            gs_.addChild(new GuildChronicleScreen(gs_));
        }
    }
}
