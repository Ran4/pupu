
import argparse

VERSION_NUMBER = "0.0.1"

def get_parser():
    """Creates a command line parser using argparse"""
    parser = argparse.ArgumentParser(description="")
    
    parser.add_argument("-v", "--verbose", action="store_true",
        help="Will be extra verbose")
    
    parser.add_argument("-V", "--version", type=str, nargs="+",
        default=[None, None],
        choices=self.VALID_VERSIONS + ["all", "hypgen", "gen"],
        help="Shows program version ({})".format(VERSION_NUMBER))
    
    return parser

def main():
    pass

if __name__ == "__main__":
    main()
