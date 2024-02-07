import sys
import re

def convert_to_snake_case(lines):
    new_lines = []
    for line in lines:
        m = re.search(r'@JsonProperty\("([a-zA-Z0-9]+)"\)', line)
        if m:
            camel_case_str = m.group(1)
            snake_case_str = re.sub(r'([a-z0-9])([A-Z])', r'\1_\2', camel_case_str).lower()
            line = re.sub(r'@JsonProperty\("[a-zA-Z0-9]+"\)', f'@JsonProperty("{snake_case_str}")', line)
        new_lines.append(line)
    return new_lines

if __name__ == "__main__":
    lines = [line.strip() for line in sys.stdin]
    converted_lines = convert_to_snake_case(lines)
    for line in converted_lines:
        print(line)

