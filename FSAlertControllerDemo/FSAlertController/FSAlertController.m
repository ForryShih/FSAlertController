//
//  FSAlertController.m
//  FSAlertControllerDemo
//
//  Created by ForryShih on 1/13/15.
//  Copyright (c) 2015 Rampage Works. All rights reserved.
//

#import "FSAlertController.h"

typedef void(^FSAlertActionBlock)(FSAlertAction *action);

@interface FSAlertAction ()

@property (copy) FSAlertActionBlock handler;

@end

@implementation FSAlertAction

- (instancetype)initWithTitle:(NSString *)title style:(FSAlertActionStyle)style handler:(void (^)(FSAlertAction *action))handler
{
    self = [super init];
    
    if (self)
    {
        _title = title;
        _style = style;
        _handler = handler;
    }
    
    return self;
    
}

+ (instancetype)actionWithTitle:(NSString *)title style:(FSAlertActionStyle)style handler:(void (^)(FSAlertAction *action))handler
{
    FSAlertAction *alertAction = [[FSAlertAction alloc] initWithTitle:title style:style handler:handler];
    return alertAction;
}

@end


@implementation FSAlertController

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(FSAlertControllerStyle)preferredStyle
{
    self = [super init];
    
    if (self)
    {
        _title = title;
        _message = message;
        _preferredStyle = preferredStyle;
        _actions = [NSArray new];
    }
    
    return self;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(FSAlertControllerStyle)preferredStyle
{
    FSAlertController *alertController = [[FSAlertController alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
    return alertController;
}

- (BOOL)systemVersionIsIOS8OrLater
{
    return ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending);
}

- (void)addAction:(FSAlertAction *)action
{
    if (_actions)
    {
        _actions = [_actions arrayByAddingObject:action];
    }
}

- (void)showInViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    if ([self systemVersionIsIOS8OrLater])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:(UIAlertControllerStyle)_preferredStyle];
        for (FSAlertAction *fsAlertAction in _actions)
        {
            UIAlertAction *uiAlertAction = [UIAlertAction actionWithTitle:fsAlertAction.title style:(UIAlertActionStyle)fsAlertAction.style handler:^(UIAlertAction *action){
                fsAlertAction.handler(nil);
            }];
            [alertController addAction:uiAlertAction];
        }
        [viewController presentViewController:alertController animated:animated completion:completion];
    }
}

@end
