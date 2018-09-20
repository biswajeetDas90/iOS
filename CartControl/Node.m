//
//  Node.m
//  CartControl
//
//  Created by Biswajeet Das on 13/07/18.
//  Copyright © 2018 Biswajeet Das. All rights reserved.
//

#import "Node.h"

@interface Node ()
@property (weak, nonatomic) IBOutlet UIView *leadingConnector;
@property (weak, nonatomic) IBOutlet UIView *trailingConnector;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *nodeCenter;
@property (strong, nonatomic) UIView *container;
@end

@implementation Node

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"Node" owner:self options:nil] objectAtIndex:0];
    self.container = rootView;
    [self addSubview:rootView];
    //self.state = NodeNotActive;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"Node" owner:self options:nil] objectAtIndex:0];
    [self addSubview:rootView];
    return self;
}

- (void)layoutSubviews
{
    [self addConstraintsIntoView:self.container];
    [self sendSubviewToBack:self.leadingConnector];
}

- (void)addConstraintsIntoView:(UIView *)subView
{
    UIView *parent=self;
    
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                         constraintWithItem:subView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:parent
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0
                                         constant:0];
    
    //Top
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0];
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:0.f];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint
                                  constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:parent
                                  attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                  constant:0];
    
    [parent addConstraints:@[topConstraint,leading,trailing,bottom]];

}

- (void)setNodeTitle:(NSString *)nodeTitle
{
    self.title.text = nodeTitle;
}

- (void)setNodeIdentifier:(NSString *)nodeIdentifier
{
    self.nodeCenter.titleLabel.text = nodeIdentifier;
}

- (void)setState:(NodeState)state
{
    switch (state) {
        case NodeNotActive:
            [self updateNodeForInctiveState];
            break;
        case NodeActive:
            [self updateNodeForActiveState];
            break;
        case NodeCompleted:
            [self updateNodeForCompletedState];
        default:
            break;
    }
}


- (void)updateNodeForActiveState
{
    [self.nodeCenter setBackgroundImage:self.nodeActiveStateImage forState:UIControlStateNormal];
    self.title.textColor = self.activeStateTextColor;
    self.trailingConnector.backgroundColor = self.inActiveTheme;
    self.leadingConnector.backgroundColor = self.activeTheme;
}

- (void)updateNodeForInctiveState
{
    [self.nodeCenter setBackgroundImage:self.nodeInactiveStateImage forState:UIControlStateNormal];
    self.title.textColor = self.inActiveStateTextColor;
    self.trailingConnector.backgroundColor = self.inActiveTheme;
    self.leadingConnector.backgroundColor = self.inActiveTheme;
}

- (void)updateNodeForCompletedState
{
    [self.nodeCenter setBackgroundImage:self.nodeCompletedStateImage forState:UIControlStateNormal];
    self.title.textColor = self.inActiveStateTextColor;
    self.trailingConnector.backgroundColor = self.activeTheme;
    self.leadingConnector.backgroundColor = self.activeTheme;
}

- (void)setNodePosition:(NodePosition)nodePosition
{
    switch (nodePosition) {
        case Intial:
            self.leadingConnector.hidden = YES;
            break;
        case Terminal:
            self.trailingConnector.hidden = YES;
            break;
        default:
            break;
    }
}


@end
