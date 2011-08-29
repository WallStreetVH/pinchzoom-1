//
//  GameHUD.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "GameHUD.h"
#import "DataModel.h"
#import "Tower.h"
#import "TutorialScene.h"
//#import "TowerDefenseTutorialAppDelegate.h"
#import "AppDelegate.h"
#import "Animal.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "WorldMap.h"
#import "tilesList.h"
#import "StatsScene.h"
#import "StatsScene3.h"
#import "PinchZoomLayer.h"

//#import <sqlite3.h>

extern NSMutableArray * movableSprites;
extern CCSprite * background;
extern NSString *targetMain; 
NSString *target1, *target2, *target3, *target4, *target5, *target6, *target7;
Tower *targetTower, *targetTower1, *targetTower2, *targetTower3, *targetTower4, *targetTower5, *targetTower6, *targetTower7;
NSMutableArray * imagesMast;

extern Tower *lastTowerMoved;
int totalPoints, points1, points2, points3, points4 ,points5, points6, points7;
NSString *ind; 
//NSString *wordMain;
int tx, ty;
int mposition;
int targettowerX, targettowerY;
int targettower1X, targettower1Y, targettower2X, targettower2Y,targettower3X, targettower4Y,targettower4X, targettower5Y,targettower5X, targettower6Y,targettower6X, targettower3Y,targettower7X, targettower7Y;
int Mtargettower1X, Mtargettower1Y, Mtargettower2X, Mtargettower2Y,Mtargettower3X, Mtargettower3Y, Mtargettower4X, Mtargettower4Y,Mtargettower5X, Mtargettower5Y,Mtargettower6X, Mtargettower6Y,Mtargettower7X, Mtargettower7Y;;
extern  CCSprite * newSprite;
int mtotalpoints;
NSString * mtCopy;
int orig1x, orig1y, orig2x,orig2y, orig3x, orig3y, orig4x, orig4y, orig5x, orig5y, orig6x, orig6y, orig7x, orig7y;
extern CGPoint towerLoc;
int chronTemp, letterCount;
NSString *serialTemp1, *serialTemp2, *serialTemp3, *serialTemp4, *serialTemp5, *serialTemp6, *serialTemp7;
NSString *serialNo, *serialM1,*serialM2,*serialM3,*serialM4,*serialM5,*serialM6,*serialM7;
NSString *fileName;
extern NSString *recallFlag;
extern NSString *currentLetter;
//NSString *wordMain;

@implementation GameHUD

CCSprite * spriteMain;
CCSprite * spriteMain2,* spriteMain3,* spriteMain4,* spriteMain5,* spriteMain6,* spriteMain7;

@synthesize animals, window, tilesController;

static GameHUD *_sharedHUD = nil;

+ (GameHUD *)sharedHUD
{
	@synchronized([GameHUD class])
	{
		if (!_sharedHUD)
			[[self alloc] init];
		return _sharedHUD;
	}
	// to avoid compiler warning
	return nil;
}

