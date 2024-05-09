// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

library AILib {
    function inference(bytes32 model_address, bytes memory input_data, uint256 output_size) internal view returns (bytes memory) {
        bytes memory input = mergeInput(model_address, input_data, output_size);
        uint256 len = input.length;
        bytes memory output = new bytes(output_size);
        uint256 retLen = 32 + output_size;
        assembly {
            // call the precompiled contract opmlInference (0xa1)
            let success := staticcall(gas(), 0xa1, add(input, 0x20), len, output, retLen)
            
            // check if call was succesfull, else revert
            if iszero(success) {
                revert(0,0)
            }
        }
        return output;
    }

    function mergeInput(bytes32 model_address, bytes memory input_data, uint256 output_size) internal pure returns (bytes memory) {
        bytes32 output_size_bytes = bytes32(output_size);
        bytes memory merged = new bytes(model_address.length + output_size_bytes.length + input_data.length );

        uint k = 0;
        for (uint i = 0; i < model_address.length; i++) {
            merged[k] = model_address[i];
            ++k;
        }

        for (uint i = 0; i < output_size_bytes.length; i++) {
            merged[k] = output_size_bytes[i];
            ++k;
        }

        for (uint i = 0; i < input_data.length; i++) {
            merged[k] = input_data[i];
            ++k;
        }

        return merged;
    }
}