#pragma once
#ifdef __cplusplus
#include <string>
#endif
#include "imgui/imgui.h"

class InputTextButton;

@interface TextFieldDelegate : NSObject<UITextFieldDelegate>
{
@public
    InputTextButton* inputTextButton;
}
- (void)textFieldEditingChanged:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

class InputTextButton
{
    
public:
    InputTextButton();
    void setup(std::string initialString);
    void draw();
    void onTextEdit(std::string);
    UITextField* textField;
    TextFieldDelegate* textFieldDelegate;
    std::string text;
};
