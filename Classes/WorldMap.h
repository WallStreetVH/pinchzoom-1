//
//  WorldMap.h
//  pinchzoom
//
//  Created by Casey Broich on 7/12/10.
//  Copyright Pagex 2010. All rights reserved.
//


#import "cocos2d.h"
#import "GameHUD.h"
#import "Creep.h"
#import "Projectile.h"
#import "Tower.h"
#import "WayPoint.h"
#import "Wave.h"

@interface WorldMap : CCLayer
{
	CCTMXTiledMap *_tileMap;
    CCTMXLayer *_background;
	
	GameHUD * gameHUD;

}

@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;

+(id) scene;

@end
