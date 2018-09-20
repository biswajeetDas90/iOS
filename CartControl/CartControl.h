//
//  CartControl.h
//  CartControl
//
//  Created by Biswajeet Das on 19/07/18.
//  Copyright © 2018 Biswajeet Das. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NodeDataSource <NSObject>
@optional
- (NSArray *)nodeElements;
- (UIColor *)activeThemeColor;
- (UIColor *)inActiveThemeColor;
- (UIImage *)selectedImage;
- (UIImage *)unSelectedImage;
- (UIImage *)completedImage;
- (UIColor *)activeTextColor;
- (UIColor *)inactiveTextColor;
@end

@interface CartControl : UIView

@property (nonatomic, assign) NSInteger numberOfNodes;//Default is 2

@property (nonatomic, assign) NSInteger selectedState;

@property (nonatomic, assign) id <NodeDataSource> delegate;
@end
