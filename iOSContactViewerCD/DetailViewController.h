//
//  DetailViewController.h
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol DetailViewDelegate;
@interface DetailViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) Contact *contactDetail;
@property (weak, nonatomic) id <DetailViewDelegate> delegate;

@end

@protocol DetailViewDelegate

- (void)detailViewDidSave:(Contact *)contact;

@end