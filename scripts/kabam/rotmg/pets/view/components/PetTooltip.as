package kabam.rotmg.pets.view.components {
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import kabam.rotmg.pets.data.AbilityVO;
    import kabam.rotmg.pets.data.PetFamilyKeys;
    import kabam.rotmg.pets.data.PetRarityEnum;
    import kabam.rotmg.pets.data.PetVO;
    import kabam.rotmg.pets.util.PetsConstants;
    import kabam.rotmg.pets.util.PetsViewAssetFactory;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.ui.model.TabStripModel;
    
    public class PetTooltip extends ToolTip {
         
        
        private const petsContent:Sprite = new Sprite();
        
        private const titleTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777215,16,true);
        
        private const petRarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(11776947,12,false);
        
        private const petFamilyTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(11776947,12,false);
        
        private const lineBreak:LineBreakDesign = PetsViewAssetFactory.returnTooltipLineBreak();
        
        private var petBitmap:Bitmap;
        
        private var petVO:PetVO;
        
        public function PetTooltip(param1:PetVO) {
            this.petVO = param1;
            super(3552822,1,16777215,1,true);
            this.petsContent.name = TabStripModel.PETS;
        }
        
        public function init() : void {
            this.petBitmap = this.petVO.getSkin();
            this.addChildren();
            this.addAbilities();
            this.positionChildren();
            this.updateTextFields();
        }
        
        private function updateTextFields() : void {
            this.titleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getName()));
            this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getRarity()));
            this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.getFamily())));
        }
        
        private function addChildren() : void {
            this.petsContent.graphics.beginFill(0,0);
            this.petsContent.graphics.drawRect(0,0,PetsConstants.TOOLTIP_WIDTH,PetsConstants.TOOLTIP_HEIGHT);
            this.petsContent.addChild(this.petBitmap);
            this.petsContent.addChild(this.titleTextField);
            this.petsContent.addChild(this.petRarityTextField);
            this.petsContent.addChild(this.petFamilyTextField);
            this.petsContent.addChild(this.lineBreak);
            addChild(this.petsContent);
        }
        
        private function addAbilities() : void {
            var _local_1:uint = 0;
            var _local_3:AbilityVO = null;
            var _local_4:PetAbilityDisplay = null;
            var _local_2:uint = 3;
            _local_1 = 0;
            while(_local_1 < _local_2) {
                _local_3 = this.petVO.abilityList[_local_1];
                _local_4 = new PetAbilityDisplay(_local_3,174);
                _local_4.x = 8;
                _local_4.y = 86 + 17 * _local_1;
                this.petsContent.addChild(_local_4);
                _local_1++;
            }
        }
        
        private function getNumAbilities() : uint {
            var _local_1:Boolean = this.petVO.getRarity() == PetRarityEnum.DIVINE.value || this.petVO.getRarity() == PetRarityEnum.LEGENDARY.value;
            if(_local_1) {
                return 2;
            }
            return 3;
        }
        
        private function positionChildren() : void {
            this.titleTextField.x = 55;
            this.titleTextField.y = 21;
            this.petRarityTextField.x = 55;
            this.petRarityTextField.y = 35;
            this.petFamilyTextField.x = 55;
            this.petFamilyTextField.y = 48;
        }
    }
}
