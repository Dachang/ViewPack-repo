//
//  WTWeatherHTTPClient.h
//  Weather
//
//  Created by 大畅 on 13-8-3.
//  Copyright (c) 2013年 Scott Sherwood. All rights reserved.
//

//为每个web service创建一个子类
//执行HTTP请求---当有新的可用天气数据时，调用delegate---使用用户当前地理位置来获得准确的天气

#import "AFHTTPClient.h"

@protocol WeatherHttpClientDelegate;

@interface WTWeatherHTTPClient : AFHTTPClient

@property (weak) id delegate;

//在AFHTTPClient子类中，创建一个类方法，用来返回一个共享的单例，这将会节约资源并省去必要的对象创建
+ (WTWeatherHTTPClient *)sharedWeatherHTTPClient;

- (id)initWithBaseURL:(NSURL *)url;
- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number;

@end

@protocol WeatherHttpClientDelegate
-(void)weatherHTTPClient:(WTWeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
-(void)weatherHTTPClient:(WTWeatherHTTPClient *)client didFailWithError:(NSError *)error;
@end