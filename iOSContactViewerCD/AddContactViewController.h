//
//  AddContactViewController.h
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol AddContactViewControllerDelegate;
@interface AddContactViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) Contact *contactDetail;


@end


@protocol AddContactViewControllerDelegate

// delegate methods
- (void)addContactViewControllerCancel:(Contact *)contact;
- (void)addContactViewControllerSave;

@end

