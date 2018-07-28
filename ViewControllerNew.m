#import "ViewControllerNew.h"
#import "DataManager.h"
#import "Transaction.h"

@implementation ViewControllerNew
{
    int currentDateSliderVal;
    
    DataManager *dm;
    Transaction *t;
    
    UIPickerView *categoryPicker;
    NSMutableArray *categories;
    
    UITextField *costTextField;
    UITextField *descTextField;
    
    UIButton *backButton;
    UIButton *enterButton;
    
    UILabel *errorLabel;
    UILabel *newTitleLabel;
    
    UILabel *dateLabel;
    NSDate *date;
}

- (id)initWithDataManager:(DataManager *)dataMgr
{
    self = [super init];
    
    if (self)
        dm = dataMgr;
    
    return self;
}


- (id)initWithDataManager:(DataManager *)dataMgr transaction:(Transaction *)tr
{
    self = [self initWithDataManager:dataMgr];
    
    if (self)
        t = tr;
    
    return self;
}


- (void)viewDidLoad
{
    CGRect rect;
    
    UILabel *descTitleLabel;
    UILabel *costTitleLabel;

    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];


    /* Title label */
    rect = CGRectMake(30.0, 40.0, 220.0, 35.0);
    newTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [newTitleLabel setFont:[newTitleLabel.font fontWithSize:28]];
    [self.view addSubview:newTitleLabel];
    

    /* Back button */
    rect = CGRectMake(30.0, 80.0, 50.0, 25.0);
    backButton = [[UIButton alloc] initWithFrame:rect];
    [backButton addTarget:self action:@selector(backButtonClicked)
                    forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment
                   = UIControlContentHorizontalAlignmentLeft;
    [backButton setTitleColor:[UIColor blueColor]
                    forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor]
                    forState:UIControlStateHighlighted];
    [self.view addSubview:backButton];

    
    /* Enter button */
    rect = CGRectMake(30.0, 340.0, 60.0, 25.0);
    enterButton = [[UIButton alloc] initWithFrame:rect];
    [enterButton addTarget:self action:@selector(enterButtonClicked)
                     forControlEvents:UIControlEventTouchUpInside];
    [enterButton setTitle:@"Enter" forState:UIControlStateNormal];
    enterButton.contentHorizontalAlignment
                    = UIControlContentHorizontalAlignmentLeft;
    [enterButton setTitleColor:[UIColor blueColor]
                     forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor grayColor]
                     forState:UIControlStateHighlighted];
    [self.view addSubview:enterButton];
    
    
    /* Error label */
    rect = CGRectMake(30.0, 305.0, 300.0, 30.0);
    errorLabel = [[UILabel alloc] initWithFrame:rect];
    [errorLabel setFont:[newTitleLabel.font fontWithSize:12]];
    errorLabel.textColor = [UIColor redColor];
    [self.view addSubview:errorLabel];
    
    
    /* Description title label */
    rect = CGRectMake(30.0, 140.0, 100.0, 25.0);
    descTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [descTitleLabel setFont:[descTitleLabel.font fontWithSize:12]];
    descTitleLabel.text = @"Description";
    descTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:descTitleLabel];
    
    
    /* Description text field */
    rect = CGRectMake(25.0, 160.0, 320.0, 30.0);
    descTextField = [[UITextField alloc] initWithFrame:rect];
    descTextField.delegate = self;
    descTextField.borderStyle = UITextBorderStyleLine;
    descTextField.returnKeyType = UIReturnKeyDone;
    descTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    descTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:descTextField];
    
    
    /* Cost title label */
    rect = CGRectMake(30.0, 200.0, 100.0, 25.0);
    costTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [costTitleLabel setFont:[costTitleLabel.font fontWithSize:12]];
    costTitleLabel.text = @"Cost";
    costTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:costTitleLabel];
    
    
    /* Cost text field */
    rect = CGRectMake(25.0, 220.0, 150.0, 30.0);
    costTextField = [[UITextField alloc] initWithFrame:rect];
    costTextField.delegate = self;
    costTextField.borderStyle = UITextBorderStyleLine;
    costTextField.returnKeyType = UIReturnKeyDone;
    costTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    costTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:costTextField];
    
    
    /* Category selector */
    categories = [[NSMutableArray alloc] init];
    [categories addObject:@"Eat Out"];
    [categories addObject:@"Grocery"];
    [categories addObject:@"Gas"];
    [categories addObject:@"Starbucks"];
    [categories addObject:@"Other"];
    
    rect = CGRectMake(190.0, 195.0, 150.0, 80.0);
    categoryPicker = [[UIPickerView alloc] initWithFrame:rect];
    [categoryPicker setDelegate:self];
    [categoryPicker setDataSource:self];
    [self.view addSubview:categoryPicker];
    
    
    /* Date */
    rect = CGRectMake(30.0, 270.0, 100.0, 25.0);
    dateLabel = [[UILabel alloc] initWithFrame:rect];
    [dateLabel setFont:[dateLabel.font fontWithSize:16]];
    [self.view addSubview:dateLabel];
    
    
    /* Date slider */
    currentDateSliderVal = 10;
    rect = CGRectMake(30.0, 290.0, 200.0, 50.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:rect];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0;
    slider.maximumValue = 20.0;
    slider.continuous = YES;
    slider.value = 10;
    [self.view addSubview:slider];
}


