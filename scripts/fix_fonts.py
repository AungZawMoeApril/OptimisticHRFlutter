import re

# Read the file
with open('lib/leave/leave_request/leave_request_widget.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match fontFamily: GoogleFonts.xxx(...) and add .fontFamily
# This handles multi-line cases by using DOTALL flag
pattern = r'(fontFamily:\s*GoogleFonts\.\w+\([^)]*\))\s*([,)])'
replacement = r'\1.fontFamily\2'

# Apply the replacement
content = re.sub(pattern, replacement, content, flags=re.DOTALL)

# Also fix remaining 'font:' to 'fontFamily:'
content = re.sub(r'(\s+)font:', r'\1fontFamily:', content)

# Write back
with open('lib/leave/leave_request/leave_request_widget.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed all fontFamily issues")
