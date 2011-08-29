//
//  GameHUD.h
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "cocos2d.h"
#import <UIKit/UIKit.h>
#import <sqlite3.h>



@interface GameHUD : CCLayer {
//CCSprite * background;
	CCLabelAtlas *label;
	CCSprite * background2;
	CCSprite * background3;
	
	
	
	CCSprite * selSpriteRange;
    CCSprite * selSprite;
   // NSMutableArray * movableSprites;
	
	NSString *wordMain;
	
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	// Array to store the animal objects
	NSMutableArray *animals;
	
	UIWindow *window;
	UIViewController *tilesController;
	
	
}
@property (nonatomic, retain) UIViewController *tilesController;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *animals;
@property (nonatomic, retain) CCLabelAtlas *label;
@property (nonatomic, retain) NSString *wordMain;
//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

+ (GameHUD *)sharedHUD;
-(void)setMainTiles;
-(void)setSingleTile;
- (void) setMultipleTiles;
-(void)checkLoc;
-(void)registerLoc;
-(void)moveBoard;
-(void)cancelMove;
- (void)tileInfo:(CGPoint)pos;
- (void) showStats;
- (void) setUsed;
- (void) updateDatabase1;
- (void) displaySingle;
- (void) displayAll;
- (void) getUsed;
- (void) checkWord;

@end
