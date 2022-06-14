// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@opengsn/contracts/src/BaseRelayRecipient.sol";

contract ToDo is BaseRelayRecipient {
  address public owner;

  modifier onlyOwner() {
    require(owner == msg.sender, "");
    _;
  }

  /**
   * Set the trustedForwarder address either in constructor or
   * in other init function in your contract
   */
  constructor(address _trustedForwarder) {
    _setTrustedForwarder(_trustedForwarder);
    owner = msg.sender;
  }

  // todolist
  struct Memo {
    bool completed;
    string todo;
  }

  mapping(address => Memo[]) private _todoList;

  function addToDo(string calldata _todo) public {
    _todoList[_msgSender()].push(Memo(false, _todo));
  }

  function toggleToDoCompleted(uint8 index) public {
    _todoList[_msgSender()][index].completed = !_todoList[_msgSender()][index].completed;
  }

  function deleteToDo(uint8 index) public {
    uint256 end = _todoList[_msgSender()].length - 1;
    for (uint8 i = index; i < end; i++) {
      _todoList[_msgSender()][i] = _todoList[_msgSender()][i + 1];
    }
    _todoList[_msgSender()].pop();
  }

  function todoList() public view returns (Memo[] memory) {
    return _todoList[_msgSender()];
  }

  /**
   * Override this function.
   * This version is to keep track of BaseRelayRecipient you are using
   * in your contract.
   */
  function versionRecipient() external pure override returns (string memory) {
    return "1";
  }

  /**
   * OPTIONAL
   * You should add one setTrustedForwarder(address _trustedForwarder)
   * method with onlyOwner modifier so you can change the trusted
   * forwarder address to switch to some other meta transaction protocol
   * if any better protocol comes tomorrow or current one is upgraded.
   */
  function setTrustForwarder(address _trustedForwarder) public onlyOwner {
    _setTrustedForwarder(_trustedForwarder);
  }
}
