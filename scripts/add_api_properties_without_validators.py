import sys
import re

def process_file(contents):
    pattern = r"(?:public\s+)?(\w+\??)\s*:\s*([\w\[\]]+);"
    dto_types = set()  # Set to store unique DTO types

    def replace_func(match):
        nonlocal dto_types
        attribute_name = match.group(1)
        original_attribute_type = match.group(2)

        # Define a list of primitive types
        primitive_types = {'string', 'number', 'boolean', 'void', 'null', 'undefined', 'any'}

        # Check if the type is an array
        is_array = original_attribute_type.endswith('[]')
        array_suffix = '[]' if is_array else ''
        base_type = original_attribute_type[:-2] if is_array else original_attribute_type

        # Lowercase 'any' type
        base_type = base_type.lower() if base_type.lower() == 'any' else base_type

        # Append 'Dto' to non-primitive types
        if base_type.lower() not in primitive_types:
            base_type += 'Dto'
            dto_types.add(base_type)

        # Format the type name
        attribute_type_formatted = base_type[0].upper() + base_type[1:]
        attribute_type_formatted = attribute_type_formatted == 'Any' and '{}' or attribute_type_formatted

        # Constructing the ApiProperty string
        if is_array:
            api_property = f"@ApiProperty({{ type: {attribute_type_formatted}, isArray: true }})"
        else:
            api_property = f"@ApiProperty({{ type: {attribute_type_formatted} }})"

        replacement = f"{api_property}\n    {attribute_name}: {base_type}{array_suffix};\n"
        return replacement

    processed_contents = re.sub(pattern, replace_func, contents, flags=re.MULTILINE)

    # Generate the import statement
    if dto_types:
        sorted_dto_types = sorted(dto_types)
        import_statement = "import {\n    " + ',\n    '.join(sorted_dto_types) + "\n} from '.';\n\n"
        processed_contents = import_statement + processed_contents

    return processed_contents

def main():
    input_contents = sys.stdin.read()
    processed_contents = process_file(input_contents)
    sys.stdout.write(processed_contents)

if __name__ == "__main__":
    main()
