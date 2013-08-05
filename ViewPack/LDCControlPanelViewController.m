//
//  LDCControlPanelViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCControlPanelViewController.h"
#import "LDCViewController.h"
#import "MBProgressHUD.h"
#import "GCDiscreetNotificationView.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface LDCControlPanelViewController ()

@end

@implementation LDCControlPanelViewController

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
    self.view.backgroundColor = [UIColor grayColor];
    [self.startButton removeFromSuperview];
    
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 920, 53, 30)];
    [returnButton setImage:[UIImage imageNamed:@"scrollViewBackButton.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnToRootView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
    
    [self initSlider];
    [self initSwitch];
    
    //multi-thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //耗时的操作
        if([self connectedToNetwork])
        {
            //MBProgressHUD
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"Loading";
            
            NSURL *url = [NSURL URLWithString:@"http://avatar.csdn.net/B/3/F/1_dachang221.jpg"];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *avatarImage = [[UIImage alloc] initWithData:data];
            
            if(data != nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //更新UI
                    [hud hide:YES];
                    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
                    imageView.image = avatarImage;
                    [self.view addSubview:imageView];
                });
            }
        }
        else
        {
            NSLog(@"none net");
            _notification = [[GCDiscreetNotificationView alloc]initWithText:@"No Active Network" showActivity:NO inPresentationMode:GCDiscreetNotificationViewPresentationModeBottom inView:self.view];
//            [self.notification showAndDismissAutomaticallyAnimated];
            [self.notification showAndDismissAfter:1];
        }
    });
    
//    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    //dispatch_group_async
    //dispatch_group_async 可以监听一组任务是否完成，完成后得到通知执行其他的操作。这个方法很有用，比如进行三个下载任务，只有当三个都完成之后才通知主界面
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"Update UI");
    });
    
    dispatch_release(group);
    
    //dispatch_barrier_async
    //dospatch_barrier_async是在前面的任务执行结束它才执行，而且它后面的任务等他执行完成之后才会执行
    
    dispatch_queue_t queueBarrier = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queueBarrier, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queueBarrier, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queueBarrier, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4];
    });
    
    dispatch_async(queueBarrier, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async3");
    });
    
    //dispatch_apply
    //dispatch_apply 执行某个代码N次

//    dispatch_apply(5, queueBarrier, ^(size_t index) {
//        //执行5次
//        NSLog(@"dispatch_apply");
//    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Action

- (void) returnToRootView
{
    [self.navigationController pushViewController:[[LDCSideMenuViewController alloc] init] animated:YES];
}

#pragma mark slider

- (void)initSlider
{
    CGRect frame = CGRectMake(10, 50, 200, 0);
    CGRect labelFrame = CGRectMake(230, 50, 50, 30);
    slider = [[UISlider alloc] initWithFrame:frame];
    sliderLabel = [[UILabel alloc] initWithFrame:labelFrame];
    sliderLabel.backgroundColor = [UIColor clearColor];
    sliderLabel.text = @"30.00";
    
    slider.minimumValue = 0.0;
    slider.maximumValue = 100.0;
    
//    slider.minimumTrackTintColor = [UIColor greenColor];
//    slider.maximumTrackTintColor = [UIColor redColor];
    slider.value = 30.0;
    
    slider.continuous = YES;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [self.view addSubview:sliderLabel];
}

- (void)sliderValueChanged:(id)sender
{
    UISlider *sliderValueChange = (UISlider*)sender;
    if(sliderValueChange == slider)
    {
        float value = sliderValueChange.value;
        slider.value = value;
        sliderLabel.text = [NSString stringWithFormat:@"%.2f",slider.value];
        
        if(sliderValueChange.value >= 90)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                            message:@"It's over 90"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:@"Reset", nil];
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //add
    }
    if (buttonIndex == 1)
    {
        slider.value = 30;
        sliderLabel.text = [NSString stringWithFormat:@"%.2f",slider.value];
    }
}

#pragma mark - UISwitch

- (void)initSwitch
{
    CGRect frame = CGRectMake(100, 200, 0, 0);
    
    switchTest = [[UISwitch alloc] initWithFrame:frame];
    switchTest.on = YES;
    [switchTest addTarget:self action:@selector(switchValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: switchTest];
    
}

- (void)switchValueChanged
{
    if(switchTest.on == YES)
    {
        imageView.hidden = NO;
    }
    else
    {
        imageView.hidden = YES;
    }
}

#pragma mark - 检查是否有网络连接


- (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
