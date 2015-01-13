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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FSAlertController *alertController = [FSAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:FSAlertControllerStyleAlert];
    [alertController showInViewController:self animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    FSAlertController *alertController = [FSAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:FSAlertControllerStyleAlert];
    [alertController addAction:[FSAlertAction actionWithTitle:@"red" style:FSAlertActionStyleDefault handler:^(FSAlertAction *action) {
        [self.view setBackgroundColor:[UIColor redColor]];
    }]];
    [alertController showInViewController:self animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
