#import <Foundation/Foundation.h>

@interface NSString (NSStringSKAdditions)

- (NSString *)stringByEscapingHTML;
- (NSArray *)matchesInString:(NSString *)string pattern:(NSString*)pattern;

@end
