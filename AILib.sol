// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <=0.8.23;

library AILib {
    function inference(bytes32 model_address, bytes memory input_data, uint256 output_size) internal view returns (bytes memory) {
        bytes memory input = mergeBytes(model_address, input_data);
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

    function mergeBytes(bytes32 param1, bytes memory param2) internal pure returns (bytes memory) {
        bytes memory merged = new bytes(param1.length + param2.length);

        uint k = 0;
        for (uint i = 0; i < param1.length; i++) {
            merged[k] = param1[i];
            k++;
        }

        for (uint i = 0; i < param2.length; i++) {
            merged[k] = param2[i];
            k++;
        }
        return merged;
    }
}