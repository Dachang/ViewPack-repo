//
//  LDCWeatherViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-8-3.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCWeatherViewController.h"
#import "LDCGraphicName.h"
#import "NSMutableString+NSMutableString_CustomMethods.h"

@interface LDCWeatherViewController ()

@end

@implementation LDCWeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initBackground];
    [self initButton];
    [self loadWeatherData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBackground
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"WeatherBG.png"]];
}

//- (void)pushButtonPressed:(UIButton*)sender
//{
//    NSError *error;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101010100.html"]];
//    
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
//    
//    NSLog(@"今天是 %@ %@ %@ 的天气状况是:%@ %@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"],[weatherInfo objectForKey:@"weather1"],[weatherInfo objectForKey:@"temp1"]);
//    NSLog(@"weathinfo字典里的内容是---> %@",[weatherInfo description]);
//}

- (void)loadWeatherData
{
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101010100.html"]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    
    NSString *temperature = [weatherInfo objectForKey:@"temp1"];
    NSString *date = [weatherInfo objectForKey:@"date_y"];
    NSString *info = [weatherInfo objectForKey:@"weather1"];
    
    NSMutableString *mutableDate = [NSMutableString stringWithString:date];
    NSMutableString *mutableTemp = [NSMutableString stringWithString:temperature];
    
    void (^initWeatherImageBlock)(NSString*) = ^(NSString *infoString){
        if([infoString isEqual: @"晴转阴"])
        {
            _weatherImage.image = [UIImage imageNamed:@"cloudy.png"];
        }
        else
            NSLog(@"Error Retrieving Weather Info");
    };
    
    initWeatherImageBlock(info);

    [mutableDate replace:@"年" withNewString:@"-"];
    [mutableDate replace:@"月" withNewString:@"-"];
    [mutableDate replace:@"日" withNewString:@" "];
    
    NSString *res = [[mutableTemp substringFromIndex:0] substringToIndex:2];
    NSLog(@"%@",res);
    
    _tempLabel.backgroundColor = [UIColor clearColor];
    _tempLabel.text = mutableTemp;
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.text = mutableDate;
    
}

#pragma mark
#pragma mark back button

- (void)initButton
{
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 51, 30)];
    [BackButton setImage:[UIImage imageNamed:BACK_BUTTON] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackButton];
}

- (void)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
