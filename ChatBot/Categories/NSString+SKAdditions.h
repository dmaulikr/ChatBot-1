#import <Foundation/Foundation.h>

@interface NSString (NSStringSKAdditions)

@property (nonatomic, readonly, copy) NSString *stringByEscapingHTML;
- (NSArray *)matchesInString:(NSString *)string pattern:(NSString*)pattern;

@end
