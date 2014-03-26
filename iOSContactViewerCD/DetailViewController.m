//
//  DetailViewController.m
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import "DetailViewController.h"
#import "COntact.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *twitterIdTextField;

@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UIButton *smsButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;

@property BOOL isEditMode;

- (void)configureView;
- (void)displayContactActionControls:(BOOL)show;
- (void)editContact;
- (IBAction)call:(id)sender;
- (IBAction)launchSMS:(id)sender;
- (IBAction)launchEmail:(id)sender;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.contactDetail) {
        self.titleTextField.text = [[self.contactDetail valueForKey:@"title"] description];
        self.nameTextField.text = [[self.contactDetail valueForKey:@"name"] description];
        self.phoneTextField.text = [[self.contactDetail valueForKey:@"phone"] description];
        self.emailTextField.text = [[self.contactDetail valueForKey:@"email"] description];
        self.twitterIdTextField.text = [[self.contactDetail valueForKey:@"twitterId"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.action = @selector(editContact);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)call:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.contactDetail.phone]]];
}

- (IBAction)launchSMS:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", self.contactDetail.phone]]];
}

- (IBAction)launchEmail:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.contactDetail.email]]];
}

- (void)displayContactActionControls:(BOOL)hidden
{
    self.callButton.hidden = hidden;
    self.smsButton.hidden = hidden;
    self.emailButton.hidden = hidden;
}

- (void)editContact
{
    
    if (!self.isEditMode)
    {
        
        // start editing
        self.isEditMode = YES;
        
        // hide contact action controls
        [self displayContactActionControls:YES];
        
        // change title and enable text fields
        self.navigationItem.title = @"Edit Contact";
        self.titleTextField.enabled = YES;
        self.titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.nameTextField.enabled = YES;
        self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.phoneTextField.enabled = YES;
        self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.emailTextField.enabled = YES;
        self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.twitterIdTextField.enabled = YES;
        self.twitterIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        // change right top button
        UIBarButtonItem *myButton = [[UIBarButtonItem alloc]init];
        myButton.action = @selector(finishEditing);
        myButton.title = @"Done";
        myButton.target = self;
        
        // then we add the button to the navigation bar
        self.navigationItem.rightBarButtonItem = myButton;
        
    }
    
}

- (void)finishEditing
{
    
    // stop editing - save values
    self.isEditMode = NO;
    
    // show contact action controls
    [self displayContactActionControls:NO];
    
    // change title and enable text fields
    self.navigationItem.title = @"Contact";
    self.titleTextField.enabled = NO;
    self.titleTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.enabled = NO;
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.enabled = NO;
    self.phoneTextField.borderStyle = UITextBorderStyleNone;
    self.emailTextField.enabled = NO;
    self.emailTextField.borderStyle = UITextBorderStyleNone;
    self.twitterIdTextField.enabled = NO;
    self.twitterIdTextField.borderStyle = UITextBorderStyleNone;
    
    // pass all fields back to contactDetail item
    self.contactDetail.name = self.nameTextField.text;
    self.contactDetail.title = self.titleTextField.text;
    self.contactDetail.phone = self.phoneTextField.text;
    self.contactDetail.email = self.emailTextField.text;
    self.contactDetail.twitterId = self.twitterIdTextField.text;
    
    // change right top button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // selector called when user is done editing
    [self.delegate detailViewDidSave:nil];
}

@end
