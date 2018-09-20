//
//  ViewController.m
//  CartControl
//
//  Created by Biswajeet Das on 13/07/18.
//  Copyright © 2018 Biswajeet Das. All rights reserved.
//

#import "ViewController.h"
#import "CartControl.h"

@interface ViewController () <NodeDataSource>
@property (weak, nonatomic) IBOutlet CartControl *cartControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.cartControl.delegate = self;
    self.cartControl.numberOfNodes = 4;
    self.cartControl.selectedState = 1;
}
- (UIImage *)selectedImage
{
    return [UIImage imageNamed:@"blue_dot.png"];
}
- (UIImage *)unSelectedImage
{
    return [UIImage imageNamed:@"grey_dot.png"];
}
- (UIImage *)completedImage
{
    return [UIImage imageNamed:@"red_dot.png"];
}

- (IBAction)next:(id)sender {
    self.cartControl.selectedState++;
}
- (IBAction)prev:(id)sender {
    self.cartControl.selectedState--;
}
- (NSArray *)nodeElements
{
    return @[@"Level1",@"Level2",@"Level3",@"Level4"];
}
- (UIColor *)activeTextColor
{
    return [UIColor blackColor];
}
- (UIColor *)inactiveTextColor
{
    return [UIColor grayColor];
}
- (UIColor *)activeThemeColor
{
    return [UIColor greenColor];
}
- (UIColor *)inActiveThemeColor
{
    return [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