- (void)viewWillAppear:(BOOL)animated
{
    NSDateFormatter *df;
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    if (t == nil) {
        newTitleLabel.text = @"New Transaction";
        descTextField.text = @"";
        costTextField.text = @"";
        [categoryPicker selectRow:4 inComponent:0 animated:YES];
        date = [NSDate date];
        dateLabel.text = [df stringFromDate:date];
    }
    else {
        int catIndex;
        
        newTitleLabel.text = @"Edit Transaction";
        descTextField.text = t.desc;
        costTextField.text = [NSString stringWithFormat:@"$%d.%02d",
                                 (int)t.costDollars, (int)t.costCents];
        date = t.date;
        dateLabel.text = [df stringFromDate:date];
        
        catIndex = 4;
        if ([t.category isEqualToString:@"Eat Out"])
            catIndex = 0;
        else if ([t.category isEqualToString:@"Grocery"])
            catIndex = 1;
        else if ([t.category isEqualToString:@"Gas"])
            catIndex = 2;
        else if ([t.category isEqualToString:@"Starbucks"])
            catIndex = 3;
            
        [categoryPicker selectRow:catIndex inComponent:0 animated:YES];
    }
}


- (void)enterButtonClicked
{
    Transaction *tr;
    NSInteger d, c, catRow;
    
    [self.view endEditing:TRUE];

    if ([self checkFormInfo] == FALSE)
        return;
    
    tr = t;
    if (tr == nil) {
        tr = [[Transaction alloc] init];
        //tr.date = [NSDate date];
        
        [dm inputTransaction:tr];
    }
    
    tr.desc = descTextField.text;
    d = c = 0;
    [self strToDollarsAndCents:costTextField.text dollars:&d cents:&c];
    tr.costCents = c;
    tr.costDollars = d;
    catRow = [categoryPicker selectedRowInComponent:0];
    tr.category = [categories objectAtIndex:catRow];
    tr.date = date;

    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (int)strToDollarsAndCents:(NSString *)str dollars:(NSInteger *)d
                                                cents:(NSInteger *)c
{
    int i;
    int dollarSignFlag = 0;
    int centsFlag = 0;
    int error = 0;

    if (str == nil)
        return -1;

    for (i = 0; i < str.length; i++) {
        unichar c = [str characterAtIndex:i];

        if (c == 36 && i == 0 && str.length >= 2) {
            dollarSignFlag = 1;
        }
        else if (c == 46 && str.length >= 3 && i == str.length - 3) {
            centsFlag = 1;
        }
        else if (c >= 48 && c <= 57) {
            ;
        }
        else {
            error = -1;
            break;
        }
    }

    if (error == 0 && (d != NULL || c != NULL)) {
        int dollarStart = 0;
        int dollarLen = 0;
        int centStart = 0;
        int centLen = 0;

        /* $233 */
        if (dollarSignFlag == 1 && centsFlag == 0) {
            dollarStart = 1;
            dollarLen = (int) str.length - 1;
            centStart = 0;
            centLen = 0;
        }
        /* $556.32 */
        else if (dollarSignFlag == 1 && centsFlag == 1) {
            dollarStart = 1;
            dollarLen = (int) str.length - 4;
            centStart = (int) str.length - 2;
            centLen = 2;
        }
        /* 667 */
        else if (dollarSignFlag == 0 && centsFlag == 0) {
            dollarStart = 0;
            dollarLen = (int) str.length;
            centStart = 0;
            centLen = 0;
        }
        /* 87.11 */
        else if (dollarSignFlag == 0 && centsFlag == 1) {
            dollarStart = 0;
            dollarLen = (int) str.length - 3;
            centStart = (int) str.length - 2;
            centLen = 2;
        }
       
        if (d != NULL && dollarLen > 0) {
            NSRange r = NSMakeRange(dollarStart, dollarLen);
            NSString *dollarStr = [str substringWithRange:r];
            *d = [dollarStr integerValue];
        }

        if (c != NULL && centLen > 0) {
            NSRange r = NSMakeRange(centStart, centLen);
            NSString *centStr = [str substringWithRange:r];
            *c = [centStr integerValue];
        }
    }

    return error;
}


- (BOOL)checkFormInfo {
    if (descTextField.text.length == 0
             || [descTextField.text compare:@"Description"] == NSOrderedSame) {
        errorLabel.text = @"Error: Enter a description.";
        return FALSE;
    }

    if (costTextField.text.length == 0
                    || [costTextField.text compare:@"Cost"] == NSOrderedSame) {
        errorLabel.text = @"Error: Enter a cost.";
        return FALSE;
    }
    
    if ([self strToDollarsAndCents:costTextField.text dollars:nil
                                                        cents:nil] < 0) {
        errorLabel.text = @"Error: Check cost format.";
        return FALSE;
    }
    
    errorLabel.text = @"";

    return TRUE;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textfeild {
    if (textfeild == costTextField) {
        if (descTextField.text.length == 0
             || [descTextField.text compare:@"Description"] == NSOrderedSame) {
            [self.view endEditing:FALSE];
            [descTextField becomeFirstResponder];
            return FALSE;
        }
    }
    
    if (textfeild == descTextField) {
        if (costTextField.text.length == 0
                    || [costTextField.text compare:@"Cost"] == NSOrderedSame) {
            [self.view endEditing:FALSE];
            [costTextField becomeFirstResponder];
            return FALSE;
        }
    }
    
    [self.view endEditing:TRUE];
    return TRUE;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == descTextField) {
        if ([descTextField.text compare:@"Description"] == NSOrderedSame)
            descTextField.text = @"";
    }
    else if (textField == costTextField) {
        if ([costTextField.text compare:@"Cost"] == NSOrderedSame)
            costTextField.text = @"";
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
                            numberOfRowsInComponent:(NSInteger)component
{
    return [categories count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView
                             titleForRow:(NSInteger)row
                             forComponent:(NSInteger)component
{
    return [categories objectAtIndex:row];
}


-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    int sliderValue = (int) slider.value;
    
    if (sliderValue != currentDateSliderVal) {
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
 
        if (sliderValue > currentDateSliderVal) {
            NSLog(@"slider value up: %i", sliderValue);
            dayComponent.day = 1;
        }
        else if (sliderValue < currentDateSliderVal) {
            NSLog(@"slider value down: %i", sliderValue);
            dayComponent.day = -1;
        }
        
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent
                                        toDate:date options:0];
        date = nextDate;
        
        NSDateFormatter *df;
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM/dd/yyyy"];
        dateLabel.text = [df stringFromDate:date];
        
        
        currentDateSliderVal = sliderValue;
    }
}
@end
