//
//  ConvertNode.h
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unit.h"

@interface ConvertNode : NSObject {
	Unit * currentUnit;
	NSMutableArray * unitHistory;
}

@property (readonly) Unit * currentUnit;
@property (readonly) NSMutableArray * unitHistory;

- (id)initWithUnit:(Unit *)unit history:(NSArray *)oldHistory;
- (NSArray *)expandToSubNodes:(BOOL (^)(Unit * aUnit))wasTried;
- (double)calculateConversionFactor;

@end
