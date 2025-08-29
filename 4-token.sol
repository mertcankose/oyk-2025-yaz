// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function totalSupply() external view returns(uint);
    function balanceOf(address _account) external view returns(uint);
    function transfer(address _recipient, uint256 amount) external returns(bool);
    function transferFrom(address _sender, address _recipient, uint256 _amount) external returns(bool);
    function approve(address _spender, uint256 _amount) external returns(bool);
    function allowance(address _owner, address _spender) external view returns(uint);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract MertcanToken is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    modifier onlyOwner() {
        require(msg.sender == owner, "sen owner degilsin!");
        _;
    }
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        owner = msg.sender;
        balanceOf[msg.sender] = _totalSupply; // 1000000
    }
    function transfer(address _recipient, uint256 _amount) external returns(bool) {
        require(balanceOf[msg.sender] <= _amount, "bakiye yetersiz");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(msg.sender, _recipient, _amount);
        return true;
    }
    function approve(address _spender, uint256 _amount) external returns(bool) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
    function transferFrom(address _sender, address _recipient, uint256 _amount) external returns(bool) {
        require(allowance[_sender][msg.sender] >= _amount);
        allowance[_sender][msg.sender] -= _amount;
        balanceOf[_sender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(_sender, _recipient, _amount);
        return true;
    }
}
