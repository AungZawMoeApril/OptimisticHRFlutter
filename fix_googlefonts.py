import re

file_path = r'lib\leave\leave_request\leave_request_widget.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match: font: GoogleFonts.xxx( ... )
pattern = r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\('

# Count matches before replacement
matches = re.findall(pattern, content)
print(f'Found {len(matches)} GoogleFonts font: occurrences')

# Replace 'font: GoogleFonts.xxx(...)' with 'fontFamily: GoogleFonts.xxx().fontFamily'
content_new = re.sub(
    r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\)',
    r'fontFamily: GoogleFonts.\1().fontFamily',
    content
)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content_new)

print('Fixed all GoogleFonts font: parameters')