+(id)alloc
{
	@synchronized([GameHUD class])
	{
		NSAssert(_sharedHUD == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedHUD = [super alloc];
		return _sharedHUD;
	}
	// to avoid compiler warning
	return nil;
}

-(id) init
{
	if ((self=[super init]) ) {
		
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		targetMain = nil;		
		mposition = 0;
		letterCount = 99;
		
		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"hudMed.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];

		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background2 = [CCSprite spriteWithFile:@"hudMed.png"];
        background2.anchorPoint = ccp(0,0);
		background2.position = ccp(0,55);
        [self addChild:background2];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
		
		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background3 = [CCSprite spriteWithFile:@"smallHud.png"];
        background3.anchorPoint = ccp(0,0);
		background3.position = ccp(-2,440);
        [self addChild:background3];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
		
		
	 	[self setMainTiles];
		
		[self getUsed];
		
	//	[self updateDatabase1];
		
	//	[self displayDatabase];
	
     		CCSprite *moveBoard = [CCSprite spriteWithFile:@"moveTheBoard.png"];
	    	moveBoard.position = ccp(27,27);
			[self addChild:moveBoard];
	    	CCSprite *cancelMove = [CCSprite spriteWithFile:@"cancel.png"];
	    	cancelMove.position = ccp(72,27);
		   [self addChild:cancelMove];
		    CCSprite *showStats = [CCSprite spriteWithFile:@"showStats.png"];
		    showStats.position = ccp(117,27);
			[self addChild:showStats]; 
		    //add Submit button
			CCSprite *submitButton = [CCSprite spriteWithFile:@"Submit.png"];
			submitButton.position = ccp(297,27);
			[self addChild:submitButton];
			CCSprite *newLetters = [CCSprite spriteWithFile:@"newLetters.png"];
			newLetters.position = ccp(162,27);
			[self addChild:newLetters];
			CCSprite *undoButton = [CCSprite spriteWithFile:@"undo.png"];
			undoButton.position = ccp(207,27);
			[self addChild:undoButton];
		    CCSprite *undoLLButton = [CCSprite spriteWithFile:@"undoLastLetter.png"];
		    undoLLButton.position = ccp(252,27);
			[self addChild:undoLLButton];

		
	//	label = [CCLabelAtlas alloc] initWithString:@"0" charMapFile:@"scoreboard.png" itemWidth:95 itemHeight:35 ;
	//	label.position = ccp(0,35);
	//	[self addChild:label];
		// get the background image for the state of the element
		// position it appropriately and draw the image
/*		UIImage *backgroundImage = [UIImage imageNamed:[NSString stringWithFormat:@"scoreboard.png"]];
		CGRect elementSymbolRectangle = CGRectMake(0,0,[backgroundImage size].width, [backgroundImage size].height);
		[backgroundImage drawInRect:elementSymbolRectangle];
		
		// all the text is drawn in white
		[[UIColor redColor] set];

		
		// draw the score
		NSString *score1 = @"101";
		UIFont *font = [UIFont boldSystemFontOfSize:12];
		CGSize stringSize = [score1 sizeWithFont:font];
		CGPoint point = ccp(0,0);
        [score1 drawAtPoint:point withFont:font];
*/		
	//	DataModel *m = [DataModel getModel];
		
		//[m._gameLayer runAction:[ actionWithDuration:0.3 scale:1.0]];
		
		DataModel *m = [DataModel getModel];
		m._gestureRecognizer.enabled = YES;	
		
		serialTemp1 = @"";
		serialTemp2 = @"";
		serialTemp3 = @"";
		serialTemp4 = @"";
		serialTemp5 = @"";
		serialTemp6 = @"";
		serialTemp7 = @"";

		NSLog(@"In GameHUD init");
		[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	}
	return self;
}

- (void) showStats {
	
	
	//[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
	
	//DataModel *m = [DataModel getModel];
	//[scene removeChild:myGameHUD cleanup:YES];

	[[CCDirector sharedDirector] replaceScene: [CCSplitRowsTransition transitionWithDuration:1.0f scene:[Stats scene]]];
 
}

- (void) setMultipleTiles {
	CGSize winSize = [CCDirector sharedDirector].winSize;
	
	NSString *image = mtCopy;
	CCSprite *spriteMainT = [CCSprite spriteWithFile:image];
	
	//	[self removeChild:background2 cleanup:YES];
	//	[self addChild:background2];
		
		[self removeChild:spriteMain cleanup:YES];
		[self removeChild:spriteMain2 cleanup:YES];
		[self removeChild:spriteMain3 cleanup:YES];
		[self removeChild:spriteMain4 cleanup:YES];
		[self removeChild:spriteMain5 cleanup:YES];
		[self removeChild:spriteMain6 cleanup:YES];
		[self removeChild:spriteMain7 cleanup:YES];
	
		spriteMain.position = ccp(orig1x,orig1y);
		spriteMain2.position = ccp(orig2x,orig2y);
		spriteMain3.position = ccp(orig3x,orig3y);
		spriteMain4.position = ccp(orig4x,orig4y);
		spriteMain5.position = ccp(orig5x,orig5y);
		spriteMain6.position = ccp(orig6x,orig6y);
		spriteMain7.position = ccp(orig7x,orig7y);
	
	
	//float offsetFraction = ((float)(0+0.5))/(7);
	//spriteMain.position = ccp(winSize.width*offsetFraction,83);
	
	
	[self addChild:spriteMain];
	[self addChild:spriteMain2];
	[self addChild:spriteMain3];
	[self addChild:spriteMain4];
	[self addChild:spriteMain5];
	[self addChild:spriteMain6];
	[self addChild:spriteMain7];
//	[movableSprites addObject:spriteMainT];
	
	
}

- (void) setSingleTile {
	
	CGSize winSize = [CCDirector sharedDirector].winSize;

	NSString *image = mtCopy;
	CCSprite *spriteMainT = [CCSprite spriteWithFile:image];
	if (mposition == 1)
		spriteMainT.position = ccp(orig1x,orig1y);
	if (mposition == 2)
		spriteMainT.position = ccp(orig2x,orig2y);
	if (mposition == 3)
		spriteMainT.position = ccp(orig3x,orig3y);
	if (mposition == 4)
		spriteMainT.position = ccp(orig4x,orig4y);
	if (mposition == 5)
		spriteMainT.position = ccp(orig5x,orig5y);
	if (mposition == 6)
		spriteMainT.position = ccp(orig6x,orig6y);
	if (mposition == 7)
		spriteMainT.position = ccp(orig7x,orig7y);
	 
	
	//float offsetFraction = ((float)(0+0.5))/(7);
	//spriteMain.position = ccp(winSize.width*offsetFraction,83);
	
	
	[self addChild:spriteMainT];
	[movableSprites addObject:spriteMainT];
	
	
}
- (void) setMainTiles {
	
	//CCSprite *spriteMain,*spriteMain2,*spriteMain3,*spriteMain4,*spriteMain5,*spriteMain6,*spriteMain7;

	CGSize winSize = [CCDirector sharedDirector].winSize;
	
	movableSprites = [[NSMutableArray alloc] init];
	// Init the animals Array
	imagesMast = [[NSMutableArray alloc] init];
	//imagesMast = [NSArray arrayWithObjects:@"E1.png", @"I1.png", @"J8.png", @"T1.png", @"B3.png", @"C3.png", @"A1.png", nil];        
	
	
	
	for(int i = 1; i < 8; ++i) 
	{
	[self countOfUnused];
	
	letterCount = [animals count];
	
	chronTemp = arc4random() % letterCount;
	
	
	//[self setUsed];
	[self displaySingle];
		NSString *serialMast = [NSString stringWithFormat:@"serialTemp%i",i];
	    //NSString *serialTast = [NSString stringWithFormat:@"hello"];
		//serialMast = serialMast;
	//	NSLog(@"%@",serialMast);
	
		if ((i==1)){
			serialTemp1 = serialNo;
			serialM1 = serialNo;
		}else if ((i==2)){
			serialTemp2 = serialNo;
			serialM2 = serialNo;
		}else if ((i==3)){
			serialTemp3 = serialNo;
			serialM3 = serialNo;
		}else if ((i==4)){
			serialTemp4 = serialNo;
			serialM4 = serialNo;
		}else if ((i==5)){
			serialTemp5 = serialNo;
			serialM5 = serialNo;
		}else if ((i==6)){
			serialTemp6 = serialNo;
			serialM6 = serialNo;
		}else if ((i==7)){
			serialTemp7 = serialNo;
			serialM7 = serialNo;
		}
		
	//	NSString *fTemp = [NSString stringWithFormat:@"'"@"'",fileName];
	[imagesMast addObject:fileName];
		[self updateDatabase1];
	int num =[imagesMast count];
//	int num2 =[imagesMast count];
	
	}
	
	NSString *image = [imagesMast objectAtIndex:0];
	spriteMain = [CCSprite spriteWithFile:image];
	float offsetFraction = ((float)(0+0.5))/(imagesMast.count);
	spriteMain.position = ccp(winSize.width*offsetFraction,83);
	orig1x = spriteMain.position.x;
	orig1y = spriteMain.position.y;
	[self addChild:spriteMain];
	[movableSprites addObject:spriteMain];
	
	NSString *image2 = [imagesMast objectAtIndex:1];
	spriteMain2 = [CCSprite spriteWithFile:image2];
	offsetFraction = ((float)(1+0.5))/(imagesMast.count);
	spriteMain2.position = ccp(winSize.width*offsetFraction,83);
	orig2x = spriteMain2.position.x;
	orig2y = spriteMain2.position.y;
	[self addChild:spriteMain2];
	[movableSprites addObject:spriteMain2];
	
	NSString *image3 = [imagesMast objectAtIndex:2];
	spriteMain3 = [CCSprite spriteWithFile:image3];
	offsetFraction = ((float)(2+0.5))/(imagesMast.count);
	spriteMain3.position = ccp(winSize.width*offsetFraction,83);
	orig3x = spriteMain3.position.x;
	orig3y = spriteMain3.position.y;
	[self addChild:spriteMain3];
	[movableSprites addObject:spriteMain3];
	
	image = [imagesMast objectAtIndex:3];
	spriteMain4 = [CCSprite spriteWithFile:image];
	offsetFraction = ((float)(3+0.5))/(imagesMast.count);
	spriteMain4.position = ccp(winSize.width*offsetFraction,83);
	orig4x = spriteMain4.position.x;
	orig4y = spriteMain4.position.y;
	[self addChild:spriteMain4];
	[movableSprites addObject:spriteMain4];
	
	image = [imagesMast objectAtIndex:4];
	spriteMain5 = [CCSprite spriteWithFile:image];
	offsetFraction = ((float)(4+0.5))/(imagesMast.count);
	spriteMain5.position = ccp(winSize.width*offsetFraction,83);
	orig5x = spriteMain5.position.x;
	orig5y = spriteMain5.position.y;
	[self addChild:spriteMain5];
	[movableSprites addObject:spriteMain5];
	
	image = [imagesMast objectAtIndex:5];
	spriteMain6 = [CCSprite spriteWithFile:image];
	offsetFraction = ((float)(5+0.5))/(imagesMast.count);
	spriteMain6.position = ccp(winSize.width*offsetFraction,83);
	orig6x = spriteMain6.position.x;
	orig6y = spriteMain6.position.y;
	[self addChild:spriteMain6];
	[movableSprites addObject:spriteMain6];
	
	
	image = [imagesMast objectAtIndex:6];
	spriteMain7 = [CCSprite spriteWithFile:image];
	offsetFraction = ((float)(6+0.5))/(imagesMast.count);
	spriteMain7.position = ccp(winSize.width*offsetFraction,83);
	orig7x = spriteMain7.position.x;
	orig7y = spriteMain7.position.y;
	[self addChild:spriteMain7];
	[movableSprites addObject:spriteMain7];
	
	
}
-(void)tileInfo: (CGPoint)pos {
	
//	CGPoint towerLoc = [self tileCoordForPosition: pos];
//	return;
	
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {  
	
	DataModel *m = [DataModel getModel];
	m._gameLayer.isTouchEnabled = NO;
	 
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
	tx = touchLocation.x;
	ty = touchLocation.y;
	
	CGPoint touchLocationInGameLayer = [m._gameLayer convertTouchToNodeSpace:touch];
//	[m._gameLayer tileInfo: touchLocationInGameLayer];
	
	int touchx = touchLocation.x;
	int touchy = touchLocation.y;	
	
	// move the board button
	if (touchx > 5 & touchx < 49 & touchy < 60){
		[self moveBoard];	
	}

	// cancel move button
	if (touchx > 51 & touchx < 94 & touchy < 60){
		[self cancelMove];	
	}
	// show tile locations (show stats)
	if (touchx > 96 & touchx < 139 & touchy < 60){
		[self showStats];	
	}
	
	// get new letters
	if (touchx > 141 & touchx < 182 & touchy < 60){
		[self removeChild:spriteMain cleanup:YES];
		[self removeChild:spriteMain2 cleanup:YES];
		[self removeChild:spriteMain3 cleanup:YES];
		[self removeChild:spriteMain4 cleanup:YES];
		[self removeChild:spriteMain5 cleanup:YES];
		[self removeChild:spriteMain6 cleanup:YES];
		[self removeChild:spriteMain7 cleanup:YES];
		[self setMainTiles];	
	}
	
	if ((touchx > 280) & (touchx < 405) & (touchy > 400)) {
		[[CCDirector sharedDirector] pushScene:[CCFadeTRTransition transitionWithDuration:1.0f scene:[Tutorial scene]]];
	}
	if ((touchx > 280) & (touchx < 405) & (touchy > 308) & (touchy < 348)) {
		[[CCDirector sharedDirector] pushScene:[CCFadeTRTransition transitionWithDuration:1.0f scene:[Stats3 scene]]];
	}
	
	
	// Recall all button pressed
	
	if (touchx > 185 & touchx < 228 & touchy < 60){
		
		recallFlag = @"ON";
		
		// remove the most recent tiles placed on the board
		
		// do a database lookup of just those with used=Y
		[m._gameLayer getUsed];
		
		[m._gameLayer removeChild:targetTower1 cleanup:YES];
		[m._gameLayer removeChild:targetTower2 cleanup:YES];
		[m._gameLayer removeChild:targetTower3 cleanup:YES];
		[m._gameLayer removeChild:targetTower4 cleanup:YES];
		[m._gameLayer removeChild:targetTower5 cleanup:YES];
		[m._gameLayer removeChild:targetTower6 cleanup:YES];
		[m._gameLayer removeChild:targetTower7 cleanup:YES];
						
		
		// Set original tiles back in place
	//	[self setMultipleTiles];
		
			/*	[self removeChild:spriteMain cleanup:YES];
				[self removeChild:spriteMain2 cleanup:YES];
				[self removeChild:spriteMain3 cleanup:YES];
				[self removeChild:spriteMain4 cleanup:YES];
				[self removeChild:spriteMain5 cleanup:YES];
				[self removeChild:spriteMain6 cleanup:YES];
				[self removeChild:spriteMain7 cleanup:YES];
		
				[self addChild:spriteMain];
				[self addChild:spriteMain2];
				[self addChild:spriteMain3];
				[self addChild:spriteMain4];
				[self addChild:spriteMain5];
				[self addChild:spriteMain6];
				[self addChild:spriteMain7];
		*/
				
		// Clear the letters' targets - make tarGetTower an array
		targetTower1 = nil;
		targetTower2 = nil;
		targetTower3 = nil;
		targetTower4 = nil;
		targetTower5 = nil;
		targetTower6 = nil;
		targetTower7 = nil;
		
		totalPoints = 0;
		ind = @"OFF";
		targettowerX = 0;
		targettowerY = 0;
		targettower1X = 0;
		targettower1Y = 0;
		targettower2X = 0;
		targettower2Y = 0;
		targettower3X = 0;
		targettower3Y = 0;
		targettower4X = 0;
		targettower4Y = 0;
		targettower5X = 0;
		targettower5Y = 0;
		targettower6X = 0;
		targettower6Y = 0;
		targettower7X = 0;
		targettower7Y = 0;
		Mtargettower1X = 0;
		Mtargettower1Y = 0;
		Mtargettower2X = 0;
		Mtargettower2Y = 0;
		Mtargettower3X = 0;
		Mtargettower3Y = 0;
		Mtargettower4X = 0;
		Mtargettower4Y = 0;
		Mtargettower5X = 0;
		Mtargettower5Y = 0;
		Mtargettower6X = 0;
		Mtargettower6Y = 0;
		Mtargettower7X = 0;
		Mtargettower7Y = 0;
		//[[m._gameLayer wordMain] = [m._gameLayer stringWithFormat:@""];
		
		spriteMain = nil;
		spriteMain2= nil;
		spriteMain3= nil;
		spriteMain4= nil;
		spriteMain5= nil;
		spriteMain6= nil;
		spriteMain7= nil;
		
		recallFlag = @"OFF";
		
		//[self getUsed];
		

	}	
	
	// Recall Last Letter button pressed
	if (touchx > 228 & touchx < 272 & touchy < 60){
		[m._gameLayer removeChild:lastTowerMoved cleanup:YES];
		[self setSingleTile];
		//[self addChild:lastTowerMoved];
		//lastTowerMoved = nil;
		[m._gameLayer getUsed];
	}
	
     
	// Submit button pressed
	if (touchx > 265 & touchx < 311 & touchy < 60){
		//int *totalPoints = points1 + points2 + points3;
		
		NSLog(@"In Submit");
		
		
		// check tile combinations looking for nearby tiles
		[self checkWord];

		
		// Database 2 lookup - see if the word is in the main or slang dict

		// Setup some globals
		databaseName = @"slang.rdb";
		
		// Get the path to the documents directory and append the databaseName
	//	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//	NSString *documentsDir = [documentPaths objectAtIndex:0];
	//	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
		databasePath = [[NSBundle mainBundle] pathForResource:@"slang" ofType:@"rdb"];
			
		// Setup the database object
		sqlite3 *database;
		
		// Init the animals Array
		animals = [[NSMutableArray alloc] init];
		
		
		
		NSString *phrase = [m._gameLayer wordMain];
		
		// Open the database from the users filessytem
		if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
			
			// Setup the SQL Statement and compile it for faster access
			//const char *sqlStatement = "select * from maindict";
			const char *sqlStatement = [[NSString stringWithFormat:@"select word from maindict where word = '%@'", phrase] UTF8String];
			
			sqlite3_stmt *compiledStatement;
			
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
				// Loop through the results and add them to the feeds array
				if (sqlite3_step(compiledStatement) == SQLITE_ROW) {
					// Read the data from the result row
					NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
										
					// Create a new animal object with the data from the database
					Animal *animal = [[Animal alloc] nameit:aName];
		
					// Add the animal object to the animals Array
					[animals addObject:animal];
		
					[animal release];					
					NSString *compare = animal.nameit;
					NSString *wordPoints = [NSString stringWithFormat:@"%i", totalPoints];
					NSString *mainHolder = [m._gameLayer wordMain];
					NSString *myMessage = [NSString stringWithFormat:@"%@ \nPoints: %i",[m._gameLayer wordMain],totalPoints];
					UIAlertView *baseAlert = [[UIAlertView alloc] 
											  initWithTitle:@"Word is Approved!" 
											  message:myMessage
											  delegate:self cancelButtonTitle:nil 
											  otherButtonTitles:@"Ok", nil];
					mtotalpoints = mtotalpoints + totalPoints;						
					[baseAlert show];
					
					//play sound
					SystemSoundID pmph;
					id sndpath = [[NSBundle mainBundle] 
								  pathForResource:@"PIRDings" 
								  ofType:@"wav" 
								  inDirectory:@"/"];
					CFURLRef baseURL = (CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
					AudioServicesCreateSystemSoundID (baseURL, &pmph);
					AudioServicesPlaySystemSound(pmph); 
					[baseURL release];
					}else{			
						NSLog(@"SQLite= %d", sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL)); 
						NSString *err = SQLITE_ERROR;
						NSString *myMessage = [NSString stringWithFormat:@"%@ \nNot even Slang!",[m._gameLayer wordMain]];
						UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"No such word" 
										  message:myMessage
										  delegate:self cancelButtonTitle:nil 
										otherButtonTitles:@"Ok", nil];
						[baseAlert show];
						//play sound
						SystemSoundID pmph;
						id sndpath = [[NSBundle mainBundle] 
									  pathForResource:@"PIRLoserSound" 
									  ofType:@"wav" 
									  inDirectory:@"/"];
						CFURLRef baseURL = (CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
						AudioServicesCreateSystemSoundID (baseURL, &pmph);
						AudioServicesPlaySystemSound(pmph); 
						[baseURL release];
						
				return;
				myMessage= @"";
				}
			// Release the compiled statement from memory
			sqlite3_finalize(compiledStatement);
			
		}
		sqlite3_close(database);
		points1 = 0;
		points2 = 0;
		points3 = 0;
		points4 = 0;
		totalPoints = 0;
		ind=@"OFF";
			
	}		
}
	
   // Here's where the letter tiles are moved
	
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {  
			DataModel *m = [DataModel getModel];
			m._gestureRecognizer.enabled = NO;
			
			int touchx = touchLocation.x;
			int touchy = touchLocation.y;
			
			
			    if (touchx < 44 & touchy < 105) {
				target1 = [imagesMast objectAtIndex:0];
				targetMain = target1;
					mposition = 1;
					serialTemp1 = serialM1;
				[self removeChild:spriteMain cleanup:YES];
			}			
			    if (touchx > 46 & touchx < 89 & touchy < 105) { 
			    target2 = [imagesMast objectAtIndex:1];
				targetMain = target2;
					mposition = 2;
					serialTemp2 = serialM2;
				[self removeChild:spriteMain2 cleanup:YES];
			}
			if (touchx > 91 & touchx < 135 & touchy < 105) { 
				target3 = [imagesMast objectAtIndex:2];
				targetMain = target3;			
				mposition = 3;
				serialTemp3 = serialM3;
				[self removeChild:spriteMain3 cleanup:YES];
			}
			if (touchx > 140 & touchx < 182 & touchy < 105) { 
				target4 = [imagesMast objectAtIndex:3];
				targetMain = target4;			
				mposition = 4;
				serialTemp4 = serialM4;
				[self removeChild:spriteMain4 cleanup:YES];
			}
			if (touchx > 187 & touchx < 226 & touchy < 105) { 
				target5 = [imagesMast objectAtIndex:4];
				targetMain = target5;		
				mposition = 5;
				serialTemp5 = serialM5;
				[self removeChild:spriteMain5 cleanup:YES];
			}
			if (touchx > 231 & touchx < 273 & touchy < 105) { 
                target6 = [imagesMast objectAtIndex:5];				
				targetMain = target6;	
				mposition = 6;
				serialTemp6 = serialM6;
				[self removeChild:spriteMain6 cleanup:YES];
			}
			if (touchx > 278 & touchx < 318 & touchy < 105) { 
				target7 = [imagesMast objectAtIndex:6];
				targetMain = target7;	
				mposition = 7;
				serialTemp7 = serialM7;
				[self removeChild:spriteMain7 cleanup:YES];
			}
			
		
		//	CGPoint touchLocationInGameLayer = [m._gameLayer convertTouchToNodeSpace:touch];
		//	[m._gameLayer removeTower:touchLocationInGameLayer];
			
			if (targetMain == target1 )
			[m._gameLayer removeChild:targetTower1 cleanup:YES];
			if (targetMain == target2)
			[m._gameLayer removeChild:targetTower2 cleanup:YES];
			if (targetMain == target3)
			[m._gameLayer removeChild:targetTower3 cleanup:YES];
			if (targetMain == target4)
			[m._gameLayer removeChild:targetTower4 cleanup:YES];
			if (targetMain == target5)
			[m._gameLayer removeChild:targetTower5 cleanup:YES];
			if (targetMain == target6)
			[m._gameLayer removeChild:targetTower6 cleanup:YES];
			if (targetMain == target7)
			[m._gameLayer removeChild:targetTower7 cleanup:YES];
			
			
			selSpriteRange = [CCSprite spriteWithFile:@"Range.png"];
			selSpriteRange.scale = 4;
			[self addChild:selSpriteRange z:-1];
		//	selSpriteRange.position = target.position;
			
            newSprite = [CCSprite spriteWithTexture:[sprite texture]]; //sprite;
			newSprite.position = sprite.position;
			selSprite = newSprite;
			[self addChild:newSprite];
			[movableSprites addObject:newSprite];
			
 			mtCopy = targetMain;
			//	target = nil;

			
		//	targetTower1 = nil;
		//	targetTower2 = nil;
		//	targetTower3 = nil;
		//	targetTower4 = nil;
		//	targetTower5 = nil;
		//	targetTower6 = nil;
		//	targetTower7 = nil;
			
			
            break;
        }
    }     
	return YES;
}

