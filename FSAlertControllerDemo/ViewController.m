//
//  ViewController.m
//  FSAlertControllerDemo
//
//  Created by ForryShih on 1/13/15.
//  Copyright (c) 2015 Rampage Works. All rights reserved.
//

#import "ViewController.h"
#import "FSAlertController.h"

@interface ViewController ()

//@property (nonatomic, strong) FSAlertController *alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showAlertController:(UIButton *)sender
{
    FSAlertControllerStyle style;
    if ([sender.titleLabel.text isEqualToString:@"ShowAlertButton"])
    {
        style = FSAlertControllerStyleAlert;
    }
    else
    {
        style = FSAlertControllerStyleActionSheet;
    }
    
    FSAlertController *_alertController = [FSAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:style];
    [_alertController addAction:[FSAlertAction actionWithTitle:@"red" style:FSAlertActionStyleDestructive handler:^(FSAlertAction *action) {
        [self.view setBackgroundColor:[UIColor redColor]];
    }]];
    [_alertController addAction:[FSAlertAction actionWithTitle:@"black" style:FSAlertActionStyleDefault handler:^(FSAlertAction *action) {
        [self.view setBackgroundColor:[UIColor blackColor]];
    }]];
    [_alertController addAction:[FSAlertAction actionWithTitle:@"Cancel" style:FSAlertActionStyleCancel handler:nil]];
    [_alertController showInViewController:self animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
