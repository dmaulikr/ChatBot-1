#import <objc/runtime.h>
#import "GPNSObjectAdditions.h"


@implementation NSObject (NSObjectAdditions)

// just a shorthand
+(id)xnew {
	return [[[self alloc] init] autorelease];
}

+(NSArray*)declaredProperties {
	NSMutableArray *result = [NSMutableArray array];
	unsigned int count = 0;
	objc_property_t *props = class_copyPropertyList(self,&count);
	NSUInteger i;
	for(i=0; i<count; i++) {
		objc_property_t prop = props[i];
		NSString *propName = [NSString stringWithCString:property_getName(prop) encoding:NSASCIIStringEncoding];
		[result addObject:propName];
	}
	if([self superclass] != nil) {
		[result addObjectsFromArray:[[self superclass] declaredProperties]];
	}
	free(props);
	return result;	
}

-(NSArray*)declaredProperties {
	return [[self class] declaredProperties];
}

@end