- (void) checkWord {
	
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
		const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc where tileLocX ='1'"] UTF8String];
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
				
				currentLetter = [atileDesc substringWithRange:NSMakeRange(0,1)]; 
				self.wordMain = [self.wordMain stringByAppendingString:currentLetter];
			}
			
		}
			// Release the compiled statement from memory
			sqlite3_finalize(compiledStatement);
			
		}
		sqlite3_close(database);

	
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {  
   // [self moveBoard];
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
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];	
	DataModel *m = [DataModel getModel];

	if (selSprite) {
		CGRect backgroundRect = CGRectMake(background.position.x, 
									   background.position.y, 
									   background.contentSize.width, 
									   background.contentSize.height);
		
		if (!CGRectContainsPoint(backgroundRect,touchLocation)) {
			CGPoint touchLocationInGameLayer = [m._gameLayer convertTouchToNodeSpace:touch];
			[m._gameLayer addTower:touchLocationInGameLayer];
		//	[m._gameLayer addTower:touchLocation];
			[self checkLoc];
			[self registerLoc];
		//	[self updateDatabase1];
			//play sound
			SystemSoundID pmph;
			id sndpath = [[NSBundle mainBundle] 
						  pathForResource:@"beeparca" 
						  ofType:@"wav" 
						  inDirectory:@"/"];
			CFURLRef baseURL = (CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
			AudioServicesCreateSystemSoundID (baseURL, &pmph);
			AudioServicesPlaySystemSound(pmph); 
			[baseURL release];
		}

		[self removeChild:selSprite cleanup:YES];
		selSprite = nil;		
		[self removeChild:selSpriteRange cleanup:YES];
		selSpriteRange = nil;
	//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	//  [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];

	}
//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];

	m._gestureRecognizer.enabled = YES;
	
	targetTower = nil;
	target1 = nil;
	target2 = nil;
	target3 = nil;
	target4 = nil;
	target5 = nil;
	target6 = nil;
	target7 = nil;
	
//	[self cancelMove];
	
	//[[CCTouchDispatcher sharedDispatcher] setDispatchEvents:YES];	
	
	// This disables moving the background screen after a touch move has been completed
//	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	
	
}

