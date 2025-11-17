import re

file_path = r'lib\leave\leave_request\leave_request_widget.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match:
# font: GoogleFonts.xxx( ... ), followed by other params including fontWeight/fontStyle duplicates
pattern = r'(\s+)font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\),(\s+)((?:.*?\n)*?)(\s+)(fontWeight:[^,]*,\s*)((?:.*?\n)*?)(\s+)(fontStyle:[^,]*,\s*)'

def replace_func(match):
    indent1 = match.group(1)
    font_name = match.group(2)
    indent2 = match.group(3)
    middle_content = match.group(4)
    # Remove the duplicate fontWeight and fontStyle, keep the middle content
    return f"{indent1}fontFamily: GoogleFonts.{font_name}().fontFamily,{indent2}{middle_content}"

content = re.sub(pattern, replace_func, content, flags=re.MULTILINE | re.DOTALL)

# Also handle simpler cases where font: is just followed by GoogleFonts without the full pattern
# Replace remaining "font:" with "fontFamily:" and add ".fontFamily" after the closing paren
simple_pattern = r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\(\s*\)'
content = re.sub(simple_pattern, r'fontFamily: GoogleFonts.\1().fontFamily', content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed font parameters")
