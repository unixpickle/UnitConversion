//
//  Unit.m
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Unit.h"

@implementation Unit

@synthesize longName;
@synthesize shortName;
@synthesize equivalencies;

- (id)initWithCUnit:(const struct CUnit *)aUnit unitFetcher:(FetchUnitBlock)fetcher {
	if ((self = [super init])) {
		shortName = [[NSString alloc] initWithUTF8String:aUnit->unitShort];
		longName = [[NSString alloc] initWithUTF8String:aUnit->unitLong];
		NSMutableArray * subArray = [NSMutableArray array];
		for (int i = 0; i < aUnit->n_equivalencies; i++) {
			const struct CEquivalency * subEquiv = &(aUnit->equivalencies[i]);
			NSString * subShortName = [[NSString alloc] initWithUTF8String:subEquiv->equivShort];
			Unit * unit = fetcher(subShortName);
			if (!unit) {
				return nil;
			}
			Equivalency * equ = [[Equivalency alloc] initWithFromUnit:self
															   toUnit:unit
													 conversionFactor:subEquiv->factor];
			[subArray addObject:equ];
			[unit addEquivalency:[equ inverseEquivalency]];
		}
		equivalencies = [[NSArray alloc] initWithArray:subArray];
	}
	return self;
}

- (void)addEquivalency:(Equivalency *)equ {
	// check if we already have it
	for (int i = 0; i < [equivalencies count]; i++) {
		Equivalency * equ = [equivalencies objectAtIndex:i];
		if ([[equ toUnit] isEqualToUnit:[equ toUnit]]) {
			return;
		}
	}
	// if not, add it
	equivalencies = [equivalencies arrayByAddingObject:equ];
}

- (BOOL)isEqualToUnit:(Unit *)aUnit {
	if ([[self shortName] isEqualToString:[aUnit shortName]]) {
		if ([[self longName] isEqualToString:[aUnit longName]]) {
			return YES;
		}
	}
	return NO;
}

@end
