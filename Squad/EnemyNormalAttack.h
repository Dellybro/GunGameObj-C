//
//  EnemyNormalAttack.h
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EnemyNormalAttack : SKSpriteNode

-(id)initWithPositionAndRotation:(CGPoint)position with:(double)rotation;
-(void)shoot:(double)rotation;

@end
