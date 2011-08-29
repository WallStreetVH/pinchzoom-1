//
//  TutorialLayer.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

// Import the interfaces
#import "StatsScene.h"
#import "StatsScene2.h"
#import "StatsScene3.h"
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
@implementation Stats

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
	Stats *layer = [Stats node];
	
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
		
		CCSprite *page2 = [CCSprite spriteWithFile:@"Page2.png"];
		page2.position = ccp(295,375);
		[self addChild:page2];
		
		CCSprite *page3 = [CCSprite spriteWithFile:@"Page3.png"];
		page3.position = ccp(295,325);
		[self addChild:page3];
		
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
					
					CCLabelAtlas *labelLoc1 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc2 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc3 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc4 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc5 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc6 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc7 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc8 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc9 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc10 = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc11= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc12= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc13= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc14= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc15= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc16= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc17= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc18= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc19= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc20= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc21= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc22= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc23= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc24= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc25= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc26= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc27= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc28= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc29= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc30= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc31= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc32= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc33= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc34= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc35= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc36= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc37= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc38= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc39= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc40= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					CCLabelAtlas *labelLoc41= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				//	CCLabelAtlas *labelLoc42= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
				//	CCLabelAtlas *labelLoc43= [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
					
					
					
					
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
					if([animal.nameit2 isEqualToString:@"F1"]){	 
						NSString *str6 = [[NSString alloc] initWithFormat:@"F1X:%@ F1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc6 setString:str6];
						[str6 release];
						labelLoc6.position = ccp(5,360);
						[self addChild:labelLoc6 z:2];
					}
					if([animal.nameit2 isEqualToString:@"G1"]){	 
						NSString *str7 = [[NSString alloc] initWithFormat:@"G1X:%@ G1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc7 setString:str7];
						[str7 release];
						labelLoc7.position = ccp(5,350);
						[self addChild:labelLoc7 z:2];
					}
					if([animal.nameit2 isEqualToString:@"H1"]){	 
						NSString *str8 = [[NSString alloc] initWithFormat:@"H1X:%@ H1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc8 setString:str8];
						[str8 release];
						labelLoc8.position = ccp(5,340);
						[self addChild:labelLoc8 z:2];
					}
					if([animal.nameit2 isEqualToString:@"I1"]){	 
						NSString *str9 = [[NSString alloc] initWithFormat:@"I1X:%@ I1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc9 setString:str9];
						[str9 release];
						labelLoc9.position = ccp(5,330);
						[self addChild:labelLoc9 z:2];
					}
					if([animal.nameit2 isEqualToString:@"J1"]){	 
						NSString *str10 = [[NSString alloc] initWithFormat:@"J1X:%@ J1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc10 setString:str10];
						[str10 release];
						labelLoc10.position = ccp(5,320);
						[self addChild:labelLoc10 z:2];
					}
					if([animal.nameit2 isEqualToString:@"K1"]){	 
						NSString *str11 = [[NSString alloc] initWithFormat:@"K1X:%@ K1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc11 setString:str11];
						[str11 release];
						labelLoc11.position = ccp(5,310);
						[self addChild:labelLoc11 z:2];
					}
					if([animal.nameit2 isEqualToString:@"L1"]){	 
						NSString *str12 = [[NSString alloc] initWithFormat:@"L1X:%@ L1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc12 setString:str12];
						[str12 release];
						labelLoc12.position = ccp(5,300);
						[self addChild:labelLoc12 z:2];
					}
					if([animal.nameit2 isEqualToString:@"M1"]){	 
						NSString *str13 = [[NSString alloc] initWithFormat:@"M1X:%@ M1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc13 setString:str13];
						[str13 release];
						labelLoc13.position = ccp(5,290);
						[self addChild:labelLoc13 z:2];
					}
					if([animal.nameit2 isEqualToString:@"N1"]){	 
						NSString *str14 = [[NSString alloc] initWithFormat:@"N1X:%@ N1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc14 setString:str14];
						[str14 release];
						labelLoc14.position = ccp(5,280);
						[self addChild:labelLoc14 z:2];
					}
					if([animal.nameit2 isEqualToString:@"O1"]){	 
						NSString *str15 = [[NSString alloc] initWithFormat:@"O1X:%@ O1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc15 setString:str15];
						[str15 release];
						labelLoc15.position = ccp(5,270);
						[self addChild:labelLoc15 z:2];
					}
					if([animal.nameit2 isEqualToString:@"P1"]){	 
						NSString *str16 = [[NSString alloc] initWithFormat:@"P1X:%@ P1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc16 setString:str16];
						[str16 release];
						labelLoc16.position = ccp(5,260);
						[self addChild:labelLoc16 z:2];
					}
					if([animal.nameit2 isEqualToString:@"Q1"]){	 
						NSString *str17 = [[NSString alloc] initWithFormat:@"Q1X:%@ Q1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc17 setString:str17];
						[str17 release];
						labelLoc17.position = ccp(5,250);
						[self addChild:labelLoc17 z:2];
					}
					if([animal.nameit2 isEqualToString:@"R1"]){	 
						NSString *str18 = [[NSString alloc] initWithFormat:@"R1X:%@ R1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc18 setString:str18];
						[str18 release];
						labelLoc18.position = ccp(5,240);
						[self addChild:labelLoc18 z:2];
					}
					if([animal.nameit2 isEqualToString:@"S1"]){	 
						NSString *str19 = [[NSString alloc] initWithFormat:@"S1X:%@ S1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc19 setString:str19];
						[str19 release];
						labelLoc19.position = ccp(5,230);
						[self addChild:labelLoc19 z:2];
					}
					if([animal.nameit2 isEqualToString:@"T1"]){	 
						NSString *str20 = [[NSString alloc] initWithFormat:@"T1X:%@ T1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc20 setString:str20];
						[str20 release];
						labelLoc20.position = ccp(5,220);
						[self addChild:labelLoc20 z:2];
					}
					if([animal.nameit2 isEqualToString:@"U1"]){	 
						NSString *str21 = [[NSString alloc] initWithFormat:@"U1X:%@ U1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc21 setString:str21];
						[str21 release];
						labelLoc21.position = ccp(5,210);
						[self addChild:labelLoc21 z:2];
					}
					if([animal.nameit2 isEqualToString:@"V1"]){	 
						NSString *str22 = [[NSString alloc] initWithFormat:@"V1X:%@ V1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc22 setString:str22];
						[str22 release];
						labelLoc22.position = ccp(5,200);
						[self addChild:labelLoc22 z:2];
					}
					if([animal.nameit2 isEqualToString:@"W1"]){	 
						NSString *str23 = [[NSString alloc] initWithFormat:@"W1X:%@ W1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc23 setString:str23];
						[str23 release];
						labelLoc23.position = ccp(5,190);
						[self addChild:labelLoc23 z:2];
					}
					if([animal.nameit2 isEqualToString:@"X1"]){	 
						NSString *str24 = [[NSString alloc] initWithFormat:@"X1X:%@ X1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc24 setString:str24];
						[str24 release];
						labelLoc24.position = ccp(5,180);
						[self addChild:labelLoc24 z:2];
					}
					if([animal.nameit2 isEqualToString:@"Y1"]){	 
						NSString *str25 = [[NSString alloc] initWithFormat:@"Y1X:%@ Y1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc25 setString:str25];
						[str25 release];
						labelLoc25.position = ccp(5,170);
						[self addChild:labelLoc25 z:2];
					}
					if([animal.nameit2 isEqualToString:@"Z1"]){	 
						NSString *str26 = [[NSString alloc] initWithFormat:@"Z1X:%@ Z1Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc26 setString:str26];
						[str26 release];
						labelLoc26.position = ccp(5,160);
						[self addChild:labelLoc26 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A2"]){	 
						NSString *str27 = [[NSString alloc] initWithFormat:@"A2X:%@ A2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc27 setString:str27];
						[str27 release];
						labelLoc27.position = ccp(5,150);
						[self addChild:labelLoc27 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A3"]){	 
						NSString *str28 = [[NSString alloc] initWithFormat:@"A3X:%@ A3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc28 setString:str28];
						[str28 release];
						labelLoc28.position = ccp(5,140);
						[self addChild:labelLoc28 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A4"]){	 
						NSString *str29 = [[NSString alloc] initWithFormat:@"A4X:%@ A4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc29 setString:str29];
						[str29 release];
						labelLoc29.position = ccp(5,130);
						[self addChild:labelLoc29 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A5"]){	 
						NSString *str30 = [[NSString alloc] initWithFormat:@"A5X:%@ A5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc30 setString:str30];
						[str30 release];
						labelLoc30.position = ccp(5,120);
						[self addChild:labelLoc30 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A6"]){	 
						NSString *str31 = [[NSString alloc] initWithFormat:@"A6X:%@ A6Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc31 setString:str31];
						[str31 release];
						labelLoc31.position = ccp(5,110);
						[self addChild:labelLoc31 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A7"]){	 
						NSString *str32 = [[NSString alloc] initWithFormat:@"A7X:%@ A7Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc32 setString:str32];
						[str32 release];
						labelLoc32.position = ccp(5,100);
						[self addChild:labelLoc32 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A8"]){	 
						NSString *str33 = [[NSString alloc] initWithFormat:@"A8X:%@ A8Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc33 setString:str33];
						[str33 release];
						labelLoc33.position = ccp(5,90);
						[self addChild:labelLoc33 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"A9"]){	 
						NSString *str34 = [[NSString alloc] initWithFormat:@"A9X:%@ A9Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc34 setString:str34];
						[str34 release];
						labelLoc34.position = ccp(5,80);
						[self addChild:labelLoc34 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"B2"]){	 
						NSString *str35 = [[NSString alloc] initWithFormat:@"B2X:%@ B2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc35 setString:str35];
						[str35 release];
						labelLoc35.position = ccp(5,70);
						[self addChild:labelLoc35 z:2];
					}
					
					if([animal.nameit2 isEqualToString:@"C2"]){	 
						NSString *str36 = [[NSString alloc] initWithFormat:@"C2X:%@ C2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc36 setString:str36];
						[str36 release];
						labelLoc36.position = ccp(5,60);
						[self addChild:labelLoc36 z:2];
					}
					if([animal.nameit2 isEqualToString:@"D2"]){	 
						NSString *str37 = [[NSString alloc] initWithFormat:@"D2X:%@ D2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc37 setString:str37];
						[str37 release];
						labelLoc37.position = ccp(5,50);
						[self addChild:labelLoc37 z:2];
					}
					if([animal.nameit2 isEqualToString:@"D3"]){	 
						NSString *str38 = [[NSString alloc] initWithFormat:@"D3X:%@ D3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc38 setString:str38];
						[str38 release];
						labelLoc38.position = ccp(5,40);
						[self addChild:labelLoc38 z:2];
					}
					if([animal.nameit2 isEqualToString:@"D4"]){	 
						NSString *str39 = [[NSString alloc] initWithFormat:@"D4X:%@ D4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc39 setString:str39];
						[str39 release];
						labelLoc39.position = ccp(5,30);
						[self addChild:labelLoc39 z:2];
					}
					if([animal.nameit2 isEqualToString:@"E2"]){	 
						NSString *str40 = [[NSString alloc] initWithFormat:@"E2X:%@ E2Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc40 setString:str40];
						[str40 release];
						labelLoc40.position = ccp(5,20);
						[self addChild:labelLoc40 z:2];
					}
					if([animal.nameit2 isEqualToString:@"D2"]){	 
						NSString *str41 = [[NSString alloc] initWithFormat:@"E3X:%@ E3Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc41 setString:str41];
						[str41 release];
						labelLoc41.position = ccp(5,10);
						[self addChild:labelLoc41 z:2];
					}
			/*		if([animal.nameit2 isEqualToString:@"D2"]){	 
						NSString *str42 = [[NSString alloc] initWithFormat:@"E4X:%@ E4Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc42 setString:str42];
						[str42 release];
						labelLoc42.position = ccp(5,0);
						[self addChild:labelLoc42 z:2];
					}
					if([animal.nameit2 isEqualToString:@"D2"]){	 
						NSString *str43 = [[NSString alloc] initWithFormat:@"E5X:%@ E5Y:%@ U:%@",animal.tileLocX, animal.tileLocY, animal.used];
						[labelLoc43 setString:str43];
						[str43 release];
						labelLoc43.position = ccp(5,-10);
						[self addChild:labelLoc43 z:2];
					}
					
					*/
					
					[animal release];
					
				}
				
			}
			CCLabelAtlas *pageNo = [[CCLabelAtlas labelAtlasWithString:@"" charMapFile:@"selfFont.png" itemWidth:11 itemHeight:11 startCharMap:'.'] retain];
			
			NSString *str100 = [[NSString alloc] initWithFormat:@"PAGE 1"];
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
				
				// Add the animal object to the animals Array
			//	NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
				
				Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused];
				
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
	//	[[CCDirector sharedDirector] popScene];
	}
	
	if ((pos2.x > 280) & (pos2.x < 405) & (pos2.y > 350) & (pos2.y < 394)) {
		[[CCDirector sharedDirector] replaceScene: [CCShrinkGrowTransition transitionWithDuration:1.0f scene:[Stats2 scene]]];
	}
	
	if ((pos2.x > 280) & (pos2.x < 405) & (pos2.y > 295) & (pos2.y < 345)) {
		[[CCDirector sharedDirector] replaceScene: [CCShrinkGrowTransition transitionWithDuration:1.0f scene:[Stats3 scene]]];
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
