//
//  TutorialLayer.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

// Import the interfaces
#import "TutorialScene.h"
#import "GameHUD.h"
#import "PinchZoomLayer.h"
#import "WorldMap.h"
#import "Animal.h"

#import "DataModel.h"

NSMutableArray * movableSprites;
CCSprite * background;
extern NSString *target1, *target2, *target3, *target4, *target5, *target6, *target7;
extern 	Tower *targetTower, *targetTower1, *targetTower2, *targetTower3, *targetTower4, *targetTower5, *targetTower6, *targetTower7;
Tower *lastTowerMoved;
extern int totalPoints, points1, points2, points3, points4 ,points5, points6, points7;
NSString *wordPre, *wordOver;
NSString *currentLetter;
//NSString *letter1,*letter2,*letter3,*letter4,*letter5,*letter6,*letter7;
//extern NSString *wordMain;
NSString *ind;
extern int tx, ty;
extern int targettowerX, targettowerY;
extern int targettower1X, targettower1Y, targettower2X, targettower2Y, targettower3X, targettower3Y,targettower4X, targettower4Y,targettower5X, targettower5Y,targettower6X, targettower6Y,targettower7X, targettower7Y;;
extern int Mtargettower1X, Mtargettower1Y, Mtargettower2X, Mtargettower2Y, Mtargettower3X, Mtargettower3Y,Mtargettower4X, Mtargettower4Y,Mtargettower5X, Mtargettower5Y,Mtargettower6X, Mtargettower6Y,Mtargettower7X, Mtargettower7Y;
CCSprite * newSprite;
NSString *targetMain;
extern NSString * mtCopy;
CGPoint touchLocation, tileLocation, towerLoc;
CGPoint towerLock;
extern NSString * fileName;
NSString *recallFlag;						


// Tutorial implementation
@implementation Tutorial

@synthesize tileMap = _tileMap;
@synthesize tileMap2 = _tileMap2;
@synthesize background = _background;
//@synthesize wordMain;
@synthesize A;



@synthesize currentLevel = _currentLevel;
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Tutorial *layer = [Tutorial node];
	
	// add layer as a child to scene
