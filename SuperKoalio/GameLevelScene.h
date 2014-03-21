//
//  GameLevelScene.h
//  SuperKoalio
//

//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class GameLevelScene;
@protocol GameLevelSceneDelegate <NSObject>

-(void)moveForward;
@property (nonatomic, assign) BOOL isMoving;

@end
@interface GameLevelScene : SKScene

//@property (nonatomic, assign) BOOL isMoving;
@end
