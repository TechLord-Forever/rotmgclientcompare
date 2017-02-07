package kabam.rotmg.pets.data {
    public class PetYardEnum {
        
        public static const PET_YARD_ONE:PetYardEnum = new PetYardEnum("Yard Upgrader 1",1,PetRarityEnum.COMMON);
        
        public static const PET_YARD_TWO:PetYardEnum = new PetYardEnum("Yard Upgrader 2",2,PetRarityEnum.UNCOMMON);
        
        public static const PET_YARD_THREE:PetYardEnum = new PetYardEnum("Yard Upgrader 3",3,PetRarityEnum.RARE);
        
        public static const PET_YARD_FOUR:PetYardEnum = new PetYardEnum("Yard Upgrader 4",4,PetRarityEnum.LEGENDARY);
        
        public static const PET_YARD_FIVE:PetYardEnum = new PetYardEnum("Yard Upgrader 5",5,PetRarityEnum.DIVINE);
        
        public static const MAX_ORDINAL:int = 5;
         
        
        public var value:String;
        
        public var ordinal:int;
        
        public var rarity:PetRarityEnum;
        
        public function PetYardEnum(param1:*, param2:int, param3:PetRarityEnum) {
            super();
            this.value = param1;
            this.ordinal = param2;
            this.rarity = param3;
        }
        
        public static function get list() : Array {
            return [PET_YARD_ONE,PET_YARD_TWO,PET_YARD_THREE,PET_YARD_FOUR,PET_YARD_FIVE];
        }
        
        public static function selectByValue(param1:String) : PetYardEnum {
            var _local_2:PetYardEnum = null;
            var _local_3:PetYardEnum = null;
            for each(_local_3 in PetYardEnum.list) {
                if(param1 == _local_3.value) {
                    _local_2 = _local_3;
                }
            }
            return _local_2;
        }
        
        public static function selectByOrdinal(param1:int) : PetYardEnum {
            var _local_2:PetYardEnum = null;
            var _local_3:PetYardEnum = null;
            for each(_local_3 in PetYardEnum.list) {
                if(param1 == _local_3.ordinal) {
                    _local_2 = _local_3;
                }
            }
            return _local_2;
        }
    }
}
