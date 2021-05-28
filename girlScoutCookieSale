//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract girlScoutCookieSale {
    
    //define an enumeration that defines the possible states of the contract
    enum State {Created, Locked, Release, Inactive}
    
    State public state;
    uint public value;
    address payable public girlscout;
    address payable public buyer;
    event Aborted();
    event PurchaseConfirmed();
    event CookiesReceived();
    event GirlScoutRefunded();
    
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
    
    constructor() payable {
        girlscout = payable(msg.sender);
        value = msg.value / 2;
        if((value * 2) != msg.value)
            revert("Invalid value provided. Submit double the value (even number).");
    }
    
    //abort the purchase and reclaim the ether (verifying the contract isn't locked)
    function abort() public onlyGirlScout inState(State.Created) {
        state = State.Inactive;
        girlscout.transfer(address(this).balance);
        emit Aborted();
    }
    
    //confirm the purchase for buyer, 2x value given, contract is locked
    function confirmPurchase() public payable inState(State.Created) {
        require(msg.value == (2 * value), "Not enough deposited.");
        emit PurchaseConfirmed();
        buyer = payable(msg.sender);
        state = State.Locked;
    }
    
    //confirm the cookies have been received, after verifying the contract is Locked
    //and that the buyer is calling this function
    function confirmReceived() public onlyBuyer inState(State.Locked) {
        emit CookiesReceived();
        //change state first to prevent re-entry
        state = State.Release;
        buyer.transfer(value);
    }
    
    //return the initial investment plus the price of the cookies to the girl scout
    function refundSeller() public onlyGirlScout inState(State.Release) {
        emit GirlScoutRefunded();
        //change state first to prevent re-entry
        state = State.Inactive;
        girlscout.transfer(3 * value);
    }
    
}