- (void) displaySingle {
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
		 const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc where chronOrder =  %i",chronTemp] UTF8String];
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

				serialNo = aSerial;
				fileName = [NSString stringWithFormat:@"%@",afileName];
				
				NSLog(@"%@",fileName);
				
				Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused fileName:afileName];
				
				// Add the animal object to the animals Array
				NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
				
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
//	return self;
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
			
		
			
			Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused fileName:afileName];
			
			// Add the animal object to the animals Array
			NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
		
			DataModel *m = [DataModel getModel];	
		//	[_tileMap layerNamed:@"Board"] setTileGID:aSerial at:ccp(atileLocX,atileLocY)];
			
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
-(void) countOfUnused {
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
		
		//NSString *phrase = @"'2011-03-12'";	
		//	int *gidTemp = 16;
		
		// Setup the SQL Statement and compile it for faster access		
		const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc where used <> 'Y'"] UTF8String];
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
				
				Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused fileName:afileName];
				
				// Add the animal object to the animals Array
				NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
				
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

- (void) displayAll {
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
		
		//NSString *phrase = @"'2011-03-12'";	
	//	int *gidTemp = 16;
		
		// Setup the SQL Statement and compile it for faster access		
		const char *sqlStatement2 = [[NSString stringWithFormat:@"select * from tLoc"] UTF8String];
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
				
			//	serialNo = aSerial;
				
				Animal *animal = [[Animal alloc] nameit2:atileDesc serial:aSerial description:atileLocAsString tileLocX:atileLocX tileLocY:atileLocY  chronOrder:achronOrder used:aused];
				
				// Add the animal object to the animals Array
				NSString *messg = [NSString stringWithFormat:@"Desc: %@",animal.nameit2];
				
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



-(void)moveBoard{
	NSLog(@"In moveBoard");
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
	
	//play sound
	SystemSoundID pmph;
	id sndpath = [[NSBundle mainBundle] 
				  pathForResource:@"beeparca" 
				  ofType:@"wav" 
				  inDirectory:@"/"];
	CFURLRef baseURL = (CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
	AudioServicesCreateSystemSoundID (baseURL, &pmph);
	AudioServicesPlaySystemSound(pmph); 
	[baseURL release];
	
	DataModel *m = [DataModel getModel];
	PinchZoomLayer *pZoom = [PinchZoomLayer initPinchZoom:[m._gameLayer tileMap]];
	
//	[pZoom scaleToFit];
	
}
-(void)cancelMove{
	
//	DataModel *m = [DataModel getModel];
//	m._gameLayer.isTouchEnabled = NO;
//	m._gestureRecognizer.enabled = NO;	
	NSLog(@"In cancelMove");
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	
	//play sound
	SystemSoundID pmph;
	id sndpath = [[NSBundle mainBundle] 
				  pathForResource:@"beeparca" 
				  ofType:@"wav" 
				  inDirectory:@"/"];
	CFURLRef baseURL = (CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
	AudioServicesCreateSystemSoundID (baseURL, &pmph);
	AudioServicesPlaySystemSound(pmph); 
	[baseURL release];	
	sleep(5000);
}

-(void)registerLoc{
	
	Mtargettower1X = targettower1X;
	Mtargettower1Y = targettower1Y;
	
	Mtargettower2X = targettower2X;
	Mtargettower2Y = targettower2Y;

	Mtargettower3X = targettower3X;
	Mtargettower3Y = targettower3Y;
	
	Mtargettower4X = targettower4X;
	Mtargettower4Y = targettower4Y;
	
	Mtargettower5X = targettower5X;
	Mtargettower5Y = targettower5Y;
	
	Mtargettower6X = targettower6X;
	Mtargettower6Y = targettower6Y;
	
	Mtargettower7X = targettower7X;
	Mtargettower7Y = targettower7Y;

	}
-(void)checkLoc{
	
	DataModel *m = [DataModel getModel];
	
	NSString *clear =@"YES";
	//[self removeChild:lastTowerMoved cleanup:YES];
	//[self removeChild:targetTower1 cleanup:YES];
	//[self removeChild:targetTower2 cleanup:YES];
	
	if ((Mtargettower1X == targettowerX) & (Mtargettower1Y == targettowerY))
		clear = @"NO";
	if ((Mtargettower2X == targettowerX) & (Mtargettower2Y == targettowerY))
		clear = @"NO";
	if ((Mtargettower3X == targettowerX) & (Mtargettower3Y == targettowerY))
		clear = @"NO";
	if ((Mtargettower4X == targettowerX) & (Mtargettower4Y == targettowerY))
		clear = @"NO";
	if ((Mtargettower5X == targettowerX) & (Mtargettower5Y == targettowerY))
		clear = @"NO";
	if ((Mtargettower6X == targettowerX) & (Mtargettower6Y == targettowerY))
		clear = @"NO";
	if ((Mtargettower7X == targettowerX) & (Mtargettower7Y == targettowerY))
		clear = @"NO";
	
	if ([clear isEqualToString:@"NO"]){
		UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"Disallowed Move!" 
								  message:@"Please try again"
								  delegate:self cancelButtonTitle:nil 
								  otherButtonTitles:@"Ok", nil];
		[baseAlert show];
		//play sound
		SystemSoundID pmph;
		id sndpath = [[NSBundle mainBundle] 
					  pathForResource:@"Buzzer" 
					  ofType:@"mp3" 
					  inDirectory:@"/"];
		CFURLRef baseURL = (CFURLRef) [[NSURL alloc] initFileURLWithPath:sndpath];
		AudioServicesCreateSystemSoundID (baseURL, &pmph);
		AudioServicesPlaySystemSound(pmph); 
		[baseURL release];
	 
		//[self removeChild:targetTower1 cleanup:YES];
		
		[m._gameLayer removeChild:lastTowerMoved cleanup:YES];
		[self setSingleTile];
		
		return;
	}
	
	
}

- (void) updateDatabase1
{
	
//	sqlite3 *db = [appDelegate database];
	sqlite3_stmt *update_statement;
	
	databaseName = @"tileLocations.rdb";
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	//	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	databasePath = [[NSBundle mainBundle] pathForResource:@"tileLocations" ofType:@"rdb"];	
	// Setup the database object
	
	sqlite3 *database;
//int gidTemp = 16;
	int xLoc = towerLoc.x;
	int yLoc = towerLoc.y;
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		
	//	serialNo = 19;
		
	//	chronTemp = arc4random() % 99;
	//	serialNo = [NSString  stringWithFormat:@"%i", chronTemp ];

		if (![serialTemp1 isEqualToString:@""]){
			serialNo = serialM1;
		}else if (![serialTemp2 isEqualToString:@""]){
			serialNo = serialM2;
		}else if (![serialTemp3 isEqualToString:@""]){
			serialNo = serialM3;
		}else if (![serialTemp4 isEqualToString:@""]){
			serialNo = serialM4;
		}else if (![serialTemp5 isEqualToString:@""]){
			serialNo = serialM5;
		}else if (![serialTemp6 isEqualToString:@""]){
			serialNo = serialM6;
		}else if (![serialTemp7 isEqualToString:@""]){
			serialNo = serialM7;
		}
													
		
	
		NSString *sqlStr = [NSString stringWithFormat:@"UPDATE tLoc SET tileLocX = %i, tileLocY = %i, used = 'Y' WHERE serial=%@",xLoc, yLoc, serialNo];
	
			
	const char *sql = [sqlStr UTF8String];
	if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DatabaseNotAvailable", @"") message:[NSString stringWithUTF8String:sqlite3_errmsg(database)]
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];	
		[alert release];
		return NO;
	}
	
	int success = sqlite3_step(update_statement);
	if (success == SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		return NO;
	}
	
	sqlite3_finalize(update_statement);
	//[self displayDatabase];
		
		serialTemp1 = @"";
		serialTemp2 = @"";
		serialTemp3 = @"";
		serialTemp4 = @"";
		serialTemp5 = @"";
		serialTemp6 = @"";
		serialTemp7 = @"";
		serialNo = @"";
		
		return YES;
	
	}
    
}
- (void)onEnter
{
    [super onEnter];
	
    /*
     * This method is called every time the CCNode enters the 'stage'.
     */
	
	DataModel *m = [DataModel getModel];
	[m._gameLayer getUsed];
	
	
	NSLog(@"Sure enougth!");
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
	
    /*
     * This method is called when the transition finishes.
     */
}

