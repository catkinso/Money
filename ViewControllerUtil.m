#import "ViewControllerUtil.h"
#import "DataManager.h"

@implementation ViewControllerUtil
{   DataManager *dm;
    
    UILabel *statusLabel;
    
    UIButton *backButton;
    UIButton *saveProductionButton;
    UIButton *loadProductionButton;
    UIButton *saveDevelopmentButton;
    UIButton *loadDevelopmentButton;
}

- (id)initWithDataManager:(DataManager *)dataMgr
{
    self = [super init];
    
    if (self) {
        dm = dataMgr;

        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    
    return self;
}


- (void)viewDidLoad
{
    CGRect rect;
    CAShapeLayer *rectLayer;
    
    UILabel *utilitiesTitleLabel;
    UILabel *plistTitleLabel;
    UILabel *developmentPListLabel;
    UILabel *productionPListLabel;

    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    /* Utilities label */
    rect = CGRectMake(30.0, 40.0, 100.0, 35.0);
    utilitiesTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [utilitiesTitleLabel setFont:[utilitiesTitleLabel.font fontWithSize:28]];
    utilitiesTitleLabel.text = @"Utilities";
    [self.view addSubview:utilitiesTitleLabel];
    
    
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


    /* PList box */
    rect = CGRectMake(25.0, 200.0, 320.0, 100.0);
    rectLayer = [CAShapeLayer layer];
    [rectLayer setPath:[[UIBezierPath bezierPathWithRect:rect] CGPath]];
    [rectLayer setFillColor:[[UIColor clearColor] CGColor]];
    [rectLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [[self.view layer] addSublayer:rectLayer];

    
    /* PList label */
    rect = CGRectMake(30.0, 180.0, 100.0, 25.0);
    plistTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [plistTitleLabel setFont:[plistTitleLabel.font fontWithSize:12]];
    plistTitleLabel.text = @"Data PList";
    plistTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:plistTitleLabel];
    
    
    /* Development plist label */
    rect = CGRectMake(30.0, 220.0, 120.0, 25.0);
    developmentPListLabel = [[UILabel alloc] initWithFrame:rect];
    developmentPListLabel.text = @"Development";
    [self.view addSubview:developmentPListLabel];

    
    /* Production plist label */
    rect = CGRectMake(30.0, 250.0, 120.0, 25.0);
    productionPListLabel = [[UILabel alloc] initWithFrame:rect];
    productionPListLabel.text = @"Production";
    [self.view addSubview:productionPListLabel];
    
    
    /* Save development plist button */
    rect = CGRectMake(300.0, 220.0, 50.0, 25.0);
    saveDevelopmentButton = [[UIButton alloc] initWithFrame:rect];
    [saveDevelopmentButton addTarget:self
                               action:@selector(saveDevelopmentButtonClicked)
                               forControlEvents:UIControlEventTouchUpInside];
    [saveDevelopmentButton setTitle:@"Save" forState:UIControlStateNormal];
    saveDevelopmentButton.contentHorizontalAlignment
                              = UIControlContentHorizontalAlignmentLeft;
    [saveDevelopmentButton setTitleColor:[UIColor blueColor]
                               forState:UIControlStateNormal];
    [saveDevelopmentButton setTitleColor:[UIColor grayColor]
                               forState:UIControlStateHighlighted];
    [self.view addSubview:saveDevelopmentButton];
    
    
    /* Load development plist button */
    rect = CGRectMake(230.0, 220.0, 50.0, 25.0);
    loadDevelopmentButton = [[UIButton alloc] initWithFrame:rect];
    [loadDevelopmentButton addTarget:self
                               action:@selector(loadDevelopmentButtonClicked)
                               forControlEvents:UIControlEventTouchUpInside];
    [loadDevelopmentButton setTitle:@"Load" forState:UIControlStateNormal];
    loadDevelopmentButton.contentHorizontalAlignment
                              = UIControlContentHorizontalAlignmentLeft;
    [loadDevelopmentButton setTitleColor:[UIColor blueColor]
                               forState:UIControlStateNormal];
    [loadDevelopmentButton setTitleColor:[UIColor grayColor]
                               forState:UIControlStateHighlighted];
    [self.view addSubview:loadDevelopmentButton];

    
    /* Save production plist button */
    rect = CGRectMake(300.0, 250.0, 50.0, 25.0);
    saveProductionButton = [[UIButton alloc] initWithFrame:rect];
    [saveProductionButton addTarget:self
                              action:@selector(saveProductionButtonClicked)
                              forControlEvents:UIControlEventTouchUpInside];
    [saveProductionButton setTitle:@"Save" forState:UIControlStateNormal];
    saveProductionButton.contentHorizontalAlignment
                             = UIControlContentHorizontalAlignmentLeft;
    [saveProductionButton setTitleColor:[UIColor blueColor]
                              forState:UIControlStateNormal];
    [saveProductionButton setTitleColor:[UIColor grayColor]
                              forState:UIControlStateHighlighted];
    [self.view addSubview:saveProductionButton];
    
    
    /* Load production plist button */
    rect = CGRectMake(230.0, 250.0, 50.0, 25.0);
    loadProductionButton = [[UIButton alloc] initWithFrame:rect];
    [loadProductionButton addTarget:self
                              action:@selector(loadProductionButtonClicked)
                              forControlEvents:UIControlEventTouchUpInside];
    [loadProductionButton setTitle:@"Load" forState:UIControlStateNormal];
    loadProductionButton.contentHorizontalAlignment
                             = UIControlContentHorizontalAlignmentLeft;
    [loadProductionButton setTitleColor:[UIColor blueColor]
                              forState:UIControlStateNormal];
    [loadProductionButton setTitleColor:[UIColor grayColor]
                              forState:UIControlStateHighlighted];
    [self.view addSubview:loadProductionButton];

    
    /* Status label */
    rect = CGRectMake(30.0, 270.0, 240.0, 25.0);
    statusLabel = [[UILabel alloc] initWithFrame:rect];
    [statusLabel setFont:[plistTitleLabel.font fontWithSize:12]];
    [self.view addSubview:statusLabel];
}


- (void)saveDevelopmentButtonClicked
{
    NSString *s;
    
    [dm saveData:&s plistName:@"dev.plist"];
    statusLabel.text = s;
}


- (void)loadDevelopmentButtonClicked
{
    NSString *s;
    
    [dm loadData:&s plistName:@"dev.plist"];
    statusLabel.text = s;
}


- (void)saveProductionButtonClicked
{
    NSString *s;
    
    [dm saveData:&s plistName:@"prod.plist"];
    statusLabel.text = s;
}


- (void)loadProductionButtonClicked
{
    NSString *s;
    
    [dm loadData:&s plistName:@"prod.plist"];
    statusLabel.text = s;
}


- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
