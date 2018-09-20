//
//  CartControl.m
//  CartControl
//
//  Created by Biswajeet Das on 19/07/18.
//  Copyright © 2018 Biswajeet Das. All rights reserved.
//

#import "CartControl.h"
#import "Node.h"

@interface CartControl()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *allNodes;
@property (nonatomic, strong) NSArray *nodeTitles;
@end

@implementation CartControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.backgroundColor = [UIColor greenColor];
    UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"CartControl" owner:self options:nil] objectAtIndex:0];
    rootView.frame = self.bounds;
    self.containerView = rootView;
    [self addSubview:rootView];
    [self addConstraintsIntoView:rootView andParent:self];
    return self;
}


- (void)layoutSubviews
{
    //[self initializeNodes];
}

- (void)addConstraintsIntoView:(UIView *)subView andParent:(UIView *)parent
{
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Top
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                         constraintWithItem:subView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:parent
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0
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
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeLeading
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
    
    [parent addConstraints:@[topConstraint,trailing,leading,bottom]];
    
}

- (void)initializeNodes
{
    CGFloat position = 0.0;
    CGFloat width = self.frame.size.width / self.numberOfNodes;
    self.allNodes = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<self.numberOfNodes; i++) {
        CGRect frame = CGRectMake(position, 0, width, self.containerView.frame.size.height);
        Node *node = [[Node alloc] initWithFrame:frame];
        [self.containerView addSubview:node];
        position += width;
        [self.allNodes addObject:node];
        if ([self.delegate conformsToProtocol:@protocol(NodeDataSource)]) {
            node.nodeActiveStateImage = [self.delegate selectedImage];
            node.nodeInactiveStateImage = [self.delegate unSelectedImage];
            node.nodeCompletedStateImage = [self.delegate completedImage];
            NSString *titleString = self.nodeTitles[i];
            node.nodeTitle = titleString;
            node.activeStateTextColor = [self.delegate activeTextColor];
            node.inActiveStateTextColor = [self.delegate inactiveTextColor];
            node.activeTheme = [self.delegate activeThemeColor];
            node.inActiveTheme = [self.delegate inActiveThemeColor];
        }
        node.state = NodeNotActive;
    }
    Node *first = [self.allNodes firstObject];
    first.nodePosition = Intial;
    first.state = NodeActive;
    
    Node *last = [self.allNodes lastObject];
    last.nodePosition = Terminal;
    
}

- (void)setSelectedState:(NSInteger)selectedState
{
    if (selectedState > self.numberOfNodes || selectedState < 1) {
        return;
    }
    _selectedState = selectedState;
    
    for (NSInteger i=selectedState; i<self.allNodes.count; i++) {
        Node *inactiveNode = [self.allNodes objectAtIndex:i];
        inactiveNode.state = NodeNotActive;
    }
    
    Node *selectedNode = [self.allNodes objectAtIndex:selectedState-1];
    selectedNode.state = NodeActive;
    
    for (NSInteger i=selectedState-2; i>=0; i--) {
        Node *completedNode = [self.allNodes objectAtIndex:i];
        completedNode.state = NodeCompleted;
    }
}

- (void)setDelegate:(id<NodeDataSource>)delegate
{
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(nodeElements)]) {
        self.nodeTitles = [delegate nodeElements];
    }
}

- (void)setNumberOfNodes:(NSInteger)numberOfNodes
{
    _numberOfNodes = numberOfNodes;
    [self initializeNodes];
}

@end
