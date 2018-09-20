//
//  Node.h
//  CartControl
//
//  Created by Biswajeet Das on 13/07/18.
//  Copyright © 2018 Biswajeet Das. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NodeNotActive = 0,
    NodeActive,
    NodeCompleted
} NodeState;

typedef enum {
    Intial = 0,
    Intermediate,
    Terminal
} NodePosition;

@interface Node : UIView

@property (nonatomic, strong) NSString *nodeTitle;
@property (nonatomic, strong) NSString *nodeIdentifier;
@property (nonatomic, strong) UIImage *nodeActiveStateImage;
@property (nonatomic, strong) UIImage *nodeInactiveStateImage;
@property (nonatomic, strong) UIImage *nodeCompletedStateImage;
@property (nonatomic, strong) UIColor *activeStateTextColor;
@property (nonatomic, strong) UIColor *inActiveStateTextColor;
@property (nonatomic, strong) UIFont *nodeFont;
@property (nonatomic, assign) NodeState state;
@property (nonatomic, assign) NodePosition nodePosition;
@property (nonatomic, strong) UIColor *activeTheme;
@property (nonatomic, strong) UIColor *inActiveTheme;
@end
