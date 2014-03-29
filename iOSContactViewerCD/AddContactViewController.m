//
//  AddContactViewController.m
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

@property (strong, nonatomic) IBOutlet UIPickerView *titlePickerField;
@property (strong, nonatomic) IBOutlet UILabel *titleLabelField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *twitterIdTextField;

@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSArray *titles;


- (IBAction)saveButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)textFieldDidEndEditing:(id)sender;
- (IBAction)titleOutOfFocus;
- (void)titleOnFocus;
@end

@implementation AddContactViewController

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
#pragma mark - End Implementing methods

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
    _titles = [[NSArray alloc] initWithObjects:@"Mr",@"Mrs",@"Ms",@"Miss",@"Dr",@"Captain",@"Master", nil];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleOnFocus)];
    [self.titleLabelField addGestureRecognizer:self.tapGestureRecognizer];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
    //name cannot be blank validation
    if(self.nameTextField.text == NULL || self.nameTextField.text.length==0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Name Cannot Be Blank"
                                                       delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    
    }
    else
    {
        
    
    self.contactDetail.name = self.nameTextField.text;
    self.contactDetail.title = self.titleLabelField.text;
    self.contactDetail.phone = self.phoneTextField.text;
    self.contactDetail.email = self.emailTextField.text;
    self.contactDetail.twitterId = self.twitterIdTextField.text;
    
    [self.delegate addContactViewControllerSave];
}
}

- (IBAction)cancelButton:(id)sender {
    
    [self.delegate addContactViewControllerCancel:self.contactDetail];
}

- (IBAction)textFieldDidEndEditing:(id)sender {
    [sender resignFirstResponder];
}

- (void)titleOnFocus {
    
    if (self.titlePickerField.hidden)
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
