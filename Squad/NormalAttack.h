//
//  NormalAttack.h
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NormalAttack : SKSpriteNode

-(id)initWithPosition:(CGPoint)position;
-(void)shoot:(double)rotation location:(CGVector)location;

@end