- (void)onExit
{
    [super onExit];
	
    /*
     * This method is called every time the CCNode leaves the 'stage'.
     */
}

- (void) setUsed
{
	
	//	sqlite3 *db = [appDelegate database];
	sqlite3_stmt *update_statement;
	
	databaseName = @"tileLocations.rdb";
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	//	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	databasePath = [[NSBundle mainBundle] pathForResource:@"tileLocations" ofType:@"rdb"];	
	// Setup the database object
	
	sqlite3 *database;
	//int gidTemp = 16;
	int xLoc = towerLoc.x;
	int yLoc = towerLoc.y;
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		
		NSString *sqlStr = [NSString stringWithFormat:@"UPDATE tLoc SET used = 'Y' WHERE chronOrder=%i and used <> 'Y'", chronTemp];
		
		const char *sql = [sqlStr UTF8String];
		if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DatabaseNotAvailable", @"") message:[NSString stringWithUTF8String:sqlite3_errmsg(database)]
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];	
			[alert release];
			return NO;
		}
		[self displaySingle];
		int success = sqlite3_step(update_statement);
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
			return NO;	
			
		}
	
		sqlite3_finalize(update_statement);
	//	[self displayDatabase];
		return YES;
		
	}
    
}



	
//}
	
- (void) registerWithTouchDispatcher
{
	//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[movableSprites release];
    movableSprites = nil;
	[super dealloc];
}
@end
