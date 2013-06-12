//
//  PuzzleLayer.m
//  Puzzles
//
//  Created by Jeremy Jacques on 13-03-23.
//  Copyright (c) 2013 Jeremy Jacques. All rights reserved.
//

#define kShapesMode 1
#define kNumberMode 2
#define kColourMode 3



#import "PuzzleLayer.h"

@implementation PuzzleLayer
@synthesize growAnimation, incorrectAnimation, shrinkAnimation, moveBackAnimation;

-(id)init
{
    if(self==[super init]) {
        [self performSelector:@selector(valueInit)];
        [self performSelector:@selector(categorySetup)];
        [self performSelector:@selector(dragLocator)];

        [self performSelector:@selector(randomizeObjects)];
        [self performSelector:@selector(setupOutlineCards)];
        [self performSelector:@selector(setupSideCards)];
        
        [self performSelector:@selector(animationSetup)];
        [self performSelector:@selector(startAnimation)];


        
        self.touchEnabled = YES;
        
    }
    return self;
}


-(void)valueInit {
    startExpire = NO;
    startTimer = [[NSTimer alloc] init];
    startTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(timerExpire) userInfo:nil repeats:NO];
    gameMode = kColourMode;
    level = 1;
    objectLabel = [CCLabelTTF labelWithString:@"" fontName:@"Chalkboard" fontSize:90];
    objectLabel.position = CGPointMake(640.0f, 700.0f);
    [self addChild:objectLabel z:10];
    shadowLabel = [CCLabelTTF labelWithString:@"" fontName:@"Chalkboard" fontSize:90];
    shadowLabel.position = CGPointMake(638.0f, 698.0f);
    [self addChild:shadowLabel z:9];

    
    backgroundSprite = [CCSprite spriteWithFile:@"BG.png"];
    backgroundSprite.anchorPoint = ccp(0.0f, 0.0f);
    backgroundSprite.position = CGPointMake(0.0f, 0.0f);
    [self addChild:backgroundSprite z:0];
    gameOver = NO;
    gameSetup = NO;
    object0Placed = NO;
    object1Placed = NO;
    object2Placed = NO;
    object3Placed = NO;
    touchAgain = NO;
    touchNext = NO;
    touchPrev = NO;
    shapeLevel = NO;
    colourLevel = NO;
    numberLevel = NO;
    
    holdFlag = NO;

    objectTouched = 99;
    endSequence = 99;
    
    outlineLoc0 = CGPointMake(481.0f, 200.0f);
    outlineLoc1 = CGPointMake(801.0f, 200.0f);
    outlineLoc2 = CGPointMake(481.0f, 519.0f);
    outlineLoc3 = CGPointMake(801.0f, 519.0f);
        
    playAgainLoc = CGPointMake(120.0f, 576.0f);
    playNextLoc = CGPointMake(120.0f, 384.0f);
    playPrevLoc = CGPointMake(120.0f, 192.0f);
    
    colourButtonLoc = CGPointMake(500.0f, 700.0f);
    shapeButtonLoc = CGPointMake(650.0f, 700.0f);
    numberButtonLoc = CGPointMake(800.0f, 700.0f);
    
    buttonShrink = 0.5f;

    
    shapeArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    coloursArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    dragArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    dragNumArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];

    
    Blue = ccc3(6, 154, 255);
    Green = ccc3(5, 226, 95);
    Yellow = ccc3(252, 245, 16);
    Orange = ccc3(252, 170, 6);
    Red = ccc3(252, 6, 76);
    Purple = ccc3(152, 76, 252);
    Pink = ccc3(252, 53, 214);
    White = ccc3(252, 252, 252);
    Black = ccc3(0, 0, 0);
}

