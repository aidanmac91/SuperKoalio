//
//  Player.m
//  SuperKoalio
//
//  Created by Jake Gundersen on 12/27/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import "Player.h"
#import "SKTUtils.h"

@implementation Player
int multiplierForDirection;
//1
- (instancetype)initWithImageNamed:(NSString *)name
{
  if (self == [super initWithImageNamed:name]) {
    self.velocity = CGPointMake(0.0, 0.0);
  }
  return self;
}

- (void)update:(NSTimeInterval)delta
{
  CGPoint gravity = CGPointMake(0.0, -450.0);
  CGPoint gravityStep = CGPointMultiplyScalar(gravity, delta);
  //1
  CGPoint forwardMove = CGPointMake(800.0, 0.0);
  CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, delta);
  
  CGPoint backwardMove = CGPointMake(-800.0, 0.0);
  CGPoint backwardMoveStep = CGPointMultiplyScalar(backwardMove, delta);

  self.velocity = CGPointAdd(self.velocity, gravityStep);
  //2
  self.velocity = CGPointMake(self.velocity.x * 0.9, self.velocity.y);
  //3
  CGPoint jumpForce = CGPointMake(0.0, 310.0);
  float jumpCutoff = 150.0;
  
  if (self.mightAsWellJump && self.onGround) {
    self.velocity = CGPointAdd(self.velocity, jumpForce);
    [self runAction:[SKAction playSoundFileNamed:@"jump.wav" waitForCompletion:NO]];
  } else if (!self.mightAsWellJump && self.velocity.y > jumpCutoff) {
    self.velocity = CGPointMake(self.velocity.x, jumpCutoff);
  }
  
  if (self.forwardMarch) {
    self.velocity = CGPointAdd(self.velocity,forwardMoveStep);
    multiplierForDirection = 1;
    self.xScale = fabs(self.xScale) * multiplierForDirection;
  }
  if(self.backwardMarch){
    self.velocity = CGPointAdd(self.velocity,backwardMoveStep);
    
    multiplierForDirection = -1;
    self.xScale = fabs(self.xScale) * multiplierForDirection;
  }
  //4
  CGPoint minMovement = CGPointMake(450.0, -450);
  CGPoint maxMovement = CGPointMake(120.0, 250.0);
  self.velocity = CGPointMake(Clamp(self.velocity.x, -minMovement.x, maxMovement.x), Clamp(self.velocity.y, minMovement.y, maxMovement.y));
  
  CGPoint velocityStep = CGPointMultiplyScalar(self.velocity, delta);
  
  self.desiredPosition = CGPointAdd(self.position, velocityStep);
}

- (CGRect)collisionBoundingBox
{
  CGRect boundingBox = CGRectInset(self.frame, 2, 0);
  CGPoint diff = CGPointSubtract(self.desiredPosition, self.position);
  return CGRectOffset(boundingBox, diff.x, diff.y);
}


@end
