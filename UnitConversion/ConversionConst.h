//
//  ConversionConst.h
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef UnitConversion_ConversionConst_h
#define UnitConversion_ConversionConst_h

struct CEquivalency {
	char * equivShort;
	double factor;
};

struct CUnit {
	char * unitLong;
	char * unitShort;
	int n_equivalencies;
	struct CEquivalency equivalencies[5];
};

static const struct CUnit CUnitList[] = {
	// measurements of time
	{"second", "sec", 0, {}},
	{"minute", "min", 1, {
		{"sec", 60}
	}},
	{"hour", "hr", 1, {
		{"min", 60}
	}},
	{"day", "day", 1, {
		{"hr", 24}
	}},
	{"week", "week", 1, {
		{"day", 7}
	}},
	{"year", "yr", 1, {
		{"day", 365}
	}},
	// measurement of money!!!
	{"peso", "peso", 0, {}},
	{"dollar", "dollar", 1, {
		{"peso", 13.3750635}
	}},
	{"euro", "eur", 1, {
		{"dollar", 1.3948}
	}},
	// measurement of distance
	{"inch", "in", 0, {}},
	{"foot", "ft", 1, {
		{"in", 12}
	}},
	{"yard", "yd", 1, {
		{"ft", 3}
	}},
	{"mile", "mi", 1, {
		{"ft", 5280},
	}},
	{"centemeter", "cm", 0, {}},
	{"meter", "m", 2, {
		{"cm", 100},
		{"yd", 1.0936133}
	}},
	{"kilometer", "km", 1, {
		{"m", 1000}
	}}
};

static const int CUnitListCount = sizeof(CUnitList)/sizeof(struct CUnit);

#endif
