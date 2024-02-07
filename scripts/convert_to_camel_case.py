import sys
import re

def convert_to_camel_case(lines):
    new_lines = []
    for line in lines:
        m = re.search(r'@JsonProperty\("([a-z0-9_]+)"\)', line)
        if m:
            snake_case_str = m.group(1)
            camel_case_str = re.sub(r'_([a-z])', lambda x: x.group(1).upper(), snake_case_str)
            line = re.sub(r'@JsonProperty\("[a-z0-9_]+("\))', f'@JsonProperty("{camel_case_str}\\1', line)
        new_lines.append(line)
    return new_lines

if __name__ == "__main__":
    lines = [line.strip() for line in sys.stdin]
    converted_lines = convert_to_camel_case(lines)
    for line in converted_lines:
        print(line)