//	[scene removeChild:layer cleanup:YES];
	[scene addChild: layer z:1];
	
	GameHUD * myGameHUD = [GameHUD sharedHUD];
	
	[scene addChild:myGameHUD z:2];
	//[scene removeChild:myGameHUD cleanup:YES];
	
	DataModel *m = [DataModel getModel];
	m._gameLayer = layer;
	m._gameHUDLayer = myGameHUD;
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init {
    
//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
	
	if((self = [super init])) {				
		
		CGSize mapSize;
		
		self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"MasterMapT.tmx"];
		self.background = [_tileMap layerNamed:@"Board"];
		self.isTouchEnabled = YES;
		self.tileMap.position = ccp(0,0);
	//	[self addChild: _tileMap z:0];
		[self removeChild:_tileMap cleanup:YES];
		[self addChild: _tileMap];
		
		PinchZoomLayer *pZoom = [PinchZoomLayer initPinchZoom:self.tileMap];
		
		//[pZoom scaleToFit];
		
		
	
//		CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"Letters"];
//		NSMutableDictionary *A = [objects objectNamed:@"A"];
//		NSMutableDictionary *B = [objects objectNamed:@"B"];
		
		
/*		self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"MasterMapT.tmx"];
		self.background = [_tileMap layerNamed:@"Board"];
		
		self.isTouchEnabled = YES;
		
		// had to do this because the tilemap is > than the iPhone screen size
		mapSize = _tileMap.contentSize; 
		
		// create a base layer
		CCColorLayer *base = [CCColorLayer layerWithColor:ccc4(139,139,139,255)];
	//	base.position = ccp(0,0);
		base.contentSize = mapSize;
		[base addChild:_tileMap];
		
		[self addChild: base z:0];
		
	//	self.anchorPoint = CGPointZero;
	//	base.anchorPoint = CGPointZero;
	//	_tileMap.anchorPoint = CGPointZero;
		
		// attach base layer to PinchZoomLayer
		PinchZoomLayer *pZoom = [PinchZoomLayer initPinchZoom:base];
		
		// zoom out all the way
	//	[pZoom scaleToFit];			
	 
	*/	
	//	[self addWaypoint];
	//	[self addWaves];
		
		// Call game logic about every second
    //    [self schedule:@selector(update:)];
	//	[self schedule:@selector(gameLogic:) interval:1.0];	
		
		self.currentLevel = 0;
		
	//	self.position = ccp(-228, -122);
		
	//	[self setCenterOfScreen:ccp(350,350)];
			
	//	gameHUD = [GameHUD sharedHUD];
		
	//	[self getUsed];
		
		ind = @"OFF";
	//	self.wordMain=@"";
        wordPre = @"";
		wordOver = @"";
    }
    return self;
}
-(void) getUsed {
	//	Retrieve the database
	databaseName = @"tileLocations.rdb";
	
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//	NSString *documentsDir = [documentPaths objectAtIndex:0];
	//	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	databasePath = [[NSBundle mainBundle] pathForResource:@"tileLocations" ofType:@"rdb"];	
	// Setup the database object
	
	sqlite3 *database;
	
	// Init the animals Array
	animals = [[NSMutableArray alloc] init];
	
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		
		//	Get the user's events for today's date
		NSDate *now = [NSDate date];
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		NSString *phrase = [NSString stringWithFormat:@"'%@'",now];
		//	NSString *finalPhrase = [NSString stringWithFormat:@"'%@'",[phrase substringWithRange:NSMakeRange(1,10)]];
		NSString *tSerial = @"";
		//NSString *phrase = @"'2011-03-12'";	
		//	int *gidTemp = 16;
		
		// Setup the SQL Statement and compile it for faster access		
		const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc where used = 'Y'"] UTF8String];
		//const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc"] UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement2, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aSerial = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *atileDesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *atileLocAsString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *atileLocX = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *atileLocY = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *achronOrder = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *aused = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				NSString *afileName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
				
				//	serialNo = aSerial;
				fileName = afileName;
				tSerial = aSerial;
			//	int theX = atileLocX;
			//	int theY = atileLocY;
				
				int theX = [atileLocX intValue];
				int theY = [atileLocY intValue];
				int theSerial = [aSerial intValue];
				
				Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused fileName:afileName];
				
				// Add the animal object to the animals Array
				NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
				
				// if recallFlag <> "ON" then add the tile	
					
				if (![recallFlag isEqualToString:@"ON"]){
			//	[[_tileMap layerNamed:@"Board"] setTileGID:theSerial at:ccp(theX,theY)];
				} else {
					
				//	[self removeChild:_tileMap cleanup:NO];
					
				//	[self addChild:_tileMap];
					

					//	[[_tileMap layerNamed:@"Board"] removeTileAt:ccp(2,14)];
					//[[_tileMap layerNamed:@"Board"] setTileGID:12 at:ccp(theX,theY)];
						//recallFlag = @"OFF";
					}
				[animals addObject:animal];
				
				[animal release];
			}
		}
		NSString *err = SQLITE_ERROR;
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
	//NSString *location = animals.description;
	
	
	//}
	return self;
	
    
	
	
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {  
	NSLog(@"In Tutorial TouchBegan");
//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
   
//	if (target = [CCSprite spriteWithFile:@"MachineGunTurret.png"]){
//	[self removeChild:target cleanup:YES];
//	}
	
	self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"MasterMapT.tmx"];
	self.background = [_tileMap layerNamed:@"Board"];
	CCTMXLayer *layer = [_tileMap layerNamed:@"MasterAlpha"];
	
	
	CGPoint pos2 = [self convertTouchToNodeSpace:touch];
	
	//targettowerX = towerLoc.x;
	//targettowerY = towerLoc.y;
	//[self registerLoc];
	
	//int tileGid = [self.background tileGIDAt:ccp(towerLoc.x,towerLoc.y)];
		
