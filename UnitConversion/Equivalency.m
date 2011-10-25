//
//  Equivalency.m
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Equivalency.h"

@implementation Equivalency

@synthesize toUnit;
@synthesize fromUnit;
@synthesize conversionFactor;

- (id)initWithFromUnit:(Unit *)_fromUnit toUnit:(Unit *)_toUnit conversionFactor:(double)factor {
	if ((self = [super init])) {
		toUnit = _toUnit;
		fromUnit = _fromUnit;
		conversionFactor = factor;
	}
	return self;
}

- (Equivalency *)inverseEquivalency {
	return [[Equivalency alloc] initWithFromUnit:toUnit toUnit:fromUnit
								conversionFactor:(1.0 / conversionFactor)];
}

@end