-(void)restartInit {
    startExpire = NO;
    [startTimer invalidate];
    startTimer = [[NSTimer alloc] init];
    startTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(timerExpire) userInfo:nil repeats:NO];

    objectLabel = [CCLabelTTF labelWithString:@"" fontName:@"Chalkboard" fontSize:90];
    objectLabel.position = CGPointMake(640.0f, 700.0f);
    [self addChild:objectLabel z:10];
    shadowLabel = [CCLabelTTF labelWithString:@"" fontName:@"Chalkboard" fontSize:90];
    shadowLabel.position = CGPointMake(638.0f, 698.0f);
    [self addChild:shadowLabel z:9];
    
    backgroundSprite = [CCSprite spriteWithFile:@"BG.png"];
    backgroundSprite.anchorPoint = ccp(0.0f, 0.0f);
    backgroundSprite.position = CGPointMake(0.0f, 0.0f);
    [self addChild:backgroundSprite z:0];
    gameOver = NO;
    gameSetup = NO;
    object0Placed = NO;
    object1Placed = NO;
    object2Placed = NO;
    object3Placed = NO;
    touchAgain = NO;
    touchNext = NO;
    touchPrev = NO;
    shapeLevel = NO;
    colourLevel = NO;
    numberLevel = NO;
    
    objectTouched = 99;
    endSequence = 99;
    
    [shapeArray release];
    [coloursArray release];
    [dragNumArray release];
    [dragArray release];
    
    shapeArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    coloursArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    dragArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    dragNumArray = [[NSMutableArray arrayWithObjects:@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107", nil]retain];
    
    [self performSelector:@selector(dragLocator)];
    
}


-(void)timerExpire {
    startExpire = YES;
    CCLOG(@"StartExpired");

}

-(void)holdExpireSelector {
    if (holdFlag == NO) {
    holdFlag = YES;
    if (objectTouched <= 5) {
    CCLOG(@"holdExpired");
    holdExpire = YES;
    [self performSelector:@selector(runAnimation)];
    }
    }
}


-(void)dragRandomizer {
    int var;
    var = level + 3;
    for (int j=0; j<var; j++) {
        dragNum = (arc4random() % var);
        NSNumber *dragNumValue = [NSNumber numberWithInt:dragNum];
        CCLOG(@"dragnum=%d",dragNum);
        if(![dragNumArray containsObject:dragNumValue]) {
            CCLOG(@"ADD DRAG NUM");
            [dragNumArray replaceObjectAtIndex:j withObject:dragNumValue];
        }
        else{
            j--;
        }
    }
    [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:0] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc0]];
    [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:1] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc1]];
    [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:2] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc2]];
    [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:3] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc3]];
    if (level >=2) {
        [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:4] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc4]];
        CCLOG(@"TestLevel2");
    }
    if (level >=3) {
        [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:5] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc5]];
    }
    if (level >=4) {
        [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:6] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc6]];
    }
    if (level >=5) {
        [dragArray replaceObjectAtIndex:[[dragNumArray objectAtIndex:7] integerValue] withObject:[NSValue valueWithCGPoint:dragLoc7]];
    }
}

-(void)startAnimation {
    drag0Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:0] CGPointValue]] retain];
    drag1Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:1] CGPointValue]] retain];
    drag2Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:2] CGPointValue]] retain];
    drag3Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:3] CGPointValue]] retain];
    
    [dragSprite0 runAction:drag0Animation];    
    [dragSprite1 runAction:drag1Animation];
    [dragSprite2 runAction:drag2Animation];
    [dragSprite3 runAction:drag3Animation];
    
    if (level >= 2) {
        drag4Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:4] CGPointValue]] retain];
        [dragSprite4 runAction:drag4Animation];

        if (level >= 3) {

            drag5Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:5] CGPointValue]] retain];
            [dragSprite5 runAction:drag5Animation];

            if (level >= 4) {

                drag6Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:6] CGPointValue]] retain];
                [dragSprite6 runAction:drag6Animation];

                if (level >= 5) {

                    drag7Animation = [[CCMoveTo actionWithDuration:0.5 position:[[dragArray objectAtIndex:7] CGPointValue]] retain];
                    [dragSprite7 runAction:drag7Animation];

                    
                }
            }
        }
    }

    outline0Animation = [[CCSequence actions:[CCScaleTo actionWithDuration:0.5 scale:1.1],[CCScaleTo actionWithDuration:0.1 scale:1.0], nil] retain];
    outline1Animation = [[CCSequence actions:[CCScaleTo actionWithDuration:0.5 scale:1.1],[CCScaleTo actionWithDuration:0.1 scale:1.0], nil] retain];
    outline2Animation = [[CCSequence actions:[CCScaleTo actionWithDuration:0.5 scale:1.1],[CCScaleTo actionWithDuration:0.1 scale:1.0], nil] retain];
    outline3Animation = [[CCSequence actions:[CCScaleTo actionWithDuration:0.5 scale:1.1],[CCScaleTo actionWithDuration:0.1 scale:1.0], nil] retain];
    
    
    [outlineSprite0 runAction:outline0Animation];
    [outlineSprite1 runAction:outline1Animation];
    [outlineSprite2 runAction:outline2Animation];
    [outlineSprite3 runAction:outline3Animation];


}

