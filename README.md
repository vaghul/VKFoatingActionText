# VKFoatingActionText
A Floating TextField Menu For List of Input

![alt Could Not Load Image](https://github.com/vaghul/VKFoatingActionText/blob/master/FloatingTextMenu/Media/zcdfo.gif)

## Using this in your project

- Import the VKFloatingActionText to your project
- Use VKFloatingActionText.h 

## Also Available in Pods
- pod 'VKFloatingActionText'

**Initialize the button and add it as a subview**
```
VKFloatingActionText *floatButton = [[VKFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"]];
```

**Add Images and TextField PlaceHolders for the Menu Action**
```
floatButton.menuButttonImages = @[@"fb-icon",@"twitter-icon",@"google-icon",@"linkedin-icon"];
floatButton.menuTextFieldDesc = @[@"Facebook",@"Twitter",@"Google Plus",@"Linked in"];
```
**Use Delegate to handle actions**
```
-(void)didClickOnMenuAtIndex:(NSInteger)index andValue:(NSString *)value
```
**Contributing**

I'd love to see your ideas for improving this Control! The best way to contribute is by submitting a pull request. I'll do my best to respond to your patch as soon as possible. You can also submit a [new Github issue](https://github.com/vaghul/VKFoatingActionText/issues/new) if you find bugs or have questions. :octocat:

##License
MIT License
