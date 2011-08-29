//
//  WorldMap.m
//  pinchzoom
//
//  Created by Casey Broich on 7/12/10.
//  Copyright Pagex 2010. All rights reserved.
//

// config class isn't necessary for this to work

#import "WorldMap.h"
#import "Config.h" 
#import "PinchZoomLayer.h"
#import "GameHUD.h"

@implementation WorldMap

@synthesize tileMap = _tileMap;
@synthesize background = _background;

+(id) scene
{
	CCScene *scene = [CCScene node];
	WorldMap *layer = [WorldMap node];
	[scene addChild: layer];
	
	GameHUD * myGameHUD = [GameHUD sharedHUD];
	[scene addChild:myGameHUD];

	return scene;
}

-(void)loadLabel {
	CCLabel* label = [CCLabel labelWithString:@"PinchZoom + DoubleTap + Scroll" fontName:@"Arial" fontSize:16];
	label.color = ccWHITE;
	CGSize size = [[CCDirector sharedDirector] winSize];
	label.position =  ccp( size.width/1.5 , 50 );
	[self addChild: label];
}

-(id) init
{
	if( (self=[super init] )) {
		
		CGSize mapSize;
		
		self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"MasterMapT.tmx"];
		self.background = [_tileMap layerNamed:@"Board"];
		self.isTouchEnabled = YES;
		self.tileMap.position = ccp(0,0);
		[self addChild: _tileMap];
		
		PinchZoomLayer *pZoom = [PinchZoomLayer initPinchZoom:self.tileMap];
		
//		gameHUD = [GameHUD sharedHUD];
		
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end