-(void)dragLocator {
    if (level == 1) {
        sideCardShrink = 0.60f;

        dragLoc0 = CGPointMake(128.0f, 655.0f);
        dragLoc1 = CGPointMake(128.0f, 475.0f);
        dragLoc2 = CGPointMake(128.0f, 295.0f);
        dragLoc3 = CGPointMake(128.0f, 115.0f);
    }
    if (level == 2) {
        sideCardShrink = 0.55f;

        dragLoc0 = CGPointMake(128.0f, 680.0f);
        dragLoc1 = CGPointMake(128.0f, 530.0f);
        dragLoc2 = CGPointMake(128.0f, 380.0f);
        dragLoc3 = CGPointMake(128.0f, 230.0f);
        dragLoc4 = CGPointMake(128.0f, 80.0f);
    }
    if (level == 3) {
        sideCardShrink = 0.48f;
        
        dragLoc0 = CGPointMake(128.0f, 700.0f);
        dragLoc1 = CGPointMake(128.0f, 575.0f);
        dragLoc2 = CGPointMake(128.0f, 450.0f);
        dragLoc3 = CGPointMake(128.0f, 325.0f);
        dragLoc4 = CGPointMake(128.0f, 200.0f);
        dragLoc5 = CGPointMake(128.0f, 75.0f);

    }
    if (level == 4) {
        sideCardShrink = 0.42f;
        
        dragLoc0 = CGPointMake(128.0f, 702.0f);
        dragLoc1 = CGPointMake(128.0f, 595.0f);
        dragLoc2 = CGPointMake(128.0f, 488.0f);
        dragLoc3 = CGPointMake(128.0f, 381.0f);
        dragLoc4 = CGPointMake(128.0f, 274.0f);
        dragLoc5 = CGPointMake(128.0f, 167.0f);
        dragLoc6 = CGPointMake(128.0f, 60.0f);

    }
    if (level == 5) {
        sideCardShrink = 0.37f;
        
        dragLoc0 = CGPointMake(128.0f, 713.0f);
        dragLoc1 = CGPointMake(128.0f, 619.0f);
        dragLoc2 = CGPointMake(128.0f, 525.0f);
        dragLoc3 = CGPointMake(128.0f, 431.0f);
        dragLoc4 = CGPointMake(128.0f, 337.0f);
        dragLoc5 = CGPointMake(128.0f, 243.0f);
        dragLoc6 = CGPointMake(128.0f, 149.0f);
        dragLoc7 = CGPointMake(128.0f, 55.0f);

    }
    [self performSelector:@selector(dragRandomizer)];

}

-(void)getLabel:(NSArray*)label {
    if (objectTouched == 0) {
        textInt = [[shapeArray objectAtIndex:0] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:0] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];
    }
    else if (objectTouched == 1) {
        textInt = [[shapeArray objectAtIndex:1] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:1] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];

        
    }
    else if (objectTouched == 2) {
        textInt = [[shapeArray objectAtIndex:2] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:2] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];

        
    }
    else if (objectTouched == 3) {
        textInt = [[shapeArray objectAtIndex:3] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:3] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];

        
    }
    else if (objectTouched == 4) {
        textInt = [[shapeArray objectAtIndex:4] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:4] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];
    }
    else if (objectTouched == 5) {
        textInt = [[shapeArray objectAtIndex:5] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:5] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];
    }
    else if (objectTouched == 6) {
        textInt = [[shapeArray objectAtIndex:6] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:6] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];
    }
    else if (objectTouched == 7) {
        textInt = [[shapeArray objectAtIndex:7] integerValue];
        labelString = [NSMutableString stringWithString:[label objectAtIndex:textInt]];
        colourInt = [[coloursArray objectAtIndex:7] integerValue];
        colourString = [NSMutableString stringWithString:[colours objectAtIndex:colourInt]];
    }
    else {
        labelString= [NSMutableString stringWithFormat:@""];
        colourString = [NSMutableString stringWithFormat:@"White"];
    }
    CCLOG(@"colour=%@",colourString);
    [self performSelector:@selector(getColour)];
    
}

-(void)getColour {
    if ([colourString isEqualToString:@"Blue"]) {
        objectColour = Blue;
    }
    else if ([colourString isEqualToString:@"Green"]) {
        objectColour = Green;
    }
    else if ([colourString isEqualToString:@"Yellow"]) {
        objectColour = Yellow;
    }
    else if ([colourString isEqualToString:@"Orange"]) {
        objectColour = Orange;
    }
    else if ([colourString isEqualToString:@"Red"]) {
        objectColour = Red;
    }
    else if ([colourString isEqualToString:@"Pink"]) {
        objectColour = Pink;
    }
    else if ([colourString isEqualToString:@"Purple"]) {
        objectColour = Purple;
    }
    else if ([colourString isEqualToString:@"White"]) {
        objectColour = White;
    }
    else {
        objectColour = Black;
    }
}

