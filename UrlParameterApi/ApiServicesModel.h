//
//  ApiServicesModel.h
//  OpenKey
//
//  Created by DebutMac3 on 24/11/15.
//  Copyright © 2015 Debut infotech pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiServicesModelResponseDelegate <NSObject>
- (void) apiResponseDelegate:(NSMutableDictionary *) respDictionary apiIdentifier:(NSString *)identifier;
@end


@interface ApiServicesModel : NSObject

@property (nonatomic, weak) id<ApiServicesModelResponseDelegate> delegate;

+ (ApiServicesModel *)sharedManager;

- (void) requestGetApiMethodWithRequestDictionary: (NSMutableDictionary *)reqDict WithApendUrl:(NSString *)appendUrl AndApiIdentifier:(NSString *) identifier;

- (NSMutableDictionary *)webServicesWithRequestDictionary :(NSMutableDictionary *)reqDict withRequestUrl:(NSString *)reqURL;

- (NSMutableDictionary *)webServicesWithRequestString :(NSString *)urlDataString withRequestUrl:(NSString *)reqURL;

@end
