package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
    import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    
    public class ShieldComparison extends SlotComparison {
         
        
        private var projectileComparison:GeneralProjectileComparison;
        
        public function ShieldComparison() {
            this.projectileComparison = new GeneralProjectileComparison();
            super();
        }
        
        override protected function compareSlots(param1:XML, param2:XML) : void {
            var _local_3:* = null;
            this.projectileComparison.compare(param1,param2);
            comparisonStringBuilder = this.projectileComparison.comparisonStringBuilder;
            for(_local_3 in this.projectileComparison.processedTags) {
                processedTags[_local_3] = this.projectileComparison.processedTags[_local_3];
            }
            this.handleException(param1);
        }
        
        private function handleException(param1:XML) : void {
            var tag:XML = null;
            var innerLineBuilder:LineBuilder = null;
            var itemXML:XML = param1;
            if(itemXML.@id == "Shield of Ogmur") {
                tag = itemXML.ConditionEffect.(text() == "Armor Broken")[0];
                innerLineBuilder = new LineBuilder().setParams(TextKey.EFFECT_FOR_DURATION,{
                    "effect":TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_ARMOR_BROKEN),
                    "duration":tag.@duration
                }).setPrefix(TooltipHelper.getOpenTag(UNTIERED_COLOR)).setPostfix(TooltipHelper.getCloseTag());
                comparisonStringBuilder.pushParams(TextKey.PARTY_EFFECT,{"effect":innerLineBuilder});
                processedTags[tag.toXMLString()] = true;
            }
        }
    }
}
