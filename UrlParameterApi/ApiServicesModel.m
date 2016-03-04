//
//  ApiServicesModel.m
//  OpenKey
//
//  Created by DebutMac3 on 24/11/15.
//  Copyright © 2015 Debut infotech pvt ltd. All rights reserved.
//

#import "ApiServicesModel.h"
#import "JSON.h"

#define IMAGEURL @"http://stgadmin.qa-staging.com/uploads/"
#define WEBURL @"http://52.26.51.95:8000"

@implementation ApiServicesModel

+ (ApiServicesModel *)sharedManager
{
    static ApiServicesModel *sharedMobileKeysController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMobileKeysController = [[self alloc] init];
    });
    return sharedMobileKeysController;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

#pragma mark - requestGetApiMethodWithRequestDictionary with AndApendUrl 
- (void) requestGetApiMethodWithRequestDictionary: (NSMutableDictionary *)reqDict WithApendUrl:(NSString *)appendUrl AndApiIdentifier:(NSString *) identifier
{

    NSString *strUrl = [NSString stringWithFormat:@"%@", appendUrl];
    NSLog(@"Api Url is: %@", strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error = NULL;
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:reqDict
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    
    NSString *reqString = [[NSString alloc] initWithData:dataFromDict encoding:NSUTF8StringEncoding];
    NSLog(@"%@ api request string is: %@", identifier, reqString);
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:dataFromDict];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      
                                      if (!error)
                                      {

                                          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                               error:&error];
                                          
                                          // Code to call delegate method
                                          [self.delegate apiResponseDelegate:[responseDictionary mutableCopy] apiIdentifier:identifier];
                                          //NSLog(@"%@ api Response is: %@", identifier, responseDictionary);
                                      }
                                      else
                                      {
                                          NSLog(@"Error is:%@", error);
                                      }
                                  }];
    [task resume];    
}

- (NSMutableDictionary *)webServicesWithRequestDictionary :(NSMutableDictionary *)reqDict withRequestUrl:(NSString *)reqURL
{
    
    // iPhoen5_IOS8.4_GuestAppV1.6.2
    NSString *strUrl = [NSString stringWithFormat:@"%@", reqURL];
    NSLog(@"%@", strUrl);
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error = NULL;
    NSString *jsonString = [reqDict JSONRepresentation];
    NSLog(@"Request json : %@", jsonString);
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:[NSData dataWithBytes:[jsonString UTF8String] length:jsonString.length]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSMutableString *responseStr = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response json : %@", responseStr);
    
    NSMutableDictionary *arr = [[NSMutableDictionary alloc]init];
    arr = [responseStr JSONValue];
    if (error == nil )
    {
        return arr;
    }
    else
    {
        return arr;
    }
}



- (NSMutableDictionary *)webServicesWithRequestString :(NSString *)urlDataString withRequestUrl:(NSString *)reqURL
{
    
    // iPhoen5_IOS8.4_GuestAppV1.6.2
    NSString *strUrl = [NSString stringWithFormat:@"%@?%@",reqURL, urlDataString];
    
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"%@", strUrl);

    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error = NULL;
    
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSMutableString *responseStr = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response json : %@", responseStr);
    
    NSMutableDictionary *arr = [[NSMutableDictionary alloc]init];
    arr = [responseStr JSONValue];
    if (error == nil )
    {
        return arr;
    }
    else
    {
        NSLog(@"%@", error);
        
        //[arr addObject:NULL];
        return arr;
    }
    
}

@end