-(void)getObjectString:(NSArray*)objectArray {
    objectString = [NSMutableString stringWithFormat:@"%@_%@.png",[objectArray objectAtIndex:shapeNum],[colours objectAtIndex:colourNum]];
    if (gameMode == kColourMode) {
        outlineString = [NSMutableString stringWithFormat:@"OUTLINE_%@.png",[colours objectAtIndex:colourNum]];
    }
    else {
        outlineString = [NSMutableString stringWithFormat:@"OUTLINE_%@.png",[objectArray objectAtIndex:shapeNum]];
    }
    
}

-(void)textSetup {
    [self removeChild:objectLabel];
    [self removeChild:shadowLabel];

    CCLOG(@"Object#=%d",objectTouched);
    if (gameMode == kShapesMode) {
        [self getLabel:shapeNames];
    }
    else if (gameMode == kNumberMode) {
        [self getLabel:numbers];
    }
    else if (gameMode == kColourMode) {
        [self getLabel:shapeNumberCombine];
    }

    if (gameMode == kColourMode) {
        objectLabel = [CCLabelTTF labelWithString:colourString fontName:@"Chalkboard" fontSize:90];
        shadowLabel = [CCLabelTTF labelWithString:colourString fontName:@"Chalkboard" fontSize:90];
        if (objectTouched >= 90) {
            objectLabel = [CCLabelTTF labelWithString:@"" fontName:@"Chalkboard" fontSize:90];
            shadowLabel = [CCLabelTTF labelWithString:@"" fontName:@"Chalkboard" fontSize:90];
        }
    }
    else {
        objectLabel = [CCLabelTTF labelWithString:labelString fontName:@"Chalkboard" fontSize:90];
        shadowLabel = [CCLabelTTF labelWithString:labelString fontName:@"Chalkboard" fontSize:90];
    }
    
    objectLabel.position = CGPointMake(640.0f, 700.0f);
    objectLabel.color = objectColour;
    [self addChild:objectLabel z:10];
    shadowLabel.position = CGPointMake(636.0f, 696.0f);
    shadowLabel.color = Black;
    [self addChild:shadowLabel z:9];
}


