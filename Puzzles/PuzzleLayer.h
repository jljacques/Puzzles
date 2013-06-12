//
//  PuzzleLayer.h
//  Puzzles
//
//  Created by Jeremy Jacques on 13-03-23.
//  Copyright (c) 2013 Jeremy Jacques. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "CCLayer.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"



@interface PuzzleLayer : CCLayer

{
    id growAnimation;
    id shrinkAnimation;
    id moveBackAnimation;
    id guideAnimation;
    id guideForeverAnimation;
    
    id drag0Animation;
    id drag1Animation;
    id drag2Animation;
    id drag3Animation;
    id drag4Animation;
    id drag5Animation;
    id drag6Animation;
    id drag7Animation;
    id drag1Sequence;
    id drag2Sequence;
    id drag3Sequence;
    id drag4Sequence;
    id drag5Sequence;
    id drag6Sequence;
    id drag7Sequence;


    
    id outline0Animation;
    id outline1Animation;
    id outline2Animation;
    id outline3Animation;


    
    int objectTouched;
    int endSequence;
    
    int testNum;
    int colourNum;
    int shapeNum;
    int textInt;
    int colourInt;
    int dragNum;
    
    int gameMode;
    int level;
    
    float sideCardShrink;
    float buttonShrink;
    
    ccColor3B Blue;
    ccColor3B Green;
    ccColor3B Yellow;
    ccColor3B Orange;
    ccColor3B Red;
    ccColor3B Purple;
    ccColor3B Pink;
    ccColor3B White;
    ccColor3B Black;
    ccColor3B objectColour;
    
    BOOL object0Placed;
    BOOL object1Placed;
    BOOL object2Placed;
    BOOL object3Placed;
    BOOL gameOver;
    BOOL gameSetup;
    
    BOOL touchAgain;
    BOOL touchNext;
    BOOL touchPrev;
    BOOL touch4;
    BOOL touch5;
    BOOL touch6;
    BOOL touch7;
    BOOL touchNum;
    BOOL touchShape;
    BOOL touchColour;
    
    BOOL holdFlag;
    
    BOOL startExpire;
    BOOL holdExpire;

    NSTimer *startTimer;
    NSTimer *holdTimer;
    
    NSArray *shapeNames;
    NSArray *colours;
    NSArray *numbers;
    NSArray *shapeNumberCombine;

    
    NSMutableString *outlineName0;
    NSMutableString *outlineName1;
    NSMutableString *outlineName2;
    NSMutableString *outlineName3;

    NSMutableString *dragName0;
    NSMutableString *dragName1;
    NSMutableString *dragName2;
    NSMutableString *dragName3;
    NSMutableString *dragName4;
    NSMutableString *dragName5;
    NSMutableString *dragName6;
    NSMutableString *dragName7;
        
    NSMutableString *objectString;
    NSMutableString *outlineString;
    NSMutableString *colourString;

    
    NSMutableArray *shapeArray;
    NSMutableArray *coloursArray;
    NSMutableArray *dragArray;
    NSMutableArray *dragNumArray;


    NSString *numberToAdd;
    NSMutableString *labelString;
    
    CGRect oBox0;
    CGRect oBox1;
    CGRect oBox2;
    CGRect oBox3;
    
    CGRect dBox0;
    CGRect dBox1;
    CGRect dBox2;
    CGRect dBox3;

    CCSprite *playAgain;
    CCSprite *playNext;
    CCSprite *playPrevious;

    
    CCSprite *outlineSprite0;
    CCSprite *outlineSprite1;
    CCSprite *outlineSprite2;
    CCSprite *outlineSprite3;

    CCSprite *dragSprite0;
    CCSprite *dragSprite1;
    CCSprite *dragSprite2;
    CCSprite *dragSprite3;
    CCSprite *dragSprite4;
    CCSprite *dragSprite5;
    CCSprite *dragSprite6;
    CCSprite *dragSprite7;
    
    CCSprite *backgroundSprite;
    
    CCSprite *colourLevel;
    CCSprite *shapeLevel;
    CCSprite *numberLevel;
    
    CCLabelTTF *objectLabel;
    CCLabelTTF *shadowLabel;


    CGPoint outlineLoc0;
    CGPoint outlineLoc1;
    CGPoint outlineLoc2;
    CGPoint outlineLoc3;

    CGPoint dragLoc0;
    CGPoint dragLoc1;
    CGPoint dragLoc2;
    CGPoint dragLoc3;
    CGPoint dragLoc4;
    CGPoint dragLoc5;
    CGPoint dragLoc6;
    CGPoint dragLoc7;
    
    CGPoint playAgainLoc;
    CGPoint playNextLoc;
    CGPoint playPrevLoc;
    
    CGPoint colourButtonLoc;
    CGPoint numberButtonLoc;
    CGPoint shapeButtonLoc;




}

@property (nonatomic, retain)    id growAnimation;
@property (nonatomic, retain)    id shrinkAnimation;
@property (nonatomic, retain)    id moveBackAnimation;
@property (nonatomic, retain)    id incorrectAnimation;


+(CCScene *) scene;


@end
