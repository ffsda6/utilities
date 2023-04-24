import argparse
import json
import os
import sys

try:
    import requests
except ImportError:
    print("The requests module is not installed. Please run 'pip install requests' to install it.")
    exit()


def help():
    print("Usage: python app.py data_file [-c]\n\n"
          "data_file: The path to the JSON file containing the URI data.\n"
          "           This argument is required.\n"
          "-c:        Optional flag to output results to the console instead of a file.")


if len(sys.argv) < 2 or len(sys.argv) > 3:
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
    parser = argparse.ArgumentParser()
    parser.add_argument('data_file', help='The path to the JSON file containing the URI data.')
    parser.add_argument('-c', '--console', action='store_true', help='Output results to the console instead of a file.')
    args = parser.parse_args()

    if not os.path.exists(args.data_file):
        print(f"Error: {args.data_file} does not exist.")
        help()
        exit()

    with open(args.data_file, 'r') as f:
        data = json.load(f)

    if args.console:
        for item in data:
            if 'uri' in item:
                uri = item['uri']
                if 'androidapp' not in uri:
                    if is_valid_website(uri):
                        print(f"{uri} is a valid website.")
                    else:
                        print(f"{uri} is not a valid website.")
                else:
                    print(f"{uri} contains 'androidapp' and has been excluded.")
    else:
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
