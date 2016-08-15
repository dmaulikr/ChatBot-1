//
//  CBTChatBotAPIManager.m
//  TestTask
//
//  Created by William Boles on 14/08/2016.
//
//

#import "CBTChatBotAPIManager.h"

@implementation CBTChatBotAPIManager

#pragma mark - BotID

+ (void)retrieveBotIDWithCompletion:(void(^)(NSString *botID))completion {
    NSURL *url = [NSURL URLWithString:@"http://alice.pandorabots.com"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         NSString *content = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
         NSError *regExError = nil;
         NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"botid=(\\w+)" options:0 error:&regExError];
         NSAssert1(regExError == nil, @"Regexp error %@", regExError);
         NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
         NSString *botID = [content substringWithRange:[matches[0] rangeAtIndex:1]];
         
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            if (completion) {
                                completion(botID);
                            }
                        });
     }];
    
    [task resume];
}

#pragma mark - MessageResponse

+ (void)retrieveBotCust2FromBotWithID:(NSString *)botID
                           completion:(void(^)(NSString *botCust2))completion {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sheepridge.pandorabots.com/pandora/talk?botid=%@&skin=custom_input", botID]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         
         NSString *content = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
         NSError *regExError = nil;
         NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"name=\"botcust2\" value=\"(\\w+)" options:0 error:&regExError];
         NSAssert1(regExError == nil, @"Regexp error %@", regExError);
         NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
         NSString *botCust2 = [content substringWithRange:[matches[0] rangeAtIndex:1]];
         
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            if (completion) {
                                completion(botCust2);
                            }
                        });
     }];
    
    [task resume];
}

+ (void)requestReplyFromBotWithID:(NSString *)botID
                         botCust2:(NSString *)botCust2
                      lastMessage:(NSString *)lastMessage
                       completion:(void(^)(NSString *reply))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sheepridge.pandorabots.com/pandora/talk?botid=%@&skin=custom_input", botID]];
    
    NSString *postBody = [NSString stringWithFormat:@"input=%@&botcust2=%@",[lastMessage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]], botCust2];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         NSString *content = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
         NSError *regExError = nil;
         NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<b>A.L.I.C.E.:<\\/b> *(.*?)<br\\/>" options:0 error:&regExError];
         NSAssert1(regExError == nil, @"Regexp error %@", regExError);
         NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, content.length)];
         NSString *reply = [content substringWithRange:[matches[0] rangeAtIndex:1]];
         
         [NSThread sleepForTimeInterval:5]; // don't answer immediately
         
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            if (completion) {
                                completion(reply);
                            }
                        });
     }];
    
    [task resume];
}

@end
