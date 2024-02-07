import sys
import re

def process_file(contents):
    # This regex matches class attributes, including optional ones and array types
    # It looks for lines starting with 'public', followed by an optional attribute name and type
    # pattern = r"public\s+(\w+\??)\s*:\s*([\w\[\]]+);"
    pattern = r"(?:public\s+)?(\w+\??)\s*:\s*([\w\[\]]+);"

    def replace_func(match):
        # Extracting the matched groups
        attribute_name = match.group(1)
        attribute_type = match.group(2)

        # Check if the type is an array and adjust the type and decorator accordingly
        if attribute_type.endswith('[]'):
            attribute_type_formatted = attribute_type[:-2]
            attribute_type_formatted = attribute_type_formatted[0].upper() + attribute_type_formatted[1:]
            api_property = f"@ApiProperty({{ type: {attribute_type_formatted}, isArray: true }})"
        else:
            attribute_type_formatted = attribute_type[0].upper() + attribute_type[1:]
            api_property = f"@ApiProperty({{ type: {attribute_type_formatted} }})"



        # Constructing the replacement string
        replacement = f"{api_property}\n    {attribute_name}: {attribute_type};\n"
        return replacement

    # Using re.sub() to replace the pattern in the entire file content
    return re.sub(pattern, replace_func, contents, flags=re.MULTILINE)

def main():
    # Read all input from stdin as a single string
    input_contents = sys.stdin.read()

    # Process the entire file contents
    processed_contents = process_file(input_contents)

    # Output the processed contents
    sys.stdout.write(processed_contents)

if __name__ == "__main__":
    main()
