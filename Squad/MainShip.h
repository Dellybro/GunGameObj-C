//
//  MainShip.h
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MainShip : SKSpriteNode



-(void)soldierRunRight;
-(void)soldierRunLeft;
-(void)soldierFire:(double)degrees;
-(void)soldierJump;
-(void)shoot:(CGPoint)touchPoint;

@property int HandSide;

@end
