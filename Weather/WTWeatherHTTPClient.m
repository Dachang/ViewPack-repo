//
//  WTWeatherHTTPClient.m
//  Weather
//
//  Created by 大畅 on 13-8-3.
//  Copyright (c) 2013年 Scott Sherwood. All rights reserved.
//

#import "WTWeatherHTTPClient.h"
#import "AFNetworking.h"

@implementation WTWeatherHTTPClient

//sharedWeatherHTTPClient方法使用GCD来确保这个共享的单例对象只被初始化分配一次
+ (WTWeatherHTTPClient *)sharedWeatherHTTPClient
{
    NSString *urlStr = @"http://free.worldweatheronline.com/feed/";
    
    static dispatch_once_t pred;
    static WTWeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    
    dispatch_once(&pred, ^{ _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedWeatherHTTPClient;
}

//override
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
    {
        return nil;
    }
    //将期望web service相应为JSON
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d",number] forKey:@"num_of_days"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude, location.coordinate.longitude] forKey:@"q"];
    [parameters setObject:@"json" forKey:@"format"];
    [parameters setObject:@"7f3a3480fc162445131401" forKey:@"key"];
    
    [self getPath:@"weather.ashx"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)])
              {
                  [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error){
              if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)])
              {
                  [self.delegate weatherHTTPClient:self didFailWithError:error];
              }
          }];
}
    

@end
