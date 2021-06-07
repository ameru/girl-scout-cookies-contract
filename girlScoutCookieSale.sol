//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract girlScoutCookieSale {

    struct inventory {
        string sku; //identifier unique to cookie box
        string itemName; 
        string itemDescription;
        uint qty; //available quantity
    }

    //define an enumeration that defines the possible states of the contract
    enum State {Created, Ordered, Locked, Release, Inactive}
    
    //keep track of inventory information in order
    mapping(bytes32 => inventory) cart;

    //Events
    event CallGirlScout(string sku, uint qty, address buyer);
    event ShipOrder(string sku, uint qty, address buyer);

    State public state;
    uint public value;
    uint public price;
    uint public refund;
    uint public expiration_date;
    address payable public girlscout;
    address payable public buyer;
    event Aborted();
    event PurchaseConfirmed();
    event CookiesReceived();
    event GirlScoutRefunded();
    event CartCreated();
    
    modifier onlyBuyer() {
        if(msg.sender != buyer)
            revert("This should be done by buyer.");
        _;
    }
    
    modifier onlyGirlScout() {
        if(msg.sender != girlscout)
            revert("This should be done by girl scout.");
        _;
    }
    
    modifier inState(State _state) {
        if(state != _state)
            revert("The contract is not in the proper state.");
        _;
    }
    
    //make the girlscout the seller address and set the price for a box of cookies
    constructor(uint _expdate) payable {
        require(_expdate * 86400 > 604800, "Cookie must last at least a week.");
        expiration_date = block.timestamp + _expdate * 86400;
        girlscout = payable(msg.sender);
        price = 0.005 ether; //set price of cookies 
    }
    
    //abort the purchase and reclaim the ether (verifying the contract isn't locked)
    function abort() public onlyGirlScout inState(State.Created) {
        state = State.Inactive;
        girlscout.transfer(address(this).balance);
        emit Aborted();
    }
    
    //create the cart by entering a number of boxes for the buyer, then calculating value
    //require that the msg.sender is not the girlscout
    function createCart(uint numBoxes) public inState(State.Created) {
        require(msg.sender != girlscout, "Buyer cannot be seller.");
        value = numBoxes * price;
        buyer = payable(msg.sender);
        state = State.Ordered;
        emit CartCreated();
    }
    
    //confirm the payment is 2x the value to avoid odd numbers
    //then confirm the purchase and set the buyer as the msg.sender
    function confirmPurchase() public payable onlyBuyer inState(State.Ordered) {
        require(msg.value == (2 * value), "Not enough deposited; it should be 2x value.");
        if(block.timestamp > expiration_date)
            revert("Oops! Cookies are staled! Next cookies would be here soon.");
        emit PurchaseConfirmed();
        state = State.Locked;
    }
    
    //confirm the cookies have been received, after verifying the contract is Locked
    //and that the buyer is calling this function
    //then transfer the buyer back the value
    function confirmReceived() public onlyBuyer inState(State.Locked) {
        emit CookiesReceived();
        //change state first to prevent re-entry
        state = State.Release;
        buyer.transfer(value);
    }
    
    //return price entered into the contract plus the value to the girl scout
    function completeTransaction() public onlyGirlScout inState(State.Release) {
        emit GirlScoutRefunded();
        //change state first to prevent re-entry
        state = State.Inactive;
        girlscout.transfer(price);
    }
}
