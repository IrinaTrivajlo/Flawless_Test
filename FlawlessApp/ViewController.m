//
//  ViewController.m
//  FlawlessApp
//
//  Created by Ирина on 23.07.18.
//  Copyright © 2018 trivajlo. All rights reserved.
//

#import "ViewController.h"
#import "SocketManagerClass.h"
#import "MessageCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 66.0;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    /*
     NSString *identifierForVendor = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
     NSString *tokenEndpoint = @"http://localhost:8000/token.php?device=%@";
     NSString *urlString = [NSString stringWithFormat:tokenEndpoint, identifierForVendor];
     
     NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
     
     if (jsonResponse) {
     NSError *jsonError;
     NSDictionary *tokenResponse = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&jsonError];
     
     NSLog(@"tokenResponse %@", tokenResponse);
     }
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI helpers
- (void)scrollToBottomMessage
{
    int row = (int) [self.tableView numberOfRowsInSection:0] - 1;
    NSIndexPath *bottomMessageIndex = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView scrollToRowAtIndexPath:bottomMessageIndex atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    NSLog(@"keyboardHeight is %f", keyboardHeight);
    
    [self.view setNeedsLayout];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    [self scrollToBottomMessage];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.view setNeedsLayout];
}

- (IBAction)viewTapped:(id)sender
{
    [self.textField resignFirstResponder];
}

- (IBAction)connectAction:(id)sender {
    
    [[SocketManagerClass sharedInstance] initializeSocket];
}

#pragma mark - UITableViewDelegate methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - UITextFieldDelegate methods
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField.text.length == 0) {
        [self.view endEditing:YES];
    }
    else
    {
        
    }
    return YES;
}

@end
