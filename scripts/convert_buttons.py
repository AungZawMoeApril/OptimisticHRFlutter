import os
import re

def convert_button_options(content):
    # Find FFButtonOptions blocks
    pattern = r'FFButtonWidget\(\s*(?:(?!options:).)*?options:\s*FFButtonOptions\((.*?)\),\s*(?:showLoadingIndicator:\s*false,\s*)?\)'
    matches = re.finditer(pattern, content, re.DOTALL)

    for match in reversed([m for m in matches]):
        full_match = match.group(0)
        options_content = match.group(1)

        # Extract parameters
        text = re.search(r'text:\s*([^,]+),', full_match)
        on_pressed = re.search(r'onPressed:\s*([^,]+),', full_match)
        width = re.search(r'width:\s*([^,]+),', options_content)
        height = re.search(r'height:\s*([^,]+),', options_content)
        color = re.search(r'color:\s*([^,]+),', options_content)
        text_style = re.search(r'textStyle:\s*([^,]+),', options_content)
        border_radius = re.search(r'borderRadius:\s*([^,]+),', options_content)
        elevation = re.search(r'elevation:\s*([^,]+),', options_content)

        # Build AppButton
        app_button = f'AppButton(\n'
        
        if text:
            app_button += f'  text: {text.group(1)},\n'
        if on_pressed:
            app_button += f'  onPressed: {on_pressed.group(1)},\n'
        if width:
            app_button += f'  width: {width.group(1)},\n'
        if height:
            app_button += f'  height: {height.group(1)},\n'
        if color:
            app_button += f'  backgroundColor: {color.group(1)},\n'
        if text_style:
            app_button += f'  textStyle: {text_style.group(1)},\n'
        if border_radius:
            app_button += f'  borderRadius: {border_radius.group(1)},\n'
        if elevation:
            app_button += f'  elevation: {float(elevation.group(1))},\n'

        app_button += ')'

        # Replace in content
        content = content[:match.start()] + app_button + content[match.end():]
    
    return content

def process_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        if 'FFButtonWidget' not in content and 'FFButtonOptions' not in content:
            return

        # Add import
        if '../core/widgets/app_button.dart' not in content:
            import_line = "import '../core/widgets/app_button.dart';\n"
            content = content[:content.find('\n')] + '\n' + import_line + content[content.find('\n')+1:]

        # Convert buttons
        content = convert_button_options(content)

        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)

        print(f'Processed {file_path}')

    except Exception as e:
        print(f'Error processing {file_path}: {e}')

def process_directory(dir_path):
    for root, _, files in os.walk(dir_path):
        for file in files:
            if file.endswith('.dart'):
                process_file(os.path.join(root, file))

if __name__ == '__main__':
    dirs = [
        'lib/leave',
        'lib/overtime', 
        'lib/on_site'
    ]
    
    for dir_path in dirs:
        process_directory(dir_path)