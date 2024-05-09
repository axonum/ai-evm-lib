// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

import "./AILib.sol";

contract AIContract {
    event Inference(bytes32 model_address, bytes input_data, uint256 output_size, bytes output);

    function inference(bytes32 model_address, bytes memory input_data, uint256 output_size) public {
        bytes memory output = AILib.inference(model_address, input_data, output_size);
        emit Inference(model_address, input_data, output_size, output);
    }
}