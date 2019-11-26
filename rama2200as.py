from typing import List, Dict

import argparse


def to_intel_hex(memory: List[int], width: int) -> str:
    """
    Converts list of ints to intel hex format in str
    :param memory:
    :param width:
    :return:
    """
    record_type = "00"
    output = ""
    for address, data in enumerate(memory):
        hex_data = f"{data:08X}".zfill(width)

        checksum = width // 2
        lol_address = address
        while lol_address > 0:
            checksum = checksum + lol_address & 0xff
            lol_address = lol_address >> 8

        while data > 0:
            checksum = checksum + data & 0xff
            data = data >> 8

        checksum = (-checksum) & 0xff

        line = f":{(width // 2):02X}{address:04X}{record_type}{hex_data}{checksum:02X}\n"
        output += line
    output += ":00000001FF\n"
    return output


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='RAMA2200 assembler')
    parser.add_argument("-o", required=True, type=str, metavar='output')
    parser.add_argument('file', type=str)

    args = parser.parse_args()

    filename = args.file

    memory = []
    with open(f'{filename}', 'r') as hex_file:
        lines = hex_file.readlines()
        memory = [int(line.strip(), 16) for line in lines]

    with open(f'{args.o}.hex', 'w') as seqFile:
        data_width = 8
        seqFile.write(to_intel_hex(memory, data_width))
        seqFile.flush()
