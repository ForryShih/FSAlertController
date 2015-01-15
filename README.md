# FSAlertController
Show UIAlertView and UIActionSheet in iOS 7, but show UIAlertController in iOS 8 or later.


Usage:

//FSAlertController object must be a global variable. Otherwise, app will crash after alertController was released.
@property (nonatomic, strong) FSAlertController *alertController;

- (IBAction)showAlertController:(UIButton *)sender
{
    FSAlertControllerStyle style;
    if ([sender.titleLabel.text isEqualToString:@"ShowAlertButton"])
    {
        style = FSAlertControllerStyleAlert;
    }
    else
    {
        style = FSAlertControllerStyleActionSheet;
    }
    
    _alertController = [FSAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:style];
    
    [_alertController addAction:[FSAlertAction actionWithTitle:@"red" style:FSAlertActionStyleDestructive handler:^(FSAlertAction *action) {
        [self.view setBackgroundColor:[UIColor redColor]];
    }]];
    [_alertController addAction:[FSAlertAction actionWithTitle:@"black" style:FSAlertActionStyleDefault handler:^(FSAlertAction *action) {
        [self.view setBackgroundColor:[UIColor blackColor]];
    }]];
    [_alertController addAction:[FSAlertAction actionWithTitle:@"Cancel" style:FSAlertActionStyleCancel handler:nil]];
    
    [_alertController showInViewController:self animated:YES completion:nil];
}
