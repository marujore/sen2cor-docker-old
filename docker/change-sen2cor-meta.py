import sys
# import lxml.etree as ET # This lib can be used to maintain xml atributes order. However is one more dependency.
from xml.etree import ElementTree


class CommentedTreeBuilder(ElementTree.TreeBuilder):
    """A XML Tree builder that maintains the comments"""

    def comment(self, data):
        self.start(ElementTree.Comment, {})
        self.data(data)
        self.end(ElementTree.Comment)


def write_sen2cor_xml(treeObject, filepath, encoding):
    """Write a .xml file following sen2cor patterns (xml header using double quotes and empty space at end of the file).
    Args:
        treeObject (str): The tree object to write.
        filepath (str): Path to the .xml file to be written.
        encoding (str): Encoding of the file.
    """

    # xml_str = (f'<?xml version="1.0" encoding="{encoding}"?>\n'.encode() + ET.tostring(tree, method='xml') + '\n'.encode())
    xml_str = (f'<?xml version="1.0" encoding="{encoding}"?>\n'.encode() + ElementTree.tostring(treeObject.getroot() , method='xml') + '\n'.encode())
    with open(filepath, 'wb') as xml_file:
        xml_file.write(xml_str)


def main(xml_path, encoding='UTF-8'):
    """Change Sen2cor Params .xml file"""

    try:
        parser = ElementTree.XMLParser(target=CommentedTreeBuilder())

        # Obtain Parameters from the command line
        sen2cor_params = {}
        for arg in sys.argv[2:]:
            if '=' in arg:
                sep = arg.find('=')
                key, value = arg[:sep], arg[sep + 1:]
                sen2cor_params[key] = value

        xml_sen2cor = xml_path
        # tree = ET.parse(xml_sen2cor)
        tree = ElementTree.parse(xml_sen2cor, parser)

        for param in sen2cor_params:
            try:
                print(f"Changing {param} from {tree.find(f'.//{param}').text} to {sen2cor_params[param]}")
                tree.find(f'.//{param}').text = sen2cor_params[param]
            except:
                print(f"Error while trying '{param}' Parameter. Usage: <key1=value1> <key2=value2> ...")
                sys.exit(1)

        write_sen2cor_xml(tree, xml_path, encoding)

        sys.exit(0)

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main(sys.argv[1])
