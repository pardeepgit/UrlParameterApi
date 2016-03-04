//
//  ViewController.m
//  UrlParameterApi
//
//  Created by Chetu India on 04/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "ViewController.h"
#import "ApiServicesModel.h"
#import "JSON.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"Hi inside of an viewWillAppear Method.");
    
     [self webApiWithUrlDataRequest];
}


- (void)webApiWithUrlDataRequest
{
    NSString *reqUrl = @"http://www.forapp.com/api/getContacts.php";
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"Kate Bell" forKey:@"name"];
    [dict1 setObject:@"5555648583" forKey:@"phone"];

    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"Daniel" forKey:@"name"];
    [dict2 setObject:@"4085553514" forKey:@"phone"];

    NSMutableArray *reqArray = [[NSMutableArray alloc] init];
    [reqArray addObject:dict1];
    [reqArray addObject:dict2];
    
    NSString *jsonString = [reqArray JSONRepresentation];
    NSLog(@"%@", jsonString);

    NSString *reqStr = [NSString stringWithFormat:@"data=%@", jsonString];
    NSLog(@"%@", reqStr);
    
    [[ApiServicesModel sharedManager] webServicesWithRequestString:reqStr withRequestUrl:reqUrl];
}

- (void)webApiWithJsonRequestData
{
    
    NSString *reqUrl = @"http://www.forapp.com/api/getContacts.php";

    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"Kate Bell" forKey:@"name"];
    [dict1 setObject:@"5555648583" forKey:@"phone"];
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"Daniel" forKey:@"name"];
    [dict2 setObject:@"4085553514" forKey:@"phone"];
    
    NSMutableArray *reqArray = [[NSMutableArray alloc] init];
    [reqArray addObject:dict1];
    [reqArray addObject:dict2];

    NSMutableDictionary *reqDictionary = [[NSMutableDictionary alloc] init];
    [reqDictionary setObject:reqArray forKey:@"data"];
    
    [[ApiServicesModel sharedManager] webServicesWithRequestDictionary:reqDictionary withRequestUrl:reqUrl];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
