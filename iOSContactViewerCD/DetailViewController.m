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

@property (strong, nonatomic) IBOutlet UIPickerView *titlePickerField;
@property (strong, nonatomic) IBOutlet UILabel *titleLabelField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *twitterIdTextField;

@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UIButton *smsButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet UIImageView *dropdownImage;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@property BOOL isEditMode;
@property (nonatomic, strong) NSArray *titles;


- (void)configureView;
- (void)displayContactActionControls:(BOOL)show;
- (void)editContact;
- (void)titleOnFocus;
- (IBAction)textFieldDidEndEditing:(id)sender;
- (IBAction)titleOutOfFocus;

- (IBAction)call:(id)sender;
- (IBAction)launchSMS:(id)sender;
- (IBAction)launchEmail:(id)sender;
@end

@implementation DetailViewController

#pragma mark - Implementing methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titles count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_titles objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.titleLabelField.text =[_titles objectAtIndex:row];
}

#pragma mark - Managing the detail item


- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.contactDetail) {
        self.titleLabelField.text = [[self.contactDetail valueForKey:@"title"] description];
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
    
    _titles = [[NSArray alloc] initWithObjects:@"Mr",@"Mrs",@"Ms",@"Miss",@"Dr",@"Captain",@"Master", nil];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleOnFocus)];
    [self.titleLabelField addGestureRecognizer:self.tapGestureRecognizer];

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
        
        self.dropdownImage.hidden = NO;
        
        // then we add the button to the navigation bar
        self.navigationItem.rightBarButtonItem = myButton;
        
    }
    
}

- (void)finishEditing
{
    
    
    //name cannot be blank validation
    if(self.nameTextField.text == NULL || self.nameTextField.text.length==0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Name Cannot Be Blank"
                                                       delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        
    }
    else {
    // stop editing - save values
    self.isEditMode = NO;
    
    // show contact action controls
    [self displayContactActionControls:NO];
    
    // change title and enable text fields
    self.navigationItem.title = @"Contact";
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
    self.contactDetail.title = self.titleLabelField.text;
    self.contactDetail.phone = self.phoneTextField.text;
    self.contactDetail.email = self.emailTextField.text;
    self.contactDetail.twitterId = self.twitterIdTextField.text;
    
    // change right top button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dropdownImage.hidden = YES;
        
    [self titleOnFocus];
    // selector called when user is done editing
    [self.delegate detailViewDidSave:nil];
}
}

- (IBAction)textFieldDidEndEditing:(id)sender {
    [sender resignFirstResponder];
}


- (void)titleOnFocus {
    
        if (self.titlePickerField.hidden && self.isEditMode)
            self.titlePickerField.hidden=NO;
        else
            
            self.titlePickerField.hidden=YES;
        
        self.doneButton.hidden = self.titlePickerField.hidden;
        [self.view endEditing:YES];
}

- (IBAction)titleOutOfFocus {
    
    if(self.titlePickerField.hidden==NO)
    {
        self.titlePickerField.hidden=YES;
        self.doneButton.hidden = self.titlePickerField.hidden;
    }
}

@end
