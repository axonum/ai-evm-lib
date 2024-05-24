// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <=0.8.23;

import "./AILib.sol";

contract OnnxContract {
    event OnnxInference(bytes model, bytes input, bytes output);

    function onnxInference(bytes memory model, bytes memory input) public {
        bytes memory output = AILib.onnxInference(model, input);
        emit OnnxInference(model, input, output);
    }
}