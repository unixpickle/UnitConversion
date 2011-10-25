Units
=====

From a simple sense, units are what give numbers meaning. Without equivalencies to other units, a single measurement of unit can be pretty useless. The UnitConversion project has a file, <tt>ConversionConst.h</tt>, which contains a basic C-structure that holds a bunch of different unit equivalencies. Higher up in the UnitConversion code framework, these equivalencies are processed, and made to mean something.

Using these equivalencies, along with a basic search queue, any valid unit can be converted to any other valid unit, as long as a path can be taken through equivalencies to get from one to the other. This means that, as a programmer, you can add your own units without having to enter in the equivalency between every unit to every other unit, just enough equivalencies for all units to be loosely tied together.

Usage of the UnitPool Class
===========================

The <tt>UnitPool</tt> class is primarily what should be used for converting between units. It provides methods such as ```factorFromUnit:toUnit:``` which allow easy unit conversion. To convert, for example, a given number of seconds to a number of weeks, the following could be done:

	UnitPool * pool = [UnitPool sharedInstance];
	Unit * seconds = [pool unitWithName:@"second"];
	Unit * weeks = [pool unitWithName:@"week"];
	double equiv = [pool factorFromUnit:seconds toUnit:weeks];
	// there are equiv seconds in a week
	// so, you can do:
	double weeksNumber = secondsNumber / equiv;
	// or
	double secondsNumber = weeksNumber * equiv;