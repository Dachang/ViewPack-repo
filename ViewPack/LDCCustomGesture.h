//
//  LDCCustomGesture.h
//  ViewPack
//
//  Created by 大畅 on 13-7-22.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum gestureDirection
{
    DIRECTION_UNKOWN = 0,
    DIRECTION_LEFT,
    DIRECTION_RIGHT,
} gestureDirection;

@protocol LDCTickleGestureDelegate <NSObject>

- (void)testMethod;

@end

@interface LDCCustomGesture : UIGestureRecognizer
{
    id<LDCTickleGestureDelegate> tickleDelegate;
    NSString *testForKVC;
    NSString *testForKVO;
//    NSArray *testForKVCArray;
}
@property (assign) int tickleCount;
@property (assign) int timeCount;
@property (assign) CGPoint curTickleStart;
@property (assign) gestureDirection lastDirection;

@property (nonatomic,retain) id <LDCTickleGestureDelegate> tickleDelegate;

-(void)changeStringForKVO:(NSString*) newString;

@end
