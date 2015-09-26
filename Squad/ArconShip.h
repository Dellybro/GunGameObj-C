//
//  ArconShip.h
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ArconShip : SKSpriteNode

-(void)moveShip:(CGPoint)targetedUserLocation;
-(int)takeDamage;

@property int health;

@end
