//
//  UnitPool.m
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UnitPool.h"

@implementation UnitPool

+ (UnitPool *)sharedInstance {
	static UnitPool * pool = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		pool = [[UnitPool alloc] init];
	});
	return pool;
}

- (id)init {
	if ((self = [super init])) {
		NSMutableArray * unitArray = [NSMutableArray array];
		__weak __block Unit * (^handleNewBlock)(NSString * shortName) = ^ Unit * (NSString * shortName) {
			for (int j = 0; j < [unitArray count]; j++) {
				if ([[[unitArray objectAtIndex:j] shortName] isEqualToString:shortName]) {
					return [unitArray objectAtIndex:j];
				}
			}
			for (int i = 0; i < CUnitListCount; i++) {
				const struct CUnit * myUnit = &CUnitList[i];
				if ([[NSString stringWithUTF8String:myUnit->unitShort] isEqualToString:shortName]) {
					Unit * aUnit = [[Unit alloc] initWithCUnit:myUnit unitFetcher:handleNewBlock];
					[unitArray addObject:aUnit];
					return aUnit;
				}
			}
			return nil;
		};
		
		for (int i = 0; i < CUnitListCount; i++) {
			const struct CUnit * myUnit = &CUnitList[i];
			if (!handleNewBlock([NSString stringWithUTF8String:myUnit->unitShort])) {
				return nil;
			}
		}
		
		units = unitArray;
	}
	return self;
}

- (Unit *)unitWithShortName:(NSString *)shortName {
	for (Unit * unit in units) {
		if ([[unit shortName] isEqualToString:shortName]) {
			return unit;
		}
	}
	return nil;
}

- (Unit *)unitWithLongName:(NSString *)longName {
	for (Unit * unit in units) {
		if ([[unit longName] isEqualToString:longName]) {
			return unit;
		}
	}
	return nil;
}

- (Unit *)unitWithName:(NSString *)unitName {
	NSString * lowercase = [unitName lowercaseString];
	Unit * longN = [self unitWithLongName:lowercase];
	Unit * shortN = [self unitWithShortName:lowercase];
	if (longN) return longN;
	if (shortN) return shortN;
	return nil;
}

- (ConvertNode *)convertFromUnit:(Unit *)aUnit toUnit:(Unit *)anotherUnit {
	NSMutableArray * queue = [[NSMutableArray alloc] init];
	__block NSMutableArray * used = [[NSMutableArray alloc] init];
	ConvertNode * rootNode = [[ConvertNode alloc] initWithUnit:aUnit history:[NSArray array]];
	[queue addObject:rootNode];
	while ([queue count] > 0) {
		ConvertNode * first = [queue objectAtIndex:0];
		[queue removeObjectAtIndex:0];
		if ([[first currentUnit] isEqualToUnit:anotherUnit]) {
			return first;
		}
		NSArray * subNodes = [first expandToSubNodes:^BOOL (Unit * aUnit) {
			if (![used containsObject:aUnit]) {
				[used addObject:aUnit];
				return NO;
			}
			return YES;
		}];
		[queue addObjectsFromArray:subNodes];
	}
	return nil;
}

- (double)factorFromUnit:(Unit *)aUnit toUnit:(Unit *)anotherUnit {
	ConvertNode * unit = [self convertFromUnit:aUnit toUnit:anotherUnit];
	if (!unit) {
		unit = [self convertFromUnit:anotherUnit toUnit:aUnit];
		if (!unit) return NAN;
		return 1.0f / [unit calculateConversionFactor];
	}
	return [unit calculateConversionFactor];
}

@end
