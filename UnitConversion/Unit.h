//
//  Unit.h
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Equivalency.h"
#include "ConversionConst.h"

@interface Unit : NSObject {
	NSString * longName;
	NSString * shortName;
	NSArray * equivalencies;
}

@property (readonly) NSString * longName;
@property (readonly) NSString * shortName;
@property (readonly) NSArray * equivalencies;

- (id)initWithCUnit:(const struct CUnit *)aUnit unitFetcher:(__weak Unit * (^)(NSString * shortName))fetcher;
- (void)addEquivalency:(Equivalency *)equ;
- (BOOL)isEqualToUnit:(Unit *)aUnit;

@end
