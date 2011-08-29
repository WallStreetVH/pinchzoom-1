//
//  TutorialLayer.h
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "Creep.h"
#import "Projectile.h"
#import "Tower.h"
#import "WayPoint.h"
#import "Wave.h"

#import "GameHUD.h"

// Tutorial Layer
@interface Stats3 : CCLayer
{
    CCTMXTiledMap *_tileMap2;
    CCTMXLayer *_background;
	NSString *wordMain;
	CCSprite * background2;
	CCSprite * background3;
	CCSprite * bg;
	CCSprite * A;
		
	int _currentLevel;
	
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	GameHUD * gameHUD;
	
	// Array to store the animal objects
	NSMutableArray *animals;

	
	CCSprite * selSpriteRange;
    CCSprite * selSprite;
 //   NSMutableArray * movableSprites;
}

@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) NSMutableArray *animals;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic, retain) NSString *wordMain;
@property (nonatomic, retain) CCSprite *A;


@property (nonatomic, assign) int currentLevel;

+ (id) scene;
- (void)addWaypoint;
- (void)addTower: (CGPoint)pos;
- (void)removeTower: (CGPoint)pos;
- (void)getPoints;
- (void)registerLoc;
- (BOOL) canBuildOnTilePosition:(CGPoint) pos;
- (CGPoint) tileCoordForPosition:(CGPoint) position;
- (void) setLabels;

@end


