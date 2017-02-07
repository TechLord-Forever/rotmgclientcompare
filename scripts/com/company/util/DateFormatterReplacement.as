package com.company.util {
    public class DateFormatterReplacement {
         
        
        public var formatString:String;
        
        private const months:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
        
        public function DateFormatterReplacement() {
            super();
        }
        
        public function format(param1:Date) : String {
            var _local_2:String = this.formatString;
            _local_2 = _local_2.replace("D",param1.date);
            _local_2 = _local_2.replace("YYYY",param1.fullYear);
            _local_2 = _local_2.replace("MMMM",this.months[param1.month]);
            return _local_2;
        }
    }
}
