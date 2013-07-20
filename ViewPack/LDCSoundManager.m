//
//  LDCSoundManager.m
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCSoundManager.h"
#import <AudioToolbox/AudioToolbox.h>

static LDCSoundManager *soundManagerInstance;

@implementation LDCSoundManager

+(id) sharedManager
{
    if(!soundManagerInstance)
    {
        soundManagerInstance = [[LDCSoundManager alloc] init];
    }
    return soundManagerInstance;
}

-(void)playSoundEffectWithFileName:(NSString *)fileName
{
    SystemSoundID _soundID;
    NSString *newMessageSoundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    if(newMessageSoundPath)
    {
        NSURL *newMessageSoundUrl = [NSURL fileURLWithPath:newMessageSoundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)newMessageSoundUrl, &_soundID);
        if (err != kAudioServicesNoError)
        {
            //add
        }
        else
        {
            AudioServicesPlaySystemSound(_soundID);
        }
    }
}

@end
