import os
from optparse import OptionParser

def parse_args():
    parser = OptionParser()
    parser.add_option("-i", "--in_file", action="store", type="string", dest="in_file", default=None, help="Input file")
    parser.add_option("-o", "--out_file", action="store", type="string", dest="out_file", default=None, help="Output file")
    options, _ = parser.parse_args()    
    return options.in_file, options.out_file

def main():
    """Main func"""
    in_file, out_file = parse_args()
    fr = open(in_file, 'r')
    fw = open(out_file, 'a')
    
    for line in fr:
        absolute_path = os.path.abspath(line)
        fw.write(absolute_path)
    pass

if __name__ == '__main__':
    main()
