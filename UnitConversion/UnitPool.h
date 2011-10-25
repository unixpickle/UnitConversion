//
//  UnitPool.h
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unit.h"
#import "Equivalency.h"
#import "ConvertNode.h"

@interface UnitPool : NSObject {
	NSMutableArray * units;
}

+ (UnitPool *)sharedInstance;

- (Unit *)unitWithShortName:(NSString *)shortName;
- (Unit *)unitWithLongName:(NSString *)longName;
- (Unit *)unitWithName:(NSString *)unitName;

- (ConvertNode *)convertFromUnit:(Unit *)aUnit toUnit:(Unit *)anotherUnit;
- (double)factorFromUnit:(Unit *)aUnit toUnit:(Unit *)anotherUnit;

@end
