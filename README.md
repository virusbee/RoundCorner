# RoundCorner
Decorate the view with a round layer, four corners can be adjusted individually.

## Usage
```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    contentView.center = self.view.center;
    [self.view addSubview:contentView];
    
    RCConfiguration *config = [[RCConfiguration alloc] init];
    config.cornerMask = RCCornerMaskMaxXMinY | RCCornerMaskMinXMaxY | RCCornerMaskMaxXMaxY;
    config.rect = contentView.bounds;
    config.cornerRadius = 20;
    config.fillColor = UIColor.redColor.CGColor;
    config.strokeColor = UIColor.redColor.CGColor;
    [contentView.layer setRoundCorner:config];
}
```

## Usage For Swift
```
override func viewDidLoad() {
    super.viewDidLoad()
    
    let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    contentView.center = self.view.center
    self.view.addSubview(contentView)
    
    var config = Configuration(rect: contentView.bounds)
    config.cornerMask = [.MaxXMinY, .MinXMaxY, .MaxXMaxY]
    config.cornerRadius = 20
    config.fillColor = UIColor.red.cgColor;
    config.strokeColor = UIColor.red.cgColor
    contentView.layer.setRoundCorner(config: config)
}
```
