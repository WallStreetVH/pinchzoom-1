//
//  TutorialLayer.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

// Import the interfaces
#import "StatsScene3.h"
#import "StatsScene2.h"
#import "StatsScene.h"
#import "GameHUD.h"
#import "PinchZoomLayer.h"
#import "WorldMap.h"
//#import "Sprite.h"
#import "DataModel.h"
#import "TutorialScene.h"
#import "Animal.h"


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
						

// Tutorial implementation
@implementation Stats3

@synthesize tileMap = _tileMap2;
@synthesize background = _background;
@synthesize wordMain;
@synthesize A;



@synthesize currentLevel = _currentLevel;
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Stats3 *layer = [Stats3 node];
	
	// add layer as a child to scene
	[scene addChild: layer z:1];
	
//	GameHUD * myGameHUD = [GameHUD sharedHUD];
//	[scene removeChild:myGameHUD cleanup:YES];
//	[scene addChild:myGameHUD z:1];
	
	DataModel *m = [DataModel getModel];
	m._gameLayer = layer;
//	m._gameHUDLayer = myGameHUD;
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init {
	
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	
	if((self = [super init])) {				
		
	//	CGSize mapSize;
		
/*		self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"TileMap.tmx"];
		self.background = [_tileMap2 layerNamed:@"Background"];
		self.isTouchEnabled = YES;
		self.tileMap.position = ccp(0,0);
	//	[self addChild: _tileMap z:0];
		[self addChild: _tileMap2];
*/
		self.isTouchEnabled = YES;
		bg = [CCSprite spriteWithFile:@"StatsScreen.png"];
        //[bg setAnchorPoint:ccp(0,0)];
		[bg setPosition:ccp(160,170)];
        [self addChild:bg z:0];
		
		
		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background2 = [CCSprite spriteWithFile:@"hudMed.png"];
        background2.anchorPoint = ccp(0,0);
		background2.position = ccp(0,0);
   //     [self addChild:background2];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
		
		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background3 = [CCSprite spriteWithFile:@"smallHud.png"];
        background3.anchorPoint = ccp(0,0);
		background3.position = ccp(-2,440);
        [self addChild:background3];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
		
		CCSprite *undoButton = [CCSprite spriteWithFile:@"undo2.png"];
		undoButton.position = ccp(295,415);
		[self addChild:undoButton];
		
		CCSprite *page1 = [CCSprite spriteWithFile:@"Page1.png"];
		page1.position = ccp(295,375);
		[self addChild:page1];

		
		CCSprite *page2 = [CCSprite spriteWithFile:@"Page2.png"];
		page2.position = ccp(295,325);
		[self addChild:page2];
		
	//	[self setLabels];
		
/*		// create and initialize a CCLabel
		CCLabel* label2 = [CCLabel labelWithString:@"This is my line of text." fontName:@"ITCAvantGardeStd-Bold.otf" fontSize:16];
		label2.anchorPoint = ccp(0,0);
		label2.position =  ccp(20,200);
		[self addChild:label2 z:2];
*/
	//	CCLabel* label2 = [CCLabel labelWithString:@"This is my line of text." fontName:@"ITCAvantGardeStd-Bold.otf" fontSize:16];
	//	CCLabel * label = [CCLabel labelWithString:@"TEXT" dimensions:CGSizeMake(x, y) alignment:UITextAlignmentCenter fontName:@"" fontSize:];
 	    
	//	CCLabel *label2 = [CCLabel  labelWithString:@"Tile A1 is located: " dimensions:CGSizeMake(200.0f, 35.0f) alignment:UITextAlignmentLeft fontName:@"Courier New" fontSize:12];
	//	label2.anchorPoint = ccp(0,0);
	//	label2.position =  ccp(20,200);
	//	label2.color = ccc3(0, 0, 0);
	//	[self addChild:label2 z:2];
		
		PinchZoomLayer *pZoom = [PinchZoomLayer initPinchZoom:bg];
				
	//	self.currentLevel = 0;
		
//		ind = @"OFF";
//		self.wordMain=@"";
     //   wordPre = @"";
	//	wordOver = @"";
		
		
		//Get the tile location data
	//	DataModel *m = [DataModel getModel];		
		//[m._gameHUDLayer displayDatabase];
		
	//	[self setLabels];
		
		//	Retrieve the database
		databaseName = @"tileLocations.rdb";
		
		
		// Get the path to the documents directory and append the databaseName
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
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
			NSString *finalPhrase = [NSString stringWithFormat:@"'%@'",[phrase substringWithRange:NSMakeRange(1,10)]];
			
			//NSString *phrase = @"'2011-03-12'";	
			//	int *gidTemp = 16;
			
			// Setup the SQL Statement and compile it for faster access		
			// const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc where gidNo =  %i",gidTemp] UTF8String];
			const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc"] UTF8String];
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement2, -1, &compiledStatement, NULL) == SQLITE_OK) {
				
				// Loop through the results and add them to the feeds array
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
				
				// L A B E L S
					
				{
					// Read the data from the result row
					NSString *aSerial = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					NSString *atileDesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
					NSString *atileLocAsString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
					NSString *atileLocX = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
					NSString *atileLocY = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
					NSString *achronOrder = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
					NSString *aused = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
					NSString *afileName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
					
					// Add the animal object to the animals Array
					//	NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
					
					Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused fileName:afileName];
					
					[animals addObject:animal];
					
					//	[animal release];
					
					
					CCLabelAtlas *labelLoc42 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc43 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc44 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc45 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc46 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc47 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc48 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc49 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc50 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc51 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc52= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc53= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc54= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc55= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc56= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc57= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				
		/*			CCLabelAtlas *labelLoc58= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc59= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain]
					CCLabelAtlas *labelLoc60= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc61= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc62= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc63= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc64= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc65= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc66= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc67= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc68= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc69= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc70= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc71= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc72= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc73= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc74= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc75= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc76= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc77= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc78= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc79= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc80= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc81= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc82= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc83= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc84= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				*/	
					
				/*	NSString *str100 = [[NSString alloc] initWithFormat:@"PAGE 3"];
					[pageNo setString:str100];
					[str100 release];
					pageNo.position = ccp(195,230);
					[self addChild:pageNo z:2];
					*/
					
					if([animal.nameit2 isEqualToString:@"R5"]){
						NSString *str1 = [[NSString alloc] initWithFormat:@"R5X:%@ R5Y:%@ U:%@", animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc42 setString:str1];
						[str1 release];
						labelLoc42.position = ccp(5,410);
						[self addChild:labelLoc42 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"R6"]){
						NSString *str2 = [[NSString alloc] initWithFormat:@"R6X:%@ R6Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc43 setString:str2];
						[str2 release];
						labelLoc43.position = ccp(5,400);
						[self addChild:labelLoc43 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"S2"]){
						NSString *str3 = [[NSString alloc] initWithFormat:@"S2X:%@ S2Y:%@ U:%@",animal.tileLocX, animal.tileLocY,animal.used];
						[labelLoc44 setString:str3];
						[str3 release];
						labelLoc44.position = ccp(5,390);
						[self addChild:labelLoc44 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"S3"]){
						NSString *str4 = [[NSString alloc] initWithFormat:@"S3X:%@ S3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc45 setString:str4];
						[str4 release];
						labelLoc45.position = ccp(5,380);
						[self addChild:labelLoc45 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"S4"]){	 
						NSString *str5 = [[NSString alloc] initWithFormat:@"S4X:%@ S4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc46 setString:str5];
						[str5 release];
						labelLoc46.position = ccp(5,370);
						[self addChild:labelLoc46 z:2];
					}
					if([animal.nameit2 isEqualToString:@"T2"]){	 
						NSString *str6 = [[NSString alloc] initWithFormat:@"T2X:%@ T2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc47 setString:str6];
						[str6 release];
						labelLoc47.position = ccp(5,360);
						[self addChild:labelLoc47 z:2];
					}
					if([animal.nameit2 isEqualToString:@"T3"]){	 
						NSString *str7 = [[NSString alloc] initWithFormat:@"T3X:%@ T3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc48 setString:str7];
						[str7 release];
						labelLoc48.position = ccp(5,350);
						[self addChild:labelLoc48 z:2];
					}
					if([animal.nameit2 isEqualToString:@"T4"]){	 
						NSString *str8 = [[NSString alloc] initWithFormat:@"T4X:%@ T4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc49 setString:str8];
						[str8 release];
						labelLoc49.position = ccp(5,340);
						[self addChild:labelLoc49 z:2];
					}
					if([animal.nameit2 isEqualToString:@"T5"]){	 
						NSString *str9 = [[NSString alloc] initWithFormat:@"T5X:%@ T5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc50 setString:str9];
						[str9 release];
						labelLoc50.position = ccp(5,330);
						[self addChild:labelLoc50 z:2];
					}
					if([animal.nameit2 isEqualToString:@"T6"]){	 
						NSString *str10 = [[NSString alloc] initWithFormat:@"T6X:%@ T6Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc51 setString:str10];
						[str10 release];
						labelLoc51.position = ccp(5,320);
						[self addChild:labelLoc51 z:2];
					}
					if([animal.nameit2 isEqualToString:@"U2"]){	 
						NSString *str11 = [[NSString alloc] initWithFormat:@"U2X:%@ U2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc52 setString:str11];
						[str11 release];
						labelLoc52.position = ccp(5,310);
						[self addChild:labelLoc52 z:2];
					}
					if([animal.nameit2 isEqualToString:@"U3"]){	 
						NSString *str12 = [[NSString alloc] initWithFormat:@"U3X:%@ U3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc53 setString:str12];
						[str12 release];
						labelLoc53.position = ccp(5,300);
						[self addChild:labelLoc53 z:2];
					}
					if([animal.nameit2 isEqualToString:@"U4"]){	 
						NSString *str13 = [[NSString alloc] initWithFormat:@"U4X:%@ U4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc54 setString:str13];
						[str13 release];
						labelLoc54.position = ccp(5,290);
						[self addChild:labelLoc54 z:2];
					}
					if([animal.nameit2 isEqualToString:@"V2"]){	 
						NSString *str14 = [[NSString alloc] initWithFormat:@"V2X:%@ V2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc55 setString:str14];
						[str14 release];
						labelLoc55.position = ccp(5,280);
						[self addChild:labelLoc55 z:2];
					}
					if([animal.nameit2 isEqualToString:@"W2"]){	 
						NSString *str15 = [[NSString alloc] initWithFormat:@"W2X:%@ W2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc56 setString:str15];
						[str15 release];
						labelLoc56.position = ccp(5,270);
						[self addChild:labelLoc56 z:2];
					}
					if([animal.nameit2 isEqualToString:@"Y2"]){	 
						NSString *str16 = [[NSString alloc] initWithFormat:@"Y2X:%@ Y2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc57 setString:str16];
						[str16 release];
						labelLoc57.position = ccp(5,260);
						[self addChild:labelLoc57 z:2];
					}
		/*			if([animal.nameit2 isEqualToString:@"I5"]){	 
						NSString *str17 = [[NSString alloc] initWithFormat:@"I5X:%@ I5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc58 setString:str17];
						[str17 release];
						labelLoc58.position = ccp(5,250);
						[self addChild:labelLoc58 z:2];
					}
					if([animal.nameit2 isEqualToString:@"I6"]){	 
						NSString *str18 = [[NSString alloc] initWithFormat:@"I6X:%@ I6Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc59 setString:str18];
						[str18 release];
						labelLoc59.position = ccp(5,240);
						[self addChild:labelLoc59 z:2];
					}
					if([animal.nameit2 isEqualToString:@"I7"]){	 
						NSString *str19 = [[NSString alloc] initWithFormat:@"I7X:%@ I7Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc60 setString:str19];
						[str19 release];
						labelLoc60.position = ccp(5,230);
						[self addChild:labelLoc60 z:2];
					}
					if([animal.nameit2 isEqualToString:@"I8"]){	 
						NSString *str20 = [[NSString alloc] initWithFormat:@"I8X:%@ I8Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc61 setString:str20];
						[str20 release];
						labelLoc61.position = ccp(5,220);
						[self addChild:labelLoc61 z:2];
					}
					if([animal.nameit2 isEqualToString:@"I9"]){	 
						NSString *str21 = [[NSString alloc] initWithFormat:@"I9X:%@ I9Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc62 setString:str21];
						[str21 release];
						labelLoc62.position = ccp(5,210);
						[self addChild:labelLoc62 z:2];
					}
					if([animal.nameit2 isEqualToString:@"L2"]){	 
						NSString *str22 = [[NSString alloc] initWithFormat:@"L2X:%@ L2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc63 setString:str22];
						[str22 release];
						labelLoc63.position = ccp(5,200);
						[self addChild:labelLoc63 z:2];
					}
					if([animal.nameit2 isEqualToString:@"L3"]){	 
						NSString *str23 = [[NSString alloc] initWithFormat:@"L3X:%@ L3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc64 setString:str23];
						[str23 release];
						labelLoc64.position = ccp(5,190);
						[self addChild:labelLoc64 z:2];
					}
					if([animal.nameit2 isEqualToString:@"L4"]){	 
						NSString *str24 = [[NSString alloc] initWithFormat:@"L4X:%@ L4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc65 setString:str24];
						[str24 release];
						labelLoc65.position = ccp(5,180);
						[self addChild:labelLoc65 z:2];
					}
					if([animal.nameit2 isEqualToString:@"M2"]){	 
						NSString *str25 = [[NSString alloc] initWithFormat:@"M2X:%@ M2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc66 setString:str25];
						[str25 release];
						labelLoc66.position = ccp(5,170);
						[self addChild:labelLoc66 z:2];
					}
					if([animal.nameit2 isEqualToString:@"N2"]){	 
						NSString *str26 = [[NSString alloc] initWithFormat:@"N2X:%@ N2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc67 setString:str26];
						[str26 release];
						labelLoc67.position = ccp(5,160);
						[self addChild:labelLoc67 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"N3"]){	 
						NSString *str27 = [[NSString alloc] initWithFormat:@"N3X:%@ N3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc68 setString:str27];
						[str27 release];
						labelLoc68.position = ccp(5,150);
						[self addChild:labelLoc68 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"N4"]){	 
						NSString *str28 = [[NSString alloc] initWithFormat:@"N4X:%@ N4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc69 setString:str28];
						[str28 release];
						labelLoc69.position = ccp(5,140);
						[self addChild:labelLoc69 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"N5"]){	 
						NSString *str29 = [[NSString alloc] initWithFormat:@"N5X:%@ N5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc70 setString:str29];
						[str29 release];
						labelLoc70.position = ccp(5,130);
						[self addChild:labelLoc70 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"N6"]){	 
						NSString *str30 = [[NSString alloc] initWithFormat:@"N6X:%@ N6Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc71 setString:str30];
						[str30 release];
						labelLoc71.position = ccp(5,120);
						[self addChild:labelLoc71 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"O2"]){	 
						NSString *str31 = [[NSString alloc] initWithFormat:@"O2X:%@ O2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc72 setString:str31];
						[str31 release];
						labelLoc72.position = ccp(5,110);
						[self addChild:labelLoc72 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"O3"]){	 
						NSString *str32 = [[NSString alloc] initWithFormat:@"O3X:%@ O3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc73 setString:str32];
						[str32 release];
						labelLoc73.position = ccp(5,100);
						[self addChild:labelLoc73 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"O4"]){	 
						NSString *str33 = [[NSString alloc] initWithFormat:@"O4X:%@ O4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc74 setString:str33];
						[str33 release];
						labelLoc74.position = ccp(5,90);
						[self addChild:labelLoc74 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"O5"]){	 
						NSString *str34 = [[NSString alloc] initWithFormat:@"O5X:%@ O5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc75 setString:str34];
						[str34 release];
						labelLoc75.position = ccp(5,80);
						[self addChild:labelLoc75 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"O6"]){	 
						NSString *str35 = [[NSString alloc] initWithFormat:@"O6X:%@ O6Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc76 setString:str35];
						[str35 release];
						labelLoc76.position = ccp(5,70);
						[self addChild:labelLoc76 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"O7"]){	 
						NSString *str36 = [[NSString alloc] initWithFormat:@"O7X:%@ O7Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc77 setString:str36];
						[str36 release];
						labelLoc77.position = ccp(5,60);
						[self addChild:labelLoc77 z:2];
					}
					if([animal.nameit2 isEqualToString:@"O8"]){	 
						NSString *str37 = [[NSString alloc] initWithFormat:@"O8X:%@ O8Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc78 setString:str37];
						[str37 release];
						labelLoc78.position = ccp(5,50);
						[self addChild:labelLoc78 z:2];
					}
					if([animal.nameit2 isEqualToString:@"P2"]){	 
						NSString *str38 = [[NSString alloc] initWithFormat:@"P2X:%@ P2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc79 setString:str38];
						[str38 release];
						labelLoc79.position = ccp(5,40);
						[self addChild:labelLoc79 z:2];
					}
					if([animal.nameit2 isEqualToString:@"R2"]){	 
						NSString *str39 = [[NSString alloc] initWithFormat:@"R2X:%@ R2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc80 setString:str39];
						[str39 release];
						labelLoc80.position = ccp(5,30);
						[self addChild:labelLoc80 z:2];
					}
					if([animal.nameit2 isEqualToString:@"R3"]){	 
						NSString *str40 = [[NSString alloc] initWithFormat:@"R3X:%@ R3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc81 setString:str40];
						[str40 release];
						labelLoc81.position = ccp(5,20);
						[self addChild:labelLoc81 z:2];
					}
					if([animal.nameit2 isEqualToString:@"R4"]){	 
						NSString *str41 = [[NSString alloc] initWithFormat:@"R4X:%@ R4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc82 setString:str41];
						[str41 release];
						labelLoc82.position = ccp(5,10);
						[self addChild:labelLoc82 z:2];
					}
				/*	if([animal.nameit2 isEqualToString:@"D2"]){	 
						NSString *str42 = [[NSString alloc] initWithFormat:@"E4X:%@ E4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc83 setString:str42];
						[str42 release];
						labelLoc83.position = ccp(5,0);
						[self addChild:labelLoc83 z:2];
					}
					if([animal.nameit2 isEqualToString:@"D2"]){	 
						NSString *str43 = [[NSString alloc] initWithFormat:@"E5X:%@ E5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc84 setString:str43];
						[str43 release];
						labelLoc84.position = ccp(5,-10);
						[self addChild:labelLoc84 z:2];
					}
					
					*/
									}
				
			}
			
			CCLabelAtlas *pageNo = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
			
			NSString *str100 = [[NSString alloc] initWithFormat:@"PAGE 3"];
			[pageNo setString:str100];
			[str100 release];
			pageNo.position = ccp(5,425);
			[self addChild:pageNo z:2];
			
			
			
			NSString *err = SQLITE_ERROR;
			// Release the compiled statement from memory
			sqlite3_finalize(compiledStatement);
			
		}
		sqlite3_close(database);
		return self;	
		
	
		
    }
}

- (void) setLabels {
	//	Retrieve the database
	databaseName = @"tileLocations.rdb";
	
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
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
		NSString *finalPhrase = [NSString stringWithFormat:@"'%@'",[phrase substringWithRange:NSMakeRange(1,10)]];
		
		//NSString *phrase = @"'2011-03-12'";	
		//	int *gidTemp = 16;
		
		// Setup the SQL Statement and compile it for faster access		
		// const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc where gidNo =  %i",gidTemp] UTF8String];
		const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc"] UTF8String];
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
				
				// Add the animal object to the animals Array
			//	NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
				
				Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused fileName:afileName];
				
				[animals addObject:animal];
				
			//	[animal release];
				
				CCLabelAtlas *labelLoc1 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				CCLabelAtlas *labelLoc2 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				CCLabelAtlas *labelLoc3 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				CCLabelAtlas *labelLoc4 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				CCLabelAtlas *labelLoc5 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				
				
				if([animal.nameit2 isEqualToString:@"A1"]){
					NSString *str1 = [[NSString alloc] initWithFormat:@"A1X:%@ A1Y:%@ U:%@", animal.tileLocX, animal.tileLocY, animal.used];
					[labelLoc1 setString:str1];
					[str1 release];
					labelLoc1.position = ccp(5,410);
					[self addChild:labelLoc1 z:2];
				}
				
				if([animal.nameit2 isEqualToString:@"B1"]){
					NSString *str2 = [[NSString alloc] initWithFormat:@"B1X:%@ B1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
					[labelLoc2 setString:str2];
					[str2 release];
					labelLoc2.position = ccp(5,400);
					[self addChild:labelLoc2 z:2];
				}
				
				if([animal.nameit2 isEqualToString:@"C1"]){
					NSString *str3 = [[NSString alloc] initWithFormat:@"C1X:%@ C1Y:%@ U:%@",animal.tileLocX, animal.tileLocY,animal.used];
					[labelLoc3 setString:str3];
					[str3 release];
					labelLoc3.position = ccp(5,390);
					[self addChild:labelLoc3 z:2];
				}
				
				if([animal.nameit2 isEqualToString:@"D1"]){
					NSString *str4 = [[NSString alloc] initWithFormat:@"D1X:%@ D1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
					[labelLoc4 setString:str4];
					[str4 release];
					labelLoc4.position = ccp(5,380);
					[self addChild:labelLoc4 z:2];
				}
				
				if([animal.nameit2 isEqualToString:@"E1"]){	 
					NSString *str5 = [[NSString alloc] initWithFormat:@"E1X:%@ E1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
					[labelLoc5 setString:str5];
					[str5 release];
					labelLoc5.position = ccp(5,370);
					[self addChild:labelLoc5 z:2];
				}
			//	else {
			//		return self;
			//	}

				
				[animal release];
				
			}
		}
		NSString *err = SQLITE_ERROR;
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	return self;	
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {  
	
//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
   
//	if (target = [CCSprite spriteWithFile:@"MachineGunTurret.png"]){
//	[self removeChild:target cleanup:YES];
//	}
	
	self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"MasterMapT.tmx"];
	self.background = [_tileMap2 layerNamed:@"Board"];
	CCTMXLayer *layer = [_tileMap2 layerNamed:@"MasterAlpha"];
	
	
	DataModel *m = [DataModel getModel];
//	[m._gameHUDLayer removeChild:[self myGameHUD] cleanup:YES];
	
	CGPoint pos2 = [self convertTouchToNodeSpace:touch];
	
	if ((pos2.x > 280) & (pos2.x < 405) & (pos2.y > 400)) {
		[[CCDirector sharedDirector] replaceScene: [CCShrinkGrowTransition transitionWithDuration:1.0f scene:[Tutorial scene]]];
		//[[CCDirector sharedDirector] popScene];
	}
	
	if ((pos2.x > 280) & (pos2.x < 405) & (pos2.y > 350) & (pos2.y < 394)) {
		[[CCDirector sharedDirector] replaceScene: [CCShrinkGrowTransition transitionWithDuration:1.0f scene:[Stats scene]]];
	}
	if ((pos2.x > 280) & (pos2.x < 405) & (pos2.y > 320) & (pos2.y < 349)) {
		[[CCDirector sharedDirector] replaceScene: [CCShrinkGrowTransition transitionWithDuration:1.0f scene:[Stats2 scene]]];
	}
	
	//targettowerX = towerLoc.x;
	//targettowerY = towerLoc.y;
	//[self registerLoc];
	
	//int tileGid = [self.background tileGIDAt:ccp(towerLoc.x,towerLoc.y)];
		
//	CGPoint tLoc = [self tileCoordForPosition:];
	
	CGPoint towerLock = [self tileCoordForPosition:pos2];

	//DataModel *m = [DataModel getModel];
	
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
		//	[self addChild:selSpriteRange z:-1];
			selSpriteRange.position = sprite.position;
			
            newSprite = [CCSprite spriteWithTexture:[sprite texture]]; //sprite;
			newSprite.position = sprite.position;
			selSprite = newSprite;
		//	[self addChild:newSprite];
			
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
	
	return NO;
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
	if([type isEqualToString: @"1"]) {
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
		
		//mtCopy = targetMain;
		
		//target.position = ccp((towerLoc.x * 32) + 16, self.tileMap.contentSize.height - (towerLoc.y * 32) - 16);
	//	[self addChild:targetTower z:1];
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
		
		[self setCenterOfScreen:targetTower.position];
		
		CGPoint tilePos = targetTower.position;
		CGPoint diff = ccpSub(touchLocation, tilePos);
		
		//move horizontal or vertical
		if (abs(diff.x) > abs(diff.y)) {
			if (diff.x > 0) {
				tilePos.x += _tileMap2.tileSize.width;
			}else{
				tilePos.x -= _tileMap2.tileSize.width;
			}
		}else{
			if (diff.y > 0) {
				tilePos.y += _tileMap2.tileSize.height;
			}else{
				tilePos.y -= _tileMap2.tileSize.height;
			}
		}
		
		//make sure the new position isn't off the map
		if (tilePos.x <= (_tileMap2.mapSize.width * _tileMap2.tileSize.width) &&
			tilePos.y <= (_tileMap2.mapSize.height * _tileMap2.tileSize.height) &&
			tilePos.y >= 0 &&
			tilePos.x >= 0 )
		{
			[self setPlayerPosition:tilePos];
		}
		
		[self setCenterOfScreen:targetTower.position];
		CGPoint towerLoc = [self tileCoordForPosition: pos];
		//gidNo = 120;
		[[_tileMap2 layerNamed:@"Board"] setTileGID:gidNo at:ccp(towerLoc.x,towerLoc.y)];//A
		
		NSDictionary *props = [_tileMap2 propertiesForGID:gidNo];
		NSString *type = [props valueForKey:@"letter"];
		
	//	[m._gameHUDLayer updateDatabase1];
		
		if([type isEqualToString: @"1"]) {
			return YES;
		}
		
		
	} else {
		NSLog(@"Tile Not Buildable");
	}
	
	//[wordMain appendString:currentLetter];
	
}

-(void) setPlayerPosition:(CGPoint)position{
	targetTower.position = position;
}

-(void) setCenterOfScreen:(CGPoint) position{
	CGSize screenSize = [[CCDirector sharedDirector]winSize];
	
	int x = MAX(position.x, screenSize.width/2);
	int y = MAX(position.y, screenSize.height/2);
	
	x = MIN(x, _tileMap2.mapSize.width * _tileMap2.tileSize.width - screenSize.width/2);
	y = MIN(y, _tileMap2.mapSize.height * _tileMap2.tileSize.height - screenSize.height/2);
	
	CGPoint goodPoint = ccp(x,y);
	
	CGPoint centerOfScreen = ccp(screenSize.width/2, screenSize.height/2);
	CGPoint difference = ccpSub(centerOfScreen, goodPoint);
	self.position = difference;
	
}

-(void)getPoints{
	
	if (targetMain == @"A1.png"){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"A";
			}
	if (targetMain == @"B3.png"){
		points1 = 3;
		totalPoints = totalPoints + points1;
		currentLetter = @"B";
		
	}
	if (targetMain == @"C3.png"){
		points1 = 3;
		totalPoints = totalPoints + points1;
		currentLetter = @"C";
		
	}
	if (targetMain == @"T1.png"){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"T";
		
	}
	if (targetMain == @"I1.png"){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"I";
		}
	if (targetMain == @"J8.png"){
		points1 = 8;
		totalPoints = totalPoints + points1;
		currentLetter = @"J";
	}
	if (targetMain == @"E1.png"){
		points1 = 1;
		totalPoints = totalPoints + points1;
		currentLetter = @"E";
	}
	
	
	
	if ([ind isEqualToString:@"OFF"])
		self.wordMain = @"";
	
	self.wordMain = [self.wordMain stringByAppendingString:currentLetter];
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
	
	//[self addChild:target z:1];
	
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
    retval.x = MAX(retval.x, -_tileMap2.contentSize.width+winSize.width); 
    retval.y = MIN(0, retval.y);
    retval.y = MAX(-_tileMap2.contentSize.height+winSize.height, retval.y); 
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
