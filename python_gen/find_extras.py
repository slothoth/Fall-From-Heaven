def extract_quoted_items(filename):
    # Dictionary to store counts of unique quoted items
    quoted_items = {}

    try:
        with open(filename, 'r') as file:
            content = file.read()

        # Import re for regular expressions
        import re

        # Find all text between single quotes
        # Pattern matches text between single quotes, handling escaped quotes
        pattern = r"'([^'\\]*(?:\\.[^'\\]*)*)'"
        matches = re.findall(pattern, content)

        # Count unique occurrences
        for item in matches:
            quoted_items[item] = quoted_items.get(item, 0) + 1

        return quoted_items

    except FileNotFoundError:
        return f"Error: File '{filename}' not found"
    except Exception as e:
        return f"Error occurred: {str(e)}"


# Example usage
if __name__ == "__main__":
    filename = "../Icons/UnitIcons.sql"  # Replace with your file name
    result = extract_quoted_items(filename)

    if isinstance(result, dict):
        print(f"\nFound {len(result)} unique quoted items:")
        for item, count in result.items():
            if count > 1 and 'SLTH_UNIT_' in item:
                print(f"'{item}': {count} time(s)")
    else:
        print(result)