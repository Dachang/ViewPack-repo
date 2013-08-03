//
//  LDCWeatherViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-8-3.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCWeatherViewController.h"
#import "LDCGraphicName.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBackground
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initButton
{
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, (SCREEN_HEIGHT - 100)/2, 150, 100)];
    [tempButton setImage:[UIImage imageNamed:PUSH_BUTTON] forState:UIControlStateNormal];
    [tempButton addTarget:self action:@selector(pushButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempButton];
}

- (void)pushButtonPressed:(UIButton*)sender
{
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101010100.html"]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    
    NSLog(@"今天是 %@ %@ %@ 的天气状况是:%@ %@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"],[weatherInfo objectForKey:@"weather1"],[weatherInfo objectForKey:@"temp1"]);  
    NSLog(@"weathinfo字典里的内容是---> %@",[weatherInfo description]);
}

@end
