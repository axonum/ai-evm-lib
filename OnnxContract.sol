// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

import "./AILib.sol";

contract OnnxContract {
    event OnnxInference(bytes model, bytes input, bytes output);

    function onnxInference(bytes memory model, bytes memory input, uint256 output_size) public returns (bytes memory) {
        bytes memory output = AILib.onnxInference(model, input, output_size);
        emit OnnxInference(model, input, output);
        return output;
    }
}