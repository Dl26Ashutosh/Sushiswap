//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.6;                                 

// imported required interfaces      

import "@openzeppelin/contracts/access/Ownable.sol";  
import "hardhat/console.sol";                                                                                
import "./libraries/UniswapV2Library.sol";
import  "./libraries/TransferHelper.sol";
import "./interfaces/IUniswapV2Router01.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IERC20.sol";


contract WEB3AM_SUSHISwap is Ownable {

  // factory address and routing address of Sushiswap contract
  address public constant SUSHI_FACTORY = 0xc35DADB65012eC5796536bD9864eD8773aBc74C4;
  address public constant SUSHI_ROUTER =  0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506;

    // event for getting returned value after swap declaration
    event swap_info(address owner,uint256 amount_received);

    // Trade Variables
    uint256 private deadline = block.timestamp + 1 days;
    // uint256 private minimumAmountRequired = 0 ;

  
    // PLACE A TRADE
    // Executed placing a trade
    function placeTrade(
        address _fromToken,
        address _toToken,
        uint256 _amountIn
    ) public returns (uint256) {
        address pair = IUniswapV2Factory(SUSHI_FACTORY).getPair(_fromToken, _toToken);
        require(pair != address(0), "Pool does not exist");

        // Calculate Amount Out
        address[] memory path = new address[](2);
        path[0] = _fromToken;
        path[1] = _toToken;

        uint256 amountRequired = IUniswapV2Router01(SUSHI_ROUTER).getAmountsOut(
            _amountIn,
            path
        )[1];
        // Transfer Token from Wallet to this contract itself

         IERC20(_fromToken).transferFrom(msg.sender, address(this), _amountIn);
         IERC20(_fromToken).approve(SUSHI_ROUTER, _amountIn);

        // Swap for another token
        uint256 amountReceived = IUniswapV2Router01(SUSHI_ROUTER)
            .swapExactTokensForTokens(
                _amountIn, // amountIn
                0, // amountOutMin
                path, // path
                msg.sender, // recieved amount to wallet
                deadline // deadline
            )[1];

        // emiting event swap info of amnound received in n return after swap
        emit swap_info(msg.sender,amountReceived);
        console.log("amountRecieved", amountReceived);
    }
}