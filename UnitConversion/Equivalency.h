//
//  Equivalency.h
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Unit;

@interface Equivalency : NSObject {
	__weak Unit * toUnit;
	__weak Unit * fromUnit;
	double conversionFactor;
}

@property (nonatomic, weak) Unit * toUnit;
@property (nonatomic, weak) Unit * fromUnit;
@property (nonatomic, readwrite) double conversionFactor;

- (id)initWithFromUnit:(Unit *)fromUnit toUnit:(Unit *)toUnit conversionFactor:(double)factor;
- (Equivalency *)inverseEquivalency;

@end
