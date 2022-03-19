pragma solidity ^0.8.0;

contract Bank{
    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customerBalance; // Mappings are like Objects in JS, 
									  // Dictionaries in Python

    constructor(){ 
        bankOwner = msg.sender;
	// The constructor is only executen once, when the contract deploys,
	// and we want the address that executes the contract to be the only
	// owner of that contract and saved permanently to the blockchain.
    }

    function depositMoney() public payable {
        require(msg.value!=0, "You need to deposit some amount of money!");
        customerBalance[msg.sender] += msg.value;
	//public: Everyone can access
	//private: Can be accessed only from within this contract
	//internal: Only this contract and contracts deriving from it can access
	//external: Can not be accessed internally, only externally (saves gas)
    }

    function setBankName(string memory _name) external
 {
     require(
         msg.sender == bankOwner,
         "You must be the owner to set the name of the bank"
     );
     bankName = _name;
 }

    function withdrawMoney(address payable _to, uint256 _total) public{
        require(
            _total <= customerBalance[msg.sender],
            "You have insuffient funds to withdraw"
        );

        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function getCustomerBalance() external view returns (uint256) {
        return customerBalance[msg.sender];
    }

    function getBankBalance() public view returns (uint256) {
        require(
            msg.sender == bankOwner,
            "You must be the owner of the bank to see all balances."
        );
        return address(this).balance;
    }



}
