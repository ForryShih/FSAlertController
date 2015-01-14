//
//  FSAlertController.h
//  FSAlertController
//
//  Created by ForryShih on 1/13/15.
//  Copyright (c) 2015 Rampage Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FSAlertActionStyle) {
    FSAlertActionStyleDefault = 0,
    FSAlertActionStyleCancel,
    FSAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, FSAlertControllerStyle) {
    FSAlertControllerStyleActionSheet = 0,
    FSAlertControllerStyleAlert
};


@interface FSAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(FSAlertActionStyle)style handler:(void (^)(FSAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) FSAlertActionStyle style;
@property (nonatomic, getter = isEnabled) BOOL enabled;

@end


@interface FSAlertController : NSObject <UIAlertViewDelegate, UIActionSheetDelegate, UIPopoverPresentationControllerDelegate>

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(FSAlertControllerStyle)preferredStyle;

- (void)addAction:(FSAlertAction *)action;
//- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;
- (void)showInViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

@property (nonatomic, readonly) NSArray *actions;
//@property (nonatomic, readonly) NSArray *textFields;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, readonly) FSAlertControllerStyle preferredStyle;

@end


