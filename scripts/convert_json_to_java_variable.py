import sys
import json

def json_to_java_string(json_str):
    json_obj = json.loads(json_str)
    json_str_escaped = json.dumps(json_obj, indent=2)

    lines = json_str_escaped.split("\n")
    java_lines = ['String jsonString = ']
    first = True
    for line in lines:
        if first:
            first = False
            line = line.replace('"', '\\"')
            java_lines.append('    "' + line + '\\n"')
            continue
        line = line.replace('"', '\\"')
        java_lines.append('  + "' + line + '\\n"')
    java_lines[-1] = java_lines[-1][:-3] + '";'
    
    return "\n".join(java_lines)

if __name__ == "__main__":
    json_str = sys.stdin.read()
    java_string = json_to_java_string(json_str)
    print(java_string)
