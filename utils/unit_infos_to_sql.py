import xmltodict

# Open the XML file
with open('CIV4UnitInfos.xml', 'r') as file:
    # Parse the XML file into a Python dictionary
    xml_dict = xmltodict.parse(file.read())

xml_dict