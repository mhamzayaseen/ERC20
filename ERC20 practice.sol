// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
      event newPrices (address purchaseBuy ,uint price);
    event mintToken (address tokenMint ,uint amount);
     event tokenBuy (address tokenBuy ,uint price);

       error ownerCannotBuyToken();
    error enterCorrectPrice();
    error priceCannotzero();

    constructor()payable ERC20("MyToken", "MTK") {

    }
      

    function mint( uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
         emit mintToken(msg.sender, amount);
    }
    uint tokenPrice=1 ether;
 
    function buyToken()public payable{
    
   if(owner()==msg.sender){
      revert ownerCannotBuyToken();}
   if(msg.value != tokenPrice){
          revert enterCorrectPrice();
      
   }
_transfer(owner(),msg.sender,1);
payable(owner()).transfer(tokenPrice);
emit tokenBuy(msg.sender, tokenPrice);
    }
   
    function changePrice(uint newPrice)public onlyOwner {
if(newPrice>=0){
    revert priceCannotzero();
}
tokenPrice=newPrice;
emit newPrices(msg.sender, newPrice);
    }
    }
