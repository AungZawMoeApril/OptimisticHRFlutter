import os
import re

def convert_file(file_path):
    print(f'Processing {file_path}')
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Add AppButton import if needed
    if 'AppButton' not in content and '../core/widgets/app_button.dart' not in content:
        import_line = "import '../core/widgets/app_button.dart';\n"
        first_newline = content.find('\n')
        content = content[:first_newline] + '\n' + import_line + content[first_newline:]

    # Replace button pattern
    pattern = r'AppButton\(\s*onPressed:\s*([^,]+?),\s*text:\s*([^,]+?),\s*options:\s*FFButtonOptions\(\s*width:\s*([^,]+?),\s*height:\s*([^,]+?),\s*padding:\s*[^,]+?,\s*iconPadding:\s*[^,]+?,\s*color:\s*([^,]+?),\s*textStyle:\s*([^,]+?),\s*elevation:\s*([^,]+?),\s*borderSide:\s*BorderSide\([^)]+\),\s*borderRadius:\s*([^,]+?),(?:\s*disabledColor:\s*[^,]+?,)?(?:\s*disabledTextColor:\s*[^,]+?)?\s*\),(?:\s*showLoadingIndicator:\s*false,)?\s*\)'

    def replace_button(match):
        onPressed = match.group(1).strip()
        text = match.group(2).strip() 
        width = match.group(3).strip()
        height = match.group(4).strip()
        color = match.group(5).strip()
        text_style = match.group(6).strip()
        elevation = match.group(7).strip()
        border_radius = match.group(8).strip()

        return f'''AppButton(
  onPressed: {onPressed},
  text: {text},
  width: {width},
  height: {height},
  backgroundColor: {color},
  textStyle: {text_style},
  borderRadius: {border_radius},
  showBorder: false,
  elevation: {elevation},
)'''

    content = re.sub(pattern, replace_button, content)

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    file_path = r'c:\Users\rain\Downloads\HRoptimisticDev-Flutter\HRoptimisticDev-flutterflow\lib\overtime\overtime_request_main\overtime_request_main_widget.dart'
    convert_file(file_path)