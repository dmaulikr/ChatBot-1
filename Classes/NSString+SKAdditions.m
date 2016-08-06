#import "NSString+SKAdditions.h"

@implementation NSString (NSStringSKAdditions)

- (NSString *)stringByEscapingHTML
{
    // see https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet#RULE_.231_-_HTML_Escape_Before_Inserting_Untrusted_Data_into_HTML_Element_Content
    NSString *result = self;
    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    result = [result stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    result = [result stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    return [result stringByReplacingOccurrencesOfString:@"'" withString:@"&#x27;"];
}

- (NSArray *)matchesInString:(NSString *)string pattern:(NSString*)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSAssert1(error == nil, @"Regexp error %@", error);
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSMutableArray *result = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        [result addObject:[string substringWithRange:matchRange]];
        NSLog(@"Found match: %@",[result lastObject]);
    }
    return result;
}

@end