//	CGPoint tLoc = [self tileCoordForPosition:];
	
	CGPoint towerLock = [self tileCoordForPosition:pos2];

	DataModel *m = [DataModel getModel];
	
//	CGPoint touchLocationInGameLayer = [m._gameLayer convertTouchToNodeSpace:touch];
//	towerLock = [self tileCoordForPosition: touchLocationInGameLayer];
	unsigned int gid2 = [self.background tileGIDAt:towerLock];
//	CCSprite *tile = [self.background tileAt:towerLock];
	
//	NSDictionary *props = [_tileMap propertiesForGID:gid2];
//	NSString *type = [props valueForKey:@"letter"];
	
//	if([type isEqualToString: @"1"]) {
//		return YES;
//	}
	
	
	CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {  
			DataModel *m = [DataModel getModel];
			m._gestureRecognizer.enabled = NO;
			
			
			selSpriteRange = [CCSprite spriteWithFile:@"A1.png"];
			selSpriteRange.scale = 4;
			[self removeChild:selSpriteRange cleanup:YES];
			[self addChild:selSpriteRange z:-1];
			selSpriteRange.position = sprite.position;
			
            newSprite = [CCSprite spriteWithTexture:[sprite texture]]; //sprite;
			newSprite.position = sprite.position;
			selSprite = newSprite;
			[self removeChild:newSprite cleanup:YES];
			[self addChild:newSprite];
			
            break;
        }
    }     
	return YES;
}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {  
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
	
	if (selSprite) {
		CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
		selSpriteRange.position = newPos;
		
		DataModel *m = [DataModel getModel];
		CGPoint touchLocationInGameLayer = [m._gameLayer convertTouchToNodeSpace:touch];
		
		BOOL isBuildable = [m._gameLayer canBuildOnTilePosition: touchLocationInGameLayer];
		if (isBuildable) {
			selSprite.opacity = 200;
		} else {
			selSprite.opacity = 50;		
		}
	}
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {  
	
	//self.isTouchEnabled = NO;
	
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];	
	DataModel *m = [DataModel getModel];
	
	if (selSprite) {
		CGRect backgroundRect = CGRectMake(background.position.x, 
										   background.position.y, 
										   background.contentSize.width, 
										   background.contentSize.height);
		
		if (!CGRectContainsPoint(backgroundRect, touchLocation)) {
			CGPoint touchLocationInGameLayer = [m._gameLayer convertTouchToNodeSpace:touch];
			[m._gameLayer addTower: touchLocationInGameLayer];
		}
		
		[self removeChild:selSprite cleanup:YES];
		selSprite = nil;		
		[self removeChild:selSpriteRange cleanup:YES];
		selSpriteRange = nil;			
	}

//	[[CCTouchDispatcher sharedDispatcher] setDispatchEvents:NO];
//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
	
//	sleep(1000);
//	[m._gameHUDLayer cancelMove];
		
}
- (void) registerWithTouchDispatcher
{
	//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}


-(void)addWaves {
	DataModel *m = [DataModel getModel];
	
	Wave *wave = nil;
	wave = [[Wave alloc] initWithCreep:[FastRedCreep creep] SpawnRate:0.3 TotalCreeps:50];
	[m._waves addObject:wave];
	wave = nil;
	wave = [[Wave alloc] initWithCreep:[StrongGreenCreep creep] SpawnRate:1.0 TotalCreeps:5];
	[m._waves addObject:wave];
	wave = nil;	
}

- (Wave *)getCurrentWave{
	
	DataModel *m = [DataModel getModel];	
	Wave * wave = (Wave *) [m._waves objectAtIndex:self.currentLevel];
	
	return wave;
}

- (Wave *)getNextWave{
	
	DataModel *m = [DataModel getModel];
	
	self.currentLevel++;
	
	if (self.currentLevel > 1)
		self.currentLevel = 0;
	
	 Wave * wave = (Wave *) [m._waves objectAtIndex:self.currentLevel];
	 
	 return wave;
}

-(void)addWaypoint {
	DataModel *m = [DataModel getModel];
	
	CCTMXObjectGroup *objects = [self.tileMap objectGroupNamed:@"Objects"];
	WayPoint *wp = nil;
	
	int wayPointCounter = 0;
	NSMutableDictionary *wayPoint;
	while ((wayPoint = [objects objectNamed:[NSString stringWithFormat:@"Waypoint%d", wayPointCounter]])) {
		int x = [[wayPoint valueForKey:@"x"] intValue];
		int y = [[wayPoint valueForKey:@"y"] intValue];
		
		wp = [WayPoint node];
		wp.position = ccp(x, y);
		[m._waypoints addObject:wp];
		wayPointCounter++;
	}
	
	NSAssert([m._waypoints count] > 0, @"Waypoint objects missing");
	wp = nil;
}

- (CGPoint) tileCoordForPosition:(CGPoint) position 
{
	int x = position.x / self.tileMap.tileSize.width;
	int y = ((self.tileMap.mapSize.height * self.tileMap.tileSize.height) - position.y) / self.tileMap.tileSize.height;
	
	return ccp(x,y);
}

- (BOOL) canBuildOnTilePosition:(CGPoint) pos 
{
	CGPoint towerLoc = [self tileCoordForPosition: pos];
	
	int tileGid = [self.background tileGIDAt:towerLoc];
	NSDictionary *props = [self.tileMap propertiesForGID:tileGid];
	NSString *type = [props valueForKey:@"buildable"];
	
	if([type isEqualToString: @"1"]) {
		return YES;
	}
	
	return YES;// changed from NO to force buildability
}

-(void)addTower: (CGPoint)pos {
	DataModel *m = [DataModel getModel];
	
//	Tower *targetTower = nil;
	//tileLocation 
	
	towerLoc = [self tileCoordForPosition: pos];
	
	targettowerX = towerLoc.x;
	targettowerY = towerLoc.y;
	//[self registerLoc];
	
	int tileGid = [self.background tileGIDAt:towerLoc];
	NSDictionary *props = [self.tileMap propertiesForGID:tileGid];
	NSString *type = [props valueForKey:@"buildable"];
	
/*	// To obtain a tile (CCSprite) at a certain coordinate
	CCTMXLayer *layer = [self.tileMap layerNamed:@"Board"];
	CCSprite *tile = [layer tileAt:ccp(towerLoc.x,towerLoc.y)];
	NSString *tileName = targetTower1;
	unsigned int gid = [layer tileGIDAt:ccp(towerLoc.x,towerLoc.y)];
	[layer removeTileAt:ccp(towerLoc.x, towerLoc.y)];
	
	CGSize s = [layer layerSize];
	for( int x=0; x<s.width;x++) {
		for( int y=0; y< s.height; y++ ) {
			unsigned int tmpgid = [layer tileGIDAt:ccp(x,y)];
			[layer setTileGID:tmpgid+1 at:ccp(x,y)];
		}
	}*/
	NSLog(@"Buildable: %@", type);
//	if([type isEqualToString: @"1"]) {
	//	target = @"B3.png";
		mtCopy = targetMain;
		if ((targetMain = target1)){
			targetTower1 = [MachineGunTower tower:targetMain];
			targetTower1.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower1;
			lastTowerMoved = targetTower1;
			targettower1X = targettowerX;
			targettower1Y = targettowerY;
			[self getPoints];
		//	[self checkLoc];
		//	[self registerLoc];
		}
		if ((targetMain = target2)){
			targetTower2 = [MachineGunTower tower:targetMain];
			targetTower2.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower2;
			lastTowerMoved = targetTower2;
			targettower2X = targettowerX;
			targettower2Y = targettowerY;
			[self getPoints];
		//	[self checkLoc];
		//	[self registerLoc];
		}
		if ((targetMain = target3)){
			targetTower3 = [MachineGunTower tower:targetMain];
			targetTower3.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower3;
			lastTowerMoved = targetTower3;
			targettower3X = targettowerX;
			targettower3Y = targettowerY;
			[self getPoints];
					}
		if ((targetMain = target4)){
			targetTower4 = [MachineGunTower tower:targetMain];
			targetTower4.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower4;
			lastTowerMoved = targetTower4;
			targettower4X = targettowerX;
			targettower4Y = targettowerY;
			[self getPoints];
			
		}
		if ((targetMain = target5)){
			targetTower5 = [MachineGunTower tower:targetMain];
			targetTower5.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower5;
			lastTowerMoved = targetTower5;
			targettower5X = targettowerX;
			targettower5Y = targettowerY;
			[self getPoints];
			
		}
		if ((targetMain = target6)){
			targetTower6 = [MachineGunTower tower:targetMain];
			targetTower6.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower6;
			lastTowerMoved = targetTower6;
			targettower6X = targettowerX;
			targettower6Y = targettowerY;
			[self getPoints];
			
		}
		if ((targetMain = target7)){
			targetTower7 = [MachineGunTower tower:targetMain];
			targetTower7.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
			targetTower = targetTower7;
			lastTowerMoved = targetTower7;
			targettower7X = targettowerX;
			targettower7Y = targettowerY;
			[self getPoints];
					}
		
	//	mtCopy = targetMain;
		
		//target.position = ccp((towerLoc.x * 32) + 16, self.tileMap.contentSize.height - (towerLoc.y * 32) - 16);
		[self addChild:targetTower z:1];
		//A = [CCSprite spriteWithFile:@"A1.png"];
		//A.position = ccp(100,100);
		
		int gidNo = 0;
		
		if ([mtCopy isEqualToString:@"A1.png"])
				gidNo = 19;
	    if ([mtCopy isEqualToString:@"B3.png"])
				gidNo = 20;
		if ([mtCopy isEqualToString:@"C3.png"])
			gidNo = 21;
		if ([mtCopy isEqualToString:@"D2.png"])
			gidNo = 22;
		if ([mtCopy isEqualToString:@"E1.png"])
			gidNo = 23;
		if ([mtCopy isEqualToString:@"F4.png"])
			gidNo = 25;
		if ([mtCopy isEqualToString:@"G2.png"])
			gidNo = 26;
		if ([mtCopy isEqualToString:@"H4.png"])
			gidNo = 27;
		if ([mtCopy isEqualToString:@"I1.png"])
			gidNo = 28;
		if ([mtCopy isEqualToString:@"J8.png"])
			gidNo = 29;
		if ([mtCopy isEqualToString:@"K5.png"])
			gidNo = 30;
		if ([mtCopy isEqualToString:@"L1.png"])
			gidNo = 31;
		if ([mtCopy isEqualToString:@"N2.png"])
			gidNo = 33;
		if ([mtCopy isEqualToString:@"O1.png"])
			gidNo = 34;
		if ([mtCopy isEqualToString:@"P3.png"])
			gidNo = 35;
		if ([mtCopy isEqualToString:@"Q10.png"])
			gidNo = 36;
		if ([mtCopy isEqualToString:@"R1.png"])
			gidNo = 37;
		if ([mtCopy isEqualToString:@"S1.png"])
			gidNo = 38;
		if ([mtCopy isEqualToString:@"T1.png"])
			gidNo = 39;
		if ([mtCopy isEqualToString:@"U1.png"])
			gidNo = 41;
		if ([mtCopy isEqualToString:@"V4.png"])
			gidNo = 42;
		if ([mtCopy isEqualToString:@"W4.png"])
			gidNo = 43;
		if ([mtCopy isEqualToString:@"X8.png"])
			gidNo = 44;
		if ([mtCopy isEqualToString:@"Y4.png"])
			gidNo = 45;
		if ([mtCopy isEqualToString:@"Z10.png"])
			gidNo = 46;
		if ([mtCopy isEqualToString:@"blank.png"])
			gidNo = 47;
		if ([mtCopy isEqualToString:@"M3.png"])
			gidNo = 49;
		
	

	//	unsigned int gid2 = [self.background tileGIDAt:ccp(0,9)];
		
		targetTower.tag = 1;
		[m._towers addObject:targetTower];
	    [self removeChild:targetTower cleanup:YES];
		[self addChild:targetTower];
		
		[self setCenterOfScreen:targetTower.position];
		
		CGPoint tilePos = targetTower.position;
		CGPoint diff = ccpSub(touchLocation, tilePos);
		
		//move horizontal or vertical
		if (abs(diff.x) > abs(diff.y)) {
			if (diff.x > 0) {
				tilePos.x += _tileMap.tileSize.width;
			}else{
				tilePos.x -= _tileMap.tileSize.width;
			}
		}else{
			if (diff.y > 0) {
				tilePos.y += _tileMap.tileSize.height;
			}else{
				tilePos.y -= _tileMap.tileSize.height;
			}
		}
		
		//make sure the new position isn't off the map
		if (tilePos.x <= (_tileMap.mapSize.width * _tileMap.tileSize.width) &&
			tilePos.y <= (_tileMap.mapSize.height * _tileMap.tileSize.height) &&
			tilePos.y >= 0 &&
			tilePos.x >= 0 )
		{
			//[self setPlayerPosition:tilePos];
		}
		
		[self setCenterOfScreen:targetTower.position];
		CGPoint towerLoc = [self tileCoordForPosition: pos];
		//gidNo = 120;
		[[_tileMap layerNamed:@"Board"] setTileGID:gidNo at:ccp(towerLoc.x,towerLoc.y)];//A
	[self removeChild:targetTower1 cleanup:YES];
	//	NSDictionary *props = [_tileMap propertiesForGID:gidNo];
	//	NSString *type = [props valueForKey:@"letter"];
		
		[m._gameHUDLayer updateDatabase1];
		
	//	if([type isEqualToString: @"1"]) {
	//		return YES;
	//	}
		
		
	//} else {
	//	NSLog(@"Tile Not Buildable");
	}
	

//[wordMain appendString:currentLetter];
	


-(void) setPlayerPosition:(CGPoint)position{
	targetTower.position = position;
}

-(void) setCenterOfScreen:(CGPoint) position{
	CGSize screenSize = [[CCDirector sharedDirector]winSize];
	
	int x = MAX(position.x, screenSize.width/2);
	int y = MAX(position.y, screenSize.height/2);
	
	x = MIN(x, _tileMap.mapSize.width * _tileMap.tileSize.width - screenSize.width/2);
	y = MIN(y, _tileMap.mapSize.height * _tileMap.tileSize.height - screenSize.height/2);
	
	CGPoint goodPoint = ccp(x,y);
	
	CGPoint centerOfScreen = ccp(screenSize.width/2, screenSize.height/2);
	CGPoint difference = ccpSub(centerOfScreen, goodPoint);
	self.position = difference;
	
}

-(void)getPoints{
	
	if ([targetMain isEqualToString:@"A1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"A";
			}
	if ([targetMain isEqualToString:@"B3.png"]){
		points1 = 3;
		totalPoints = totalPoints + points1;
		currentLetter = @"B";
		
	}
	if ([targetMain isEqualToString:@"C3.png"]){
		points1 = 3;
		totalPoints = totalPoints + points1;
		currentLetter = @"C";
		
	}
	if ([targetMain isEqualToString:@"D2.png"]){
		points1 = 2;
		totalPoints = totalPoints + points1;
		currentLetter = @"D";
	}
	
	if ([targetMain isEqualToString:@"E1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"E";
	}
	if ([targetMain isEqualToString:@"F4.png"]){
		points1 = 4;
		totalPoints = totalPoints + points1;
		currentLetter = @"F";
	}
	if ([targetMain isEqualToString:@"G2.png"]){
		points1 = 2;
		totalPoints = totalPoints + points1;
		currentLetter = @"G";
	}
	if ([targetMain isEqualToString:@"H4.png"]){
		points1 = 4;
		totalPoints = totalPoints + points1;
		currentLetter = @"H";
	}
	if ([targetMain isEqualToString:@"I1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"I";
		}
	if ([targetMain isEqualToString:@"J8.png"]){
		points1 = 8;
		totalPoints = totalPoints + points1;
		currentLetter = @"J";
	}
	if ([targetMain isEqualToString:@"K5.png"]){
		points1 = 5;
		totalPoints = totalPoints + points1;
		currentLetter = @"K";
	}
	if ([targetMain isEqualToString:@"L1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"L";
	}
	if ([targetMain isEqualToString:@"M3.png"]){
		points1 = 3;
		totalPoints = totalPoints + points1;
		currentLetter = @"M";
	}
	if ([targetMain isEqualToString:@"N2.png"]){
		points1 = 2;
		totalPoints = totalPoints + points1;
		currentLetter = @"N";
	}
	if ([targetMain isEqualToString:@"O1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"O";
	}
	if ([targetMain isEqualToString:@"P3.png"]){
		points1 = 3;
		totalPoints = totalPoints + points1;
		currentLetter = @"P";
	}
	if ([targetMain isEqualToString:@"Q10.png"]){
		points1 = 10;
		totalPoints = totalPoints + points1;
		currentLetter = @"Q";
	}
	if ([targetMain isEqualToString:@"R1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"R";
	}
	if ([targetMain isEqualToString:@"S1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"S";
	}
	if ([targetMain isEqualToString:@"T1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"T";
	}
	if ([targetMain isEqualToString:@"U1.png"]){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"U";
	}
	if ([targetMain isEqualToString:@"V4.png"]){
		points1 = 4;
		totalPoints = totalPoints + points1;
		currentLetter = @"V";
	}
	if ([targetMain isEqualToString:@"W4.png"]){
		points1 = 4;
		totalPoints = totalPoints + points1;
		currentLetter = @"W";
	}
	if ([targetMain isEqualToString:@"X8.png"]){
		points1 = 8;
		totalPoints = totalPoints + points1;
		currentLetter = @"X";
	}
	if ([targetMain isEqualToString:@"Y4.png"]){
		points1 = 4;
		totalPoints = totalPoints + points1;
		currentLetter = @"Y";
	}
	if ([targetMain isEqualToString:@"Z10.png"]){
		points1 = 10;
		totalPoints = totalPoints + points1;
		currentLetter = @"Z";
	}

	
	
	
	if ([ind isEqualToString:@"OFF"])
	//	self.wordMain = @"";
	
	
//	self.wordMain = [self.wordMain stringByAppendingString:currentLetter];
	ind = @"ON";
	
}

/*-(void)removeTower: (CGPoint)pos {
	DataModel *m = [DataModel getModel];
	
	Tower *target = nil;
	
	CGPoint towerLoc = [self tileCoordForPosition: pos];
	
	int tileGid = [self.background tileGIDAt:towerLoc];
	NSDictionary *props = [self.tileMap propertiesForGID:tileGid];
	NSString *type = [props valueForKey:@"buildable"];
	
	
	NSLog(@"Buildable: %@", type);
	if([type isEqualToString: @"1"]) {
		target = [MachineGunTower tower];
		
		target.position = ccp((towerLoc.x * 44) + 24, self.tileMap.contentSize.height - (towerLoc.y * 44) - 24);
		//target.position = ccp((towerLoc.x * 32) + 16, self.tileMap.contentSize.height - (towerLoc.y * 32) - 16);
		[self removeChild:target cleanup:YES];
		
		target.tag = 1;
		[m._towers removeObject:target];
		
	} else {
		NSLog(@"Tile Not Buildable");
	}
	
}*/

-(void)addTarget {
    
	DataModel *m = [DataModel getModel];
	Wave * wave = [self getCurrentWave];
	if (wave.totalCreeps < 0) {
		return; //[self getNextWave];
	}
	
	wave.totalCreeps--;
	
    Creep *target = nil;
    if ((arc4random() % 2) == 0) {
        target = [FastRedCreep creep];
    } else {
        target = [StrongGreenCreep creep];
    }	
	
	WayPoint *waypoint = [target getCurrentWaypoint ];
	target.position = waypoint.position;	
	waypoint = [target getNextWaypoint ];
	
	[self addChild:target z:1];
	
	int moveDuration = target.moveDuration;	
	id actionMove = [CCMoveTo actionWithDuration:moveDuration position:waypoint.position];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	// Add to targets array
	target.tag = 1;
	[m._targets addObject:target];
	
}

-(void)FollowPath:(id)sender {
    
	Creep *creep = (Creep *)sender;
	
	WayPoint * waypoint = [creep getNextWaypoint];

	int moveDuration = creep.moveDuration;
	id actionMove = [CCMoveTo actionWithDuration:moveDuration position:waypoint.position];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
	[creep stopAllActions];
	[creep runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

/*-(void)gameLogic:(ccTime)dt {
	
	DataModel *m = [DataModel getModel];
	Wave * wave = [self getCurrentWave];
	static double lastTimeTargetAdded = 0;
    double now = [[NSDate date] timeIntervalSince1970];
   if(lastTimeTargetAdded == 0 || now - lastTimeTargetAdded >= wave.spawnRate) {
        [self addTarget];
        lastTimeTargetAdded = now;
    }
	
}

- (void)update:(ccTime)dt {
    
	DataModel *m = [DataModel getModel];
	NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];

	for (Projectile *projectile in m._projectiles) {
		
		CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), 
										   projectile.position.y - (projectile.contentSize.height/2), 
										   projectile.contentSize.width, 
										   projectile.contentSize.height);
        
		NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
		
		for (CCSprite *target in m._targets) {
			CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
										   target.position.y - (target.contentSize.height/2), 
										   target.contentSize.width, 
										   target.contentSize.height);
            
			if (CGRectIntersectsRect(projectileRect, targetRect)) {
                
				[projectilesToDelete addObject:projectile];
				
                Creep *creep = (Creep *)target;
                creep.hp--;
				
                if (creep.hp <= 0) {
                    [targetsToDelete addObject:target];
                }
                break;
                
			}						
		}
		
		for (CCSprite *target in targetsToDelete) {
			[m._targets removeObject:target];
			[self removeChild:target cleanup:YES];									
		}
		
		[targetsToDelete release];
	}
	
	for (CCSprite *projectile in projectilesToDelete) {
		[m._projectiles removeObject:projectile];
		[self removeChild:projectile cleanup:YES];
	}
	[projectilesToDelete release];
}*/


- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -_tileMap.contentSize.width+winSize.width); 
    retval.y = MIN(0, retval.y);
    retval.y = MAX(-_tileMap.contentSize.height+winSize.height, retval.y); 
    return retval;
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {    
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];                
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {    
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];  
        [recognizer setTranslation:CGPointZero inView:recognizer.view];    
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
               
		float scrollDuration = 0.2;
		CGPoint velocity = [recognizer velocityInView:recognizer.view];
		CGPoint newPos = ccpAdd(self.position, ccpMult(ccp(velocity.x, velocity.y * -1), scrollDuration));
		newPos = [self boundLayerPos:newPos];

		[self stopAllActions];
		CCMoveTo *moveTo = [CCMoveTo actionWithDuration:scrollDuration position:newPos];            
		[self runAction:[CCEaseOut actionWithAction:moveTo rate:1]];            
        
    }        
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}

@end