-(void)categorySetup {
    shapeNames = [[NSArray arrayWithObjects:@"Circle",@"Diamond",@"Oval",@"Pentagon",@"Rectangle",@"Square",@"Star",@"Trapezoid",@"Triangle",nil] retain];
    colours = [[NSArray arrayWithObjects:@"Blue",@"Green",@"Orange",@"Pink",@"Purple",@"Red",@"White",@"Yellow", nil] retain];
    numbers = [[NSArray arrayWithObjects:@"Zero",@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine", nil] retain];
    shapeNumberCombine = [[NSArray arrayWithObjects:@"Circle",@"Diamond",@"Oval",@"Pentagon",@"Rectangle",@"Square",@"Star",@"Trapezoid",@"Triangle",@"Zero",@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine", nil] retain];
    
}

-(void)randomizeObjects {
    int i;
    int objectCount;
    
    if (gameMode == kShapesMode) {
        objectCount = 9;
    }
    else if (gameMode == kNumberMode) {
        objectCount = 10;
    }
    else if (gameMode == kColourMode) {
        objectCount = 19;
    }
    
    
    for (int j=0; j<8; j++) {
        testNum = (arc4random() % objectCount);
        numberToAdd = [NSString stringWithFormat:@"%d",testNum];
        CCLOG(@"shapenum=%@, count=%d",numberToAdd,[shapeArray count]);
        if(![shapeArray containsObject:numberToAdd]) {
            CCLOG(@"ADD NUM");
            [shapeArray replaceObjectAtIndex:j withObject:numberToAdd];
        }
        else{
            j--;
        }
    }
    
    for (int j=0; j<8; j++) {
        testNum = (arc4random() % 8);
        numberToAdd = [NSString stringWithFormat:@"%d",testNum];
        CCLOG(@"colournum=%@, count=%d",numberToAdd,[coloursArray count]);
        if(![coloursArray containsObject:numberToAdd]) {
            CCLOG(@"ADD NUM");
            [coloursArray replaceObjectAtIndex:j withObject:numberToAdd];
        }
        else {
            j--;
        }
    }

    
    
    for (i =0 ; i<8; i++) {
        shapeNum = [[shapeArray objectAtIndex:i] integerValue];
        colourNum = [[coloursArray objectAtIndex:i] integerValue];

        if (gameMode == kShapesMode) {
            [self getObjectString:shapeNames];
        }
        else if (gameMode == kNumberMode) {
            [self getObjectString:numbers];
        }
        else if (gameMode == kColourMode) {
            [self getObjectString:shapeNumberCombine];
        }
        CCLOG(@"%@",outlineString);
        CCLOG(@"%@",objectString);

    
        if (i == 0) {
            dragName0 = objectString;
            outlineName0 = outlineString;
        }
        else if (i == 1) {
            dragName1 = objectString;
            outlineName1 = outlineString;

        }
        else if (i == 2) {
            dragName2 = objectString;
            outlineName2 = outlineString;
        }
        else if (i == 3) {
            dragName3 = objectString;
            outlineName3 = outlineString;

        }
        else if (i == 4) {
            dragName4 = objectString;
        }
        else if (i == 5) {
            dragName5 = objectString;
        }
        else if (i == 6) {
            dragName6 = objectString;
        }
        else if (i == 7) {
            dragName7 = objectString;
        }
        
    }
}



-(void)endGame {
    playAgain = [CCSprite spriteWithFile:@"Replay.png"];
    playAgain.position = playAgainLoc;
    [self addChild:playAgain z:70];
    
    colourLevel = [CCSprite spriteWithFile:@"OUTLINE_Pink.png"];
    colourLevel.position = colourButtonLoc;
    colourLevel.scale = buttonShrink;
    [self addChild:colourLevel z:70];
    
    numberLevel = [CCSprite spriteWithFile:@"One_Green.png"];
    numberLevel.position = numberButtonLoc;
    numberLevel.scale = buttonShrink;
    [self addChild:numberLevel z:70];
    
    shapeLevel = [CCSprite spriteWithFile:@"Triangle_Yellow.png"];
    shapeLevel.position = shapeButtonLoc;
    shapeLevel.scale = buttonShrink;
    [self addChild:shapeLevel z:70];
    
    if (level <= 4) {
    playNext = [CCSprite spriteWithFile:@"Play.png"];
    playNext.position = playNextLoc;
    [self addChild:playNext z:70];
    }
    
    if (level >= 2) {
    playPrevious = [CCSprite spriteWithFile:@"Play.png"];
    playPrevious.position = playPrevLoc;
    playPrevious.flipX = YES;
    [self addChild:playPrevious z:70];
    }

}



-(void)animationSetup {
    
    growAnimation = [[CCScaleTo actionWithDuration:0.5f scale:1.1f] retain];
    shrinkAnimation = [[CCScaleTo actionWithDuration:1.0f scale:1.0f] retain];
    guideAnimation = [[CCSequence actions:growAnimation,shrinkAnimation, nil] retain];
    guideForeverAnimation = [[CCRepeatForever actionWithAction:guideAnimation] retain];
    
}

-(void)runAnimation {
    CCLOG(@"Animation");
    if (startExpire || holdExpire) {
            CCLOG(@"Animation2");
        if (objectTouched == 0) {
            [outlineSprite0 runAction:guideForeverAnimation];
        }
        if (objectTouched == 1) {
            [outlineSprite1 runAction:guideForeverAnimation];
        }
        if (objectTouched == 2) {
            [outlineSprite2 runAction:guideForeverAnimation];
        }
        if (objectTouched == 3) {
            [outlineSprite3 runAction:guideForeverAnimation];
        }
    }
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PuzzleLayer *layer = [PuzzleLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)setupOutlineCards
{

    
    outlineSprite0 = [CCSprite spriteWithFile:outlineName0];
    outlineSprite0.position = outlineLoc0;
    outlineSprite0.scale = 0;
    [self addChild:outlineSprite0 z:20];
    
    outlineSprite1 = [CCSprite spriteWithFile:outlineName1];
    outlineSprite1.position = outlineLoc1;
    outlineSprite1.scale = 0;

    [self addChild:outlineSprite1 z:20];

    outlineSprite2 = [CCSprite spriteWithFile:outlineName2];
    outlineSprite2.position = outlineLoc2;
    outlineSprite2.scale = 0;

    [self addChild:outlineSprite2 z:20];

    outlineSprite3 = [CCSprite spriteWithFile:outlineName3];
    outlineSprite3.position = outlineLoc3;
    outlineSprite3.scale = 0;

    [self addChild:outlineSprite3 z:20];
    
    oBox0 = CGRectMake(outlineLoc0.x-50.0f, outlineLoc0.y-50.0f, 100.0f, 100.0f);
    oBox1 = CGRectMake(outlineLoc1.x-50.0f, outlineLoc1.y-50.0f, 100.0f, 100.0f);
    oBox2 = CGRectMake(outlineLoc2.x-50.0f, outlineLoc2.y-50.0f, 100.0f, 100.0f);
    oBox3 = CGRectMake(outlineLoc3.x-50.0f, outlineLoc3.y-50.0f, 100.0f, 100.0f);


}

-(void)setupSideCards
{    
    CCLOG(@"Test1");
    dragSprite0 = [CCSprite spriteWithFile:dragName0];
    dragSprite0.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
    dragSprite0.scale = sideCardShrink;
    [self addChild:dragSprite0 z:50];
    CCLOG(@"Test2");

    dragSprite1 = [CCSprite spriteWithFile:dragName1];
    dragSprite1.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
    dragSprite1.scale = sideCardShrink;

    [self addChild:dragSprite1 z:50];

    dragSprite2 = [CCSprite spriteWithFile:dragName2];
    dragSprite2.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
    dragSprite2.scale = sideCardShrink;

    [self addChild:dragSprite2 z:50];

    dragSprite3 = [CCSprite spriteWithFile:dragName3];
    dragSprite3.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
    dragSprite3.scale = sideCardShrink;

    [self addChild:dragSprite3 z:50];
    
    if (level >= 2) {
        dragSprite4 = [CCSprite spriteWithFile:dragName4];
        dragSprite4.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
        dragSprite4.scale = sideCardShrink;
        
        [self addChild:dragSprite4 z:50];
    }
    if (level >= 3) {
        dragSprite5 = [CCSprite spriteWithFile:dragName5];
        dragSprite5.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
        dragSprite5.scale = sideCardShrink;
        
        [self addChild:dragSprite5 z:50];
    }
    if (level >= 4) {
        dragSprite6 = [CCSprite spriteWithFile:dragName6];
        dragSprite6.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
        dragSprite6.scale = sideCardShrink;
        
        [self addChild:dragSprite6 z:50];
    }
    if (level >= 5) {
        dragSprite7 = [CCSprite spriteWithFile:dragName7];
        dragSprite7.position = CGPointMake(dragLoc0.x, -dragSprite0.boundingBox.size.height);
        dragSprite7.scale = sideCardShrink;
        
        [self addChild:dragSprite7 z:50];
    }
    
    gameSetup = YES;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    holdFlag = NO;
    if (!startExpire) {
    holdTimer = [[NSTimer alloc] init];

    holdTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(holdExpireSelector) userInfo:nil repeats:NO];
    }
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    CGPoint locationInNodeSpace = [self convertToNodeSpace:location];
    
    BOOL touch0 = CGRectContainsPoint(dragSprite0.boundingBox, locationInNodeSpace);
    BOOL touch1 = CGRectContainsPoint(dragSprite1.boundingBox, locationInNodeSpace);
    BOOL touch2 = CGRectContainsPoint(dragSprite2.boundingBox, locationInNodeSpace);
    BOOL touch3 = CGRectContainsPoint(dragSprite3.boundingBox, locationInNodeSpace);
    if (level >= 2) {
    touch4 = CGRectContainsPoint(dragSprite4.boundingBox, locationInNodeSpace);
        if (level >= 3) {

    touch5 = CGRectContainsPoint(dragSprite5.boundingBox, locationInNodeSpace);
            if (level >= 4) {

    touch6 = CGRectContainsPoint(dragSprite6.boundingBox, locationInNodeSpace);
                if (level >= 5) {

    touch7 = CGRectContainsPoint(dragSprite7.boundingBox, locationInNodeSpace);
                }
            }
        }
    }

    if (gameOver) {
        touchAgain = CGRectContainsPoint(playAgain.boundingBox, locationInNodeSpace);
        if (level <=4) {
        touchNext = CGRectContainsPoint(playNext.boundingBox, locationInNodeSpace);
        }
        if (level >= 2) {
        touchPrev = CGRectContainsPoint(playPrevious.boundingBox, locationInNodeSpace);
        }
        touchNum = CGRectContainsPoint(numberLevel.boundingBox, locationInNodeSpace);
        touchShape = CGRectContainsPoint(shapeLevel.boundingBox, locationInNodeSpace);
        touchColour = CGRectContainsPoint(colourLevel.boundingBox, locationInNodeSpace);
        
        if (touchAgain) {
            objectTouched = 100;
        }
        if (touchNext) {
            objectTouched = 101;
        }
        if (touchNext) {
            objectTouched = 102;
        }
        
        if (touchNum) {
            objectTouched = 103;
        }
        
        if (touchShape) {
            objectTouched = 104;
        }
        
        if (touchColour) {
            objectTouched = 105;
        }
    }
    else {
        if (touch0 && !object0Placed) {
            objectTouched = 0;
            dragSprite0.scale = 1.0f;
            [self reorderChild:dragSprite0 z:51];
            dragSprite0.position = locationInNodeSpace;
        }
        else if (touch1 && !object1Placed) {
            objectTouched = 1;
            dragSprite1.scale = 1.0f;
            [self reorderChild:dragSprite1 z:51];
            dragSprite1.position = locationInNodeSpace;
        }
        else if (touch2 && !object2Placed) {
            objectTouched = 2;
            dragSprite2.scale = 1.0f;
            [self reorderChild:dragSprite2 z:51];
            dragSprite2.position = locationInNodeSpace;
        }
        else if (touch3 && !object3Placed) {
            objectTouched = 3;
            dragSprite3.scale = 1.0f;
            [self reorderChild:dragSprite3 z:51];
            dragSprite3.position = locationInNodeSpace;
        }
        else if (touch4) {
            objectTouched = 4;
            dragSprite4.scale = 1.0f;
            [self reorderChild:dragSprite4 z:51];
            dragSprite4.position = locationInNodeSpace;
        }
        else if (touch5) {
            objectTouched = 5;
            dragSprite5.scale = 1.0f;
            [self reorderChild:dragSprite5 z:51];
            dragSprite5.position = locationInNodeSpace;
        }
        else if (touch6) {
            objectTouched = 6;
            dragSprite6.scale = 1.0f;
            [self reorderChild:dragSprite6 z:51];
            dragSprite6.position = locationInNodeSpace;
        }
        else if (touch7) {
            objectTouched = 7;
            dragSprite7.scale = 1.0f;
            [self reorderChild:dragSprite7 z:51];
            dragSprite7.position = locationInNodeSpace;
        }
        
        else {
            objectTouched = 99;
        }
    }
    [self performSelector:@selector(runAnimation)];

    [self performSelector:@selector(textSetup)];


}


- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
	UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    CGPoint locationInNodeSpace = [self convertToNodeSpace:location];
    

    if (objectTouched == 0) {
        dragSprite0.position = locationInNodeSpace;
    }
    else if (objectTouched == 1) {
        dragSprite1.position = locationInNodeSpace;
    }
    else if (objectTouched == 2) {
        dragSprite2.position = locationInNodeSpace;
    }
    else if (objectTouched == 3) {
        dragSprite3.position = locationInNodeSpace;
    }
    else if (objectTouched == 4) {
        dragSprite4.position = locationInNodeSpace;
    }
    else if (objectTouched == 5) {
        dragSprite5.position = locationInNodeSpace;
    }
    else if (objectTouched == 6) {
        dragSprite6.position = locationInNodeSpace;
    }
    else if (objectTouched == 7) {
        dragSprite7.position = locationInNodeSpace;
    }
}

-(void)endingAnim
{
    [self stopAllActions];
    CCLOG(@"endsequence=%d",endSequence);
    if (endSequence == 00) {
            CCLOG(@"intersect0");
        [outlineSprite0 stopAllActions];
            dragSprite0.position = outlineLoc0;
            [self reorderChild:dragSprite0 z:50];
            [self removeChild:outlineSprite0 cleanup:YES];
            object0Placed = YES;
        }
    else if (endSequence == 01) {
        [outlineSprite0 stopAllActions];

        dragSprite0.position = [[dragArray objectAtIndex:0] CGPointValue];
        [self reorderChild:dragSprite0 z:50];
        dragSprite0.scale = sideCardShrink;
    }
    else if (endSequence == 10) {
        [outlineSprite1 stopAllActions];

            CCLOG(@"intersect1");
            dragSprite1.position = outlineLoc1;
        [self reorderChild:dragSprite1 z:50];

            [self removeChild:outlineSprite1 cleanup:YES];
            object1Placed = YES;
        }
    else if (endSequence ==11) {
        [outlineSprite1 stopAllActions];

            dragSprite1.position = [[dragArray objectAtIndex:1] CGPointValue];
        [self reorderChild:dragSprite1 z:50];

            dragSprite1.scale = sideCardShrink;
        }
    else if (endSequence == 20) {
        [outlineSprite2 stopAllActions];

            CCLOG(@"intersect2");
            dragSprite2.position = outlineLoc2;
        [self reorderChild:dragSprite2 z:50];

            [self removeChild:outlineSprite2 cleanup:YES];
            object2Placed = YES;
        }
    else if (endSequence == 21) {
        [outlineSprite2 stopAllActions];

            dragSprite2.position = [[dragArray objectAtIndex:2] CGPointValue];
        [self reorderChild:dragSprite2 z:50];

            dragSprite2.scale = sideCardShrink;
        }
    else if (endSequence == 30) {
        [outlineSprite3 stopAllActions];

            CCLOG(@"intersect3");
            dragSprite3.position = outlineLoc3;
        [self reorderChild:dragSprite3 z:50];

            [self removeChild:outlineSprite3 cleanup:YES];
            object3Placed = YES;
        }
    else if (endSequence == 31) {
        [outlineSprite3 stopAllActions];

            dragSprite3.position = [[dragArray objectAtIndex:3] CGPointValue];
        [self reorderChild:dragSprite3 z:50];

            dragSprite3.scale = sideCardShrink;
        }
    else if (endSequence == 41) {
        dragSprite4.position = [[dragArray objectAtIndex:4] CGPointValue];
        [self reorderChild:dragSprite4 z:50];
        
        dragSprite4.scale = sideCardShrink;
    }
    else if (endSequence == 51) {
        dragSprite5.position = [[dragArray objectAtIndex:5] CGPointValue];
        [self reorderChild:dragSprite5 z:50];
        
        dragSprite5.scale = sideCardShrink;
    }
    else if (endSequence == 61) {
        dragSprite6.position = [[dragArray objectAtIndex:6] CGPointValue];
        [self reorderChild:dragSprite6 z:50];
        
        dragSprite6.scale = sideCardShrink;
    }
    else if (endSequence == 71) {
        dragSprite7.position = [[dragArray objectAtIndex:7] CGPointValue];
        [self reorderChild:dragSprite7 z:50];
        
        dragSprite7.scale = sideCardShrink;
    }
    
    objectTouched = 99;
    if (object0Placed && object1Placed && object2Placed && object3Placed) {
        gameOver =YES;
    }
    
    if (gameOver) {
        [self performSelector:@selector(endGame)];
        
    }


}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!holdExpire) {
    [holdTimer invalidate];
    }
    holdTimer = nil;
    holdExpire = NO;

    if ((touchAgain || touchNext || touchPrev || numberLevel || shapeLevel || colourLevel) && gameOver)
    {
        if (touchNext) {
            level++;
            if (level ==6) {
                level = 5;
            }
        }
        if (touchPrev) {
            level--;
            if (level ==0) {
                level = 1;
            }
        }
        if (touchNum) {
            if (!(gameMode == kNumberMode)) {
                level = 1;
            }
            gameMode = kNumberMode;
        }
        if (touchShape) {
            if (!(gameMode == kShapesMode)) {
                level = 1;
            }
            gameMode = kShapesMode;
        }
        if (touchColour) {
            if (!(gameMode == kColourMode)) {
                level = 1;
            }
            gameMode = kColourMode;
        }
        [self removeAllChildrenWithCleanup:YES];
        [self performSelector:@selector(restartInit)];
        [self performSelector:@selector(randomizeObjects)];
        [self performSelector:@selector(setupOutlineCards)];
        [self performSelector:@selector(setupSideCards)];
        [self performSelector:@selector(startAnimation)];

        
    }
    CCLOG(@"Touches Ended");
    CCLOG(@"objectTouched=%d",objectTouched);
    dBox0 = dragSprite0.boundingBox;
    dBox1 = dragSprite1.boundingBox;
    dBox2 = dragSprite2.boundingBox;
    dBox3 = dragSprite3.boundingBox;

    BOOL intersect0 = CGRectContainsRect(dBox0, oBox0);
    BOOL intersect1 = CGRectContainsRect(dBox1, oBox1);
    BOOL intersect2 = CGRectContainsRect(dBox2, oBox2);
    BOOL intersect3 = CGRectContainsRect(dBox3, oBox3);
    
    if (objectTouched == 0) {
        if (intersect0) {
            endSequence = 00;
        }
        else {
            endSequence = 01;

        }
    }
    else if (objectTouched == 1) {
        if (intersect1) {
            endSequence = 10;
        }
        else {
            endSequence = 11;
        }
    }
    else if (objectTouched == 2) {
        if (intersect2) {
            endSequence = 20;
        }
        else {
            endSequence = 21;
        }
    }
    else if (objectTouched == 3) {
        if (intersect3) {
            endSequence = 30;
        }
        else {
            endSequence = 31;
        }
    }
    else if (objectTouched == 4) {
            endSequence = 41;
    }
    else if (objectTouched == 5) {
            endSequence = 51;
    }
    else if (objectTouched == 6) {
            endSequence = 61;
    }
    else if (objectTouched == 7) {
            endSequence = 71;
    }
    else {
        endSequence = 99;
    }

    [self performSelector:@selector(endingAnim) withObject:nil afterDelay:0.01f];


}

@end
