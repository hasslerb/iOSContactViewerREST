//
//  AddContactViewController.m
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *twitterIdTextField;


- (IBAction)saveButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)textFieldDidEndEditing:(id)sender;
@end

@implementation AddContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
    
    self.contactDetail.name = self.nameTextField.text;
    self.contactDetail.title = self.titleTextField.text;
    self.contactDetail.phone = self.phoneTextField.text;
    self.contactDetail.email = self.emailTextField.text;
    self.contactDetail.twitterId = self.twitterIdTextField.text;
    
    [self.delegate addContactViewControllerSave];
}

- (IBAction)cancelButton:(id)sender {
    
    [self.delegate addContactViewControllerCancel:self.contactDetail];
}

- (IBAction)textFieldDidEndEditing:(id)sender {
    [sender resignFirstResponder];
}

@end
