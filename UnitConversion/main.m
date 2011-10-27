//
//  main.m
//  UnitConversion
//
//  Created by Alex Nichol on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitPool.h"

NSString * ANFileReadLine (FILE * aFile);
void ANFilePrint (NSString * string);

int main (int argc, const char * argv[]) {
	@autoreleasepool {
		UnitPool * pool = [UnitPool sharedInstance];
		
		ANFilePrint(@"Have: ");
		NSString * have = ANFileReadLine(stdin);
		ANFilePrint(@"Want: ");
		NSString * want = ANFileReadLine(stdin);
		
		Unit * haveUnit = [pool unitWithName:have];
		Unit * wantUnit = [pool unitWithName:want];
		
		if (!haveUnit || !wantUnit) {
			ANFilePrint(@"Units not found!\n");
		} else {
			double equivalency = [pool factorFromUnit:haveUnit toUnit:wantUnit];
			if (isnan(equivalency)) {
				ANFilePrint(@"No equivalency chain found.\n");
			} else {
				printf("1 %s = %f %ss\n", [[haveUnit longName] UTF8String],
					   equivalency, 
					   [[wantUnit longName] UTF8String]);
			}
		}
	}
	
	@autoreleasepool {
		while (true) {
			[NSThread sleepForTimeInterval:1];
		}
	}
	
	return 0;
}

NSString * ANFileReadLine (FILE * aFile) {
	NSMutableString * string = [NSMutableString string];
	int c = 0;
	while ((c = fgetc(aFile)) != EOF) {
		if (c != '\r') {
			if (c == '\n') {
				break;
			}
			[string appendFormat:@"%c", (char)c];
		}
	}
	return string;
}

void ANFilePrint (NSString * string) {
	printf("%s", [string UTF8String]);
	fflush(stdout);
}

