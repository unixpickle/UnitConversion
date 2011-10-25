//
//  ConvertNode.m
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConvertNode.h"

@implementation ConvertNode

@synthesize currentUnit;
@synthesize unitHistory;

- (id)initWithUnit:(Unit *)unit history:(NSArray *)oldHistory {
	if ((self = [super init])) {
		currentUnit = unit;
		unitHistory = [[NSMutableArray alloc] initWithArray:oldHistory];
	}
	return self;
}

- (NSArray *)expandToSubNodes:(BOOL (^)(Unit * aUnit))wasTried {
	NSMutableArray * mutable = [[NSMutableArray alloc] init];
	for (int i = 0; i < [[currentUnit equivalencies] count]; i++) {
		Equivalency * equ = [[currentUnit equivalencies] objectAtIndex:i];
		if (!wasTried([equ toUnit])) {
			ConvertNode * newNode = [[ConvertNode alloc] initWithUnit:[equ toUnit]
															  history:unitHistory];
			[[newNode unitHistory] addObject:equ];
			[mutable addObject:newNode];
		}
	}
	return [NSArray arrayWithArray:mutable];
}

- (double)calculateConversionFactor {
	double factor = 1;
	for (int i = 0; i < [unitHistory count]; i++) {
		Equivalency * equ = [unitHistory objectAtIndex:i];
		factor *= [equ conversionFactor];
	}
	return factor;
}

@end
