import xml.etree.ElementTree as ET
from xml.dom import minidom
from collections import defaultdict


def dict_to_etree(d, root):
    for k, v in d.items():
        if isinstance(v, list):
            for item in v:
                sub_elem = ET.SubElement(root, k)
                dict_to_etree(item, sub_elem)
        elif isinstance(v, dict):
            sub_elem = ET.SubElement(root, k)
            dict_to_etree(v, sub_elem)
        else:
            if k.startswith('@'):
                root.set(k[1:], v)
            elif k == '#text':
                root.text = v
            else:
                sub_elem = ET.SubElement(root, k)
                sub_elem.text = str(v)


def dict_to_xml(d):
    if len(d) != 1:
        raise ValueError("Dictionary must have exactly one root key")

    root_key = next(iter(d))
    root = ET.Element(root_key)
    dict_to_etree(d[root_key], root)
    return root


def xml_to_string(root):
    return ET.tostring(root, encoding='unicode')


def pretty_print_xml(xml_string):
    parsed_xml = minidom.parseString(xml_string)
    return parsed_xml.toprettyxml(indent="    ")


def save_pretty_xml_to_file(xml_string, filename):
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(xml_string)


def read_xml(filepath):
    tree = ET.parse(filepath)
    t = tree.getroot()
    return etree_to_dict(t)


def etree_to_dict(t):
    d = {t.tag: {} if t.attrib else None}
    children = list(t)
    if t.attrib:
        d[t.tag].update(('@' + k, v) for k, v in t.attrib.items())
    if children:
        dd = defaultdict(list)
        for dc in map(etree_to_dict, children):
            for k, v in dc.items():
                dd[k].append(v)
        d[t.tag] = {k: v[0] if len(v) == 1 else v for k, v in dd.items()}
    if t.text:
        text = t.text.strip()
        if children or t.attrib:
            if text:
                d[t.tag]['#text'] = text
        else:
            d[t.tag] = text

    return d
