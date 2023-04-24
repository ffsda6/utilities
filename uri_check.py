import json
import os
import sys

try:
    import requests
except ImportError:
    print("The requests module is not installed. Please run 'pip install requests' to install it.")
    exit()


def help():
    print("Usage: python app.py data_file\n\n"
          "data_file: The path to the JSON file containing the URI data.\n"
          "           This argument is required.")


if len(sys.argv) != 2:
    help()
    exit()

if not os.access('.', os.W_OK):
    print("You do not have write permissions for the current directory. Please check your permissions and try again.")
    exit()


def is_valid_website(uri):
    """
    This function takes a URI and tests whether it's a valid website
    """
    try:
        response = requests.get(uri)
        if response.status_code == 200:
            return True
        else:
            return False
    except:
        return False


if __name__ == '__main__':
    data_file = sys.argv[1]

    if not os.path.exists(data_file):
        print(f"Error: {data_file} does not exist.")
        help()
        exit()

    with open(data_file, 'r') as f:
        data = json.load(f)

    with open('results.txt', 'w') as f:
        for item in data:
            if 'uri' in item:
                uri = item['uri']
                if 'androidapp' not in uri:
                    if is_valid_website(uri):
                        f.write(f"{uri} is a valid website.\n")
                    else:
                        f.write(f"{uri} is not a valid website.\n")
                else:
                    f.write(f"{uri} contains 'androidapp' and has been excluded.\n")

    print("Results have been saved to results.txt.")
