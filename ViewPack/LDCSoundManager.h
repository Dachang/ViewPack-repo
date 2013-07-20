//
//  LDCSoundManager.h
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LDCSoundManager : NSObject
{
    AVAudioPlayer *player;
}

+(id) sharedManager;

-(void) playSoundEffectWithFileName: (NSString *)fileName;

@end
