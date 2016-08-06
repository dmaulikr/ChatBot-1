#import <Foundation/Foundation.h>


@interface NSObject (NSObjectAdditions)

// replacement for new that does autorelease
+(id)xnew;
+(NSArray*)declaredProperties;
-(NSArray*)declaredProperties;

@end
