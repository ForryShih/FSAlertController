//
//  FSAlertController.m
//  FSAlertController
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
                if (fsAlertAction.handler)
                {
                    fsAlertAction.handler(nil);
                }
            }];
            [alertController addAction:uiAlertAction];
        }
        
        UIPopoverPresentationController *ppc = alertController.popoverPresentationController;
        if (ppc)
        {
            ppc.delegate = self;
            ppc.sourceView = viewController.view;
            ppc.sourceRect = CGRectMake(ppc.sourceView.bounds.size.width * 0.5f, ppc.sourceView.bounds.size.height * 0.5f, 0.0f, 0.0f);
            // Do not display arrow.
            ppc.permittedArrowDirections = 0;
        }
        
        [viewController presentViewController:alertController animated:animated completion:completion];
    }
    else
    {
        if (_preferredStyle == FSAlertControllerStyleAlert)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            for (FSAlertAction *alertAction in _actions)
            {
                [alertView addButtonWithTitle:alertAction.title];
                
                if (alertAction.style == FSAlertActionStyleCancel)
                {
                    alertView.cancelButtonIndex = [_actions indexOfObject:alertAction];
                }
            }
            
            [alertView show];
        }
        else if (_preferredStyle == FSAlertControllerStyleActionSheet)
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:_title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            for (FSAlertAction *alertAction in _actions)
            {
                [actionSheet addButtonWithTitle:alertAction.title];
                
                if (alertAction.style == FSAlertActionStyleCancel)
                {
                    actionSheet.cancelButtonIndex = [_actions indexOfObject:alertAction];
                }
                
                if (alertAction.style == FSAlertActionStyleDestructive)
                {
                    actionSheet.destructiveButtonIndex = [_actions indexOfObject:alertAction];
                }
            }
            
            [actionSheet showInView:viewController.view];
        }
    }
}

- (void)clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0 && buttonIndex < [_actions count])
    {
        FSAlertAction *alertAction = [_actions objectAtIndex:buttonIndex];
        if (alertAction.handler)
        {
            alertAction.handler(nil);
        }
    }
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self clickedButtonAtIndex:buttonIndex];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self clickedButtonAtIndex:buttonIndex];
}

#pragma mark - UIPopoverPresentationControllerDelegate Methods;

- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing *)view
{
    *rect = CGRectMake((*view).bounds.size.width * 0.5f, (*view).bounds.size.height * 0.5f, 0.0f, 0.0f);
}

@end
