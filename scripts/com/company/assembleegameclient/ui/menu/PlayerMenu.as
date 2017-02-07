package com.company.assembleegameclient.ui.menu {
    import com.company.assembleegameclient.game.AGameSprite;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.GameObjectListItem;
    import com.company.assembleegameclient.util.GuildUtil;
    import com.company.util.AssetLibrary;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import kabam.rotmg.chat.control.ShowChatInputSignal;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.friends.controller.FriendActionSignal;
    import kabam.rotmg.friends.model.FriendConstant;
    import kabam.rotmg.friends.model.FriendRequestVO;
    import kabam.rotmg.text.model.TextKey;
    
    public class PlayerMenu extends Menu {
         
        
        public var gs_:AGameSprite;
        
        public var playerName_:String;
        
        public var player_:Player;
        
        public var playerPanel_:GameObjectListItem;
        
        public function PlayerMenu() {
            super(3552822,16777215);
        }
        
        public function initDifferentServer(param1:AGameSprite, param2:String, param3:Boolean = false, param4:Boolean = false) : void {
            var _local_5:MenuOption = null;
            this.gs_ = param1;
            this.playerName_ = param2;
            this.player_ = null;
            this.yOffset = this.yOffset - 25;
            _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,TextKey.PLAYERMENU_PM);
            _local_5.addEventListener(MouseEvent.CLICK,this.onPrivateMessage);
            addOption(_local_5);
            _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lotfInterfaceBig",10),16777215,TextKey.FRIEND_ADD_TITLE);
            _local_5.addEventListener(MouseEvent.CLICK,this.onAddFriend);
            addOption(_local_5);
            if(param3) {
                _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,TextKey.PLAYERMENU_GUILDCHAT);
                _local_5.addEventListener(MouseEvent.CLICK,this.onGuildMessage);
                addOption(_local_5);
            }
            if(param4) {
                _local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",7),16777215,TextKey.PLAYERMENU_TRADE);
                _local_5.addEventListener(MouseEvent.CLICK,this.onTradeMessage);
                addOption(_local_5);
            }
        }
        
        public function init(param1:AGameSprite, param2:Player) : void {
            var _local_3:MenuOption = null;
            this.gs_ = param1;
            this.playerName_ = param2.name_;
            this.player_ = param2;
            this.playerPanel_ = new GameObjectListItem(11776947,true,this.player_,true);
            this.yOffset = this.yOffset + 7;
            addChild(this.playerPanel_);
            if(Player.isAdmin) {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",10),16777215,TextKey.PLAYERMENU_KICK);
                _local_3.addEventListener(MouseEvent.CLICK,this.onKick);
                addOption(_local_3);
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",4),16777215,TextKey.PLAYERMENU_MUTE);
                _local_3.addEventListener(MouseEvent.CLICK,this.onMute);
                addOption(_local_3);
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",3),16777215,TextKey.PLAYERMENU_UNMUTE);
                _local_3.addEventListener(MouseEvent.CLICK,this.onUnMute);
                addOption(_local_3);
            }
            if(this.gs_.map.allowPlayerTeleport() && this.player_.isTeleportEligible(this.player_)) {
                _local_3 = new TeleportMenuOption(this.gs_.map.player_);
                _local_3.addEventListener(MouseEvent.CLICK,this.onTeleport);
                addOption(_local_3);
            }
            if(this.gs_.map.player_.guildRank_ >= GuildUtil.OFFICER && (param2.guildName_ == null || param2.guildName_.length == 0)) {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",10),16777215,TextKey.PLAYERMENU_INVITE);
                _local_3.addEventListener(MouseEvent.CLICK,this.onInvite);
                addOption(_local_3);
            }
            if(!this.player_.starred_) {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2",5),16777215,TextKey.PLAYERMENU_LOCK);
                _local_3.addEventListener(MouseEvent.CLICK,this.onLock);
                addOption(_local_3);
            } else {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2",6),16777215,TextKey.PLAYERMENU_UNLOCK);
                _local_3.addEventListener(MouseEvent.CLICK,this.onUnlock);
                addOption(_local_3);
            }
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",7),16777215,TextKey.PLAYERMENU_TRADE);
            _local_3.addEventListener(MouseEvent.CLICK,this.onTrade);
            addOption(_local_3);
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,TextKey.PLAYERMENU_PM);
            _local_3.addEventListener(MouseEvent.CLICK,this.onPrivateMessage);
            addOption(_local_3);
            if(this.player_.isFellowGuild_) {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,TextKey.PLAYERMENU_GUILDCHAT);
                _local_3.addEventListener(MouseEvent.CLICK,this.onGuildMessage);
                addOption(_local_3);
            }
            if(!this.player_.ignored_) {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",8),16777215,TextKey.FRIEND_BLOCK_BUTTON);
                _local_3.addEventListener(MouseEvent.CLICK,this.onIgnore);
                addOption(_local_3);
            } else {
                _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",9),16777215,TextKey.PLAYERMENU_UNIGNORE);
                _local_3.addEventListener(MouseEvent.CLICK,this.onUnignore);
                addOption(_local_3);
            }
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",18),16777215,"Add as Friend");
            _local_3.addEventListener(MouseEvent.CLICK,this.onAddFriend);
            addOption(_local_3);
        }
        
        private function onKick(param1:Event) : void {
            this.gs_.gsc_.playerText("/kick " + this.player_.name_);
            remove();
        }
        
        private function onMute(param1:Event) : void {
            this.gs_.gsc_.playerText("/mute " + this.player_.name_);
            remove();
        }
        
        private function onUnMute(param1:Event) : void {
            this.gs_.gsc_.playerText("/unmute " + this.player_.name_);
            remove();
        }
        
        private function onPrivateMessage(param1:Event) : void {
            var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
            _local_2.dispatch(true,"/tell " + this.playerName_ + " ");
            remove();
        }
        
        private function onAddFriend(param1:Event) : void {
            var _local_2:FriendActionSignal = StaticInjectorContext.getInjector().getInstance(FriendActionSignal);
            _local_2.dispatch(new FriendRequestVO(FriendConstant.INVITE,this.playerName_));
            remove();
        }
        
        private function onTradeMessage(param1:Event) : void {
            var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
            _local_2.dispatch(true,"/trade " + this.playerName_);
            remove();
        }
        
        private function onGuildMessage(param1:Event) : void {
            var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
            _local_2.dispatch(true,"/g ");
            remove();
        }
        
        private function onTeleport(param1:Event) : void {
            this.gs_.map.player_.teleportTo(this.player_);
            remove();
        }
        
        private function onInvite(param1:Event) : void {
            this.gs_.gsc_.guildInvite(this.playerName_);
            remove();
        }
        
        private function onLock(param1:Event) : void {
            this.gs_.map.party_.lockPlayer(this.player_);
            remove();
        }
        
        private function onUnlock(param1:Event) : void {
            this.gs_.map.party_.unlockPlayer(this.player_);
            remove();
        }
        
        private function onTrade(param1:Event) : void {
            this.gs_.gsc_.requestTrade(this.playerName_);
            remove();
        }
        
        private function onIgnore(param1:Event) : void {
            this.gs_.map.party_.ignorePlayer(this.player_);
            remove();
        }
        
        private function onUnignore(param1:Event) : void {
            this.gs_.map.party_.unignorePlayer(this.player_);
            remove();
        }
    }
}
