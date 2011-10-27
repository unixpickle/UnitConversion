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
	{"second", "sec", 1, {
		{"min", 60}
	}},
	{"minute", "min", 1, {
		{"hr", 60}
	}},
	{"hour", "hr", 1, {
		{"day", 24}
	}},
	{"day", "day", 2, {
		{"yr", 365},
		{"week", 7}
	}},
	{"week", "week", 0, {}},
	{"year", "yr", 0, {}},
	// measurement of money!!!
	{"peso", "peso", 1, {
		{"dollar", 13.3750635}
	}},
	{"dollar", "dollar", 1, {
		{"eur", 1.3948}
	}},
	{"euro", "eur", 0, {}},
	// measurement of distance
	{"inch", "in", 1, {
		{"ft", 12}
	}},
	{"foot", "ft", 2, {
		{"mi", 5280},
		{"yd", 3}
	}},
	{"yard", "yd", 0, {}},
	{"mile", "mi", 0, {}},
	{"centemeter", "cm", 1, {
		{"m", 100}
	}},
	{"meter", "m", 2, {
		{"yd", 1.0/1.0936133},
		{"km", 1000}
	}},
	{"kilometer", "km", 0, {}}
};

static const int CUnitListCount = sizeof(CUnitList)/sizeof(struct CUnit);

#endif
