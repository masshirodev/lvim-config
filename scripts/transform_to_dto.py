import sys
import re
import subprocess

def transform_class_declaration(contents):
    # Add the import statement at the beginning of the file
    contents = "import { ApiProperty } from \"@nestjs/swagger\";\n\n" + contents

    # Regex to match the class declaration line
    class_pattern = r"class (\w+) \{"

    def class_replace_func(match):
        class_name = match.group(1)
        # Transform the class declaration
        return f"class {class_name}Dto implements {class_name} {{"

    # Replace the class declaration
    transformed_contents = re.sub(class_pattern, class_replace_func, contents, flags=re.MULTILINE)
    return transformed_contents

def add_api_properties(contents):
    # Call the add_api_properties.py script
    process = subprocess.Popen(['python3', '/home/masshiro/.config/lvim/scripts/add_api_properties.py'],
                               stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    output, error = process.communicate(input=contents)

    if process.returncode != 0:
        raise Exception(f"Error in add_api_properties.py: {error}")

    return output

def main():
    # Read all input from stdin as a single string
    input_contents = sys.stdin.read()

    # Transform the class declaration and prepend the import statement
    transformed_contents = transform_class_declaration(input_contents)

    # Apply the add_api_properties.py script
    final_output = add_api_properties(transformed_contents)

    # Output the final transformed contents
    sys.stdout.write(final_output)

if __name__ == "__main__":
    main()
