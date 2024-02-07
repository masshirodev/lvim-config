import sys
import re

def process_file(contents):
    pattern = r"(?:public\s+)?(\w+\??)\s*:\s*([\w\[\]]+);"
    dto_types = set()  # Set to store unique DTO types
    used_annotations = set()  # Set to store used annotations

    def replace_func(match):
        nonlocal dto_types, used_annotations
        attribute_name = match.group(1)
        original_attribute_type = match.group(2)

        # Define a list of primitive types
        primitive_types = {'string', 'number', 'boolean', 'object', 'void', 'null', 'undefined', 'any'}

        # Check if the type is an array
        is_array = original_attribute_type.endswith('[]')
        array_suffix = '[]' if is_array else ''
        base_type = original_attribute_type[:-2] if is_array else original_attribute_type

        # Lowercase 'any' type and handle specific annotations
        base_type_lower = base_type.lower()
        annotation = ""
        if base_type_lower == 'any':
            base_type = '{}'
            annotation = "@IsObject({ each: true })"
            used_annotations.add('IsObject')
        elif base_type_lower in primitive_types:
            if base_type_lower == 'string':
                annotation = "@IsString()"
                used_annotations.add('IsString')
            elif base_type_lower == 'number':
                annotation = "@IsNumber()"
                used_annotations.add('IsNumber')
            elif base_type_lower == 'boolean':
                annotation = "@IsBoolean()"
                used_annotations.add('IsBoolean')
            if is_array:
                annotation += "\n    @IsArray()"
                used_annotations.add('IsArray')
        else:
            annotation = "@IsObject({ each: true })"
            used_annotations.add('IsObject')
            if is_array:
                annotation += "\n    @IsArray()"
                used_annotations.add('IsArray')
            base_type += 'Dto'
            dto_types.add(base_type)

        # Format the type name properly
        attribute_type_formatted = base_type[0].upper() + base_type[1:]
        attribute_type_formatted = '{}' if attribute_type_formatted == 'Any' else attribute_type_formatted

        # Constructing the ApiProperty and other annotations string
        api_property = f"@ApiProperty({{ type: {attribute_type_formatted}{', isArray: true' if is_array else ''} }})"
        replacement = f"{api_property}\n    {annotation}\n    {attribute_name}: {base_type}{array_suffix};\n"
        return replacement

    processed_contents = re.sub(pattern, replace_func, contents, flags=re.MULTILINE)

    # Generate the import statements
    import_statements = "import { ApiProperty } from '@nestjs/swagger';\n\n"
    if dto_types:
        sorted_dto_types = sorted(dto_types)
        import_statements += "import {\n    " + ',\n    '.join(sorted_dto_types) + "\n} from '.';\n\n"
    if used_annotations:
        sorted_annotations = sorted(used_annotations)
        import_statements += "import {\n    " + ',\n    '.join(sorted_annotations) + "\n} from 'class-validator';\n\n"
    
    processed_contents = import_statements + processed_contents

    return processed_contents

def main():
    input_contents = sys.stdin.read()
    processed_contents = process_file(input_contents)
    sys.stdout.write(processed_contents)

if __name__ == "__main__":
    main()
