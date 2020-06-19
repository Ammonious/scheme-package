 extension StringExt on String {
	 get capitalize => this[0].toUpperCase() + this.substring(1);
 }


 extension DoubleExtension on double {


	 double roundDigits(int fractionDigits){
		 return double.parse(this.toStringAsFixed(fractionDigits));
	 }

	 double nullCheck(){
		 if(this == null || this.isInfinite || this.isNaN) return 0.00;

		 return this;
	 }
 }
